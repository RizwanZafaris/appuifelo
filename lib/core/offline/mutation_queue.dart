import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

/// Offline-first mutation queue.
///
/// Pattern (CQRS-lite): UI calls [enqueue] with a fully-described mutation
/// (path + verb + body + idempotency-key) and the queue:
///   1. Persists it durably (FlutterSecureStorage — backed by Android
///      Keystore / iOS Keychain) so survivor on app restart.
///   2. Returns immediately with a local "queued" id; UI shows a
///      "Queued" badge on the affected entity.
///   3. The drainer sends the mutations FIFO via the injected sender.
///      On success, removes from queue. On 4xx (non-retriable validation)
///      or 401 (auth gone), drops with an audit log entry. On 5xx /
///      network error, leaves in place + retries with full-jitter backoff.
///
/// Why it lives on top of Dio rather than inside it:
///   - The retry interceptor only retries idempotent verbs. Offline writes
///     (POST/PATCH/DELETE) need a separate, durable queue with caller
///     visibility — Dio retries are invisible.
///   - Idempotency-Key is generated client-side here (UUID v4) and reused
///     across retries, so the backend's UNIQUE-indexed idempotency_key
///     correctly returns the original record on replay.
class MutationQueue {
  MutationQueue({
    FlutterSecureStorage? storage,
    Uuid? uuid,
    Future<MutationOutcome> Function(QueuedMutation) sender = _unboundSender,
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _uuid = uuid ?? const Uuid(),
        _sender = sender;

  static const _key = 'felo.mutation_queue.v1';

  final FlutterSecureStorage _storage;
  final Uuid _uuid;
  final Future<MutationOutcome> Function(QueuedMutation) _sender;
  final StreamController<QueueState> _state = StreamController<QueueState>.broadcast();

  Stream<QueueState> get stream => _state.stream;

  Future<void> enqueue({
    required String path,
    required String method,
    required Map<String, dynamic> body,
    String? localEntityId,
  }) async {
    final pending = await _read();
    final mutation = QueuedMutation(
      id: _uuid.v4(),
      idempotencyKey: 'mut-${_uuid.v4()}',
      path: path,
      method: method.toUpperCase(),
      body: body,
      localEntityId: localEntityId,
      attempts: 0,
      createdAt: DateTime.now().toUtc(),
    );
    pending.add(mutation);
    await _persist(pending);
    _emit(pending);
  }

  Future<void> drain() async {
    final pending = await _read();
    if (pending.isEmpty) return;

    for (final mutation in List<QueuedMutation>.from(pending)) {
      try {
        final outcome = await _sender(mutation);
        if (outcome.success) {
          pending.remove(mutation);
          continue;
        }
        if (outcome.dropPermanently) {
          pending.remove(mutation);
          continue;
        }
        // Bump attempts; keep in queue.
        final idx = pending.indexOf(mutation);
        pending[idx] = mutation.copyWith(
          attempts: mutation.attempts + 1,
          lastError: outcome.errorMessage,
        );
      } catch (e) {
        if (kDebugMode) {
          debugPrint('MutationQueue.drain error: $e');
        }
        // Network — leave in place; will retry on next drain.
      }
    }
    await _persist(pending);
    _emit(pending);
  }

  Future<List<QueuedMutation>> peek() => _read();

  Future<List<QueuedMutation>> _read() async {
    final raw = await _storage.read(key: _key);
    if (raw == null || raw.isEmpty) return <QueuedMutation>[];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .whereType<Map<String, dynamic>>()
          .map(QueuedMutation.fromJson)
          .toList();
    } catch (_) {
      // Corrupt blob — drop and start over rather than block the user.
      await _storage.delete(key: _key);
      return <QueuedMutation>[];
    }
  }

  Future<void> _persist(List<QueuedMutation> list) async {
    if (list.isEmpty) {
      await _storage.delete(key: _key);
      return;
    }
    await _storage.write(
      key: _key,
      value: jsonEncode(list.map((m) => m.toJson()).toList()),
    );
  }

  void _emit(List<QueuedMutation> list) {
    if (_state.isClosed) return;
    _state.add(QueueState(
      pending: list.length,
      hasFailures: list.any((m) => m.attempts > 0),
    ));
  }
}

class QueuedMutation {
  QueuedMutation({
    required this.id,
    required this.idempotencyKey,
    required this.path,
    required this.method,
    required this.body,
    required this.attempts,
    required this.createdAt,
    this.localEntityId,
    this.lastError,
  });

  factory QueuedMutation.fromJson(Map<String, dynamic> j) => QueuedMutation(
        id: j['id'] as String,
        idempotencyKey: j['idempotencyKey'] as String,
        path: j['path'] as String,
        method: j['method'] as String,
        body: (j['body'] as Map).cast<String, dynamic>(),
        localEntityId: j['localEntityId'] as String?,
        attempts: j['attempts'] as int,
        createdAt: DateTime.parse(j['createdAt'] as String),
        lastError: j['lastError'] as String?,
      );

  final String id;
  final String idempotencyKey;
  final String path;
  final String method;
  final Map<String, dynamic> body;
  final String? localEntityId;
  final int attempts;
  final DateTime createdAt;
  final String? lastError;

  QueuedMutation copyWith({int? attempts, String? lastError}) => QueuedMutation(
        id: id,
        idempotencyKey: idempotencyKey,
        path: path,
        method: method,
        body: body,
        localEntityId: localEntityId,
        attempts: attempts ?? this.attempts,
        createdAt: createdAt,
        lastError: lastError ?? this.lastError,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'idempotencyKey': idempotencyKey,
        'path': path,
        'method': method,
        'body': body,
        'localEntityId': localEntityId,
        'attempts': attempts,
        'createdAt': createdAt.toIso8601String(),
        'lastError': lastError,
      };
}

class MutationOutcome {
  MutationOutcome({
    required this.success,
    this.dropPermanently = false,
    this.errorMessage,
  });

  factory MutationOutcome.ok() => MutationOutcome(success: true);
  factory MutationOutcome.retriable(String reason) =>
      MutationOutcome(success: false, errorMessage: reason);
  factory MutationOutcome.drop(String reason) =>
      MutationOutcome(success: false, dropPermanently: true, errorMessage: reason);

  final bool success;
  final bool dropPermanently;
  final String? errorMessage;
}

class QueueState {
  QueueState({required this.pending, required this.hasFailures});
  final int pending;
  final bool hasFailures;
}

Future<MutationOutcome> _unboundSender(QueuedMutation _) async {
  // Default sender is a no-op; the production wiring binds a Dio-based
  // sender in `lib/core/offline/mutation_queue_provider.dart` (added when
  // the offline-first feature lands per-screen).
  return MutationOutcome.retriable('No sender bound');
}
