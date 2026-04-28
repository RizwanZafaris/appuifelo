import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';

part 'coach_conversation_controller.g.dart';

enum CoachChatAuthor { user, coach, system }

/// Which backend path to use for the next message.
/// - [rules] hits POST /coach/ask (deterministic, no LLM, no quota cost).
/// - [llm]   hits POST /coach/chat (full pipeline, monthly quota).
enum CoachMode { rules, llm }

class CoachDataPoint {
  const CoachDataPoint({required this.label, required this.value});

  final String label;
  final double value;
}

class CoachChatMessage {
  const CoachChatMessage({
    required this.id,
    required this.author,
    required this.text,
    required this.createdAt,
    this.dataPoints = const [],
    this.sources = const [],
    this.guardrailTriggered = false,
    this.refusalCategory,
  });

  final String id;
  final CoachChatAuthor author;
  final String text;
  final DateTime createdAt;
  final List<CoachDataPoint> dataPoints;
  final List<CoachSource> sources;
  final bool guardrailTriggered;
  final String? refusalCategory;
}

class CoachSource {
  const CoachSource({required this.type, required this.label, required this.value});
  final String type;
  final String label;
  final String value;
}

class CoachConversationState {
  const CoachConversationState({
    required this.messages,
    this.suggestions = const [],
    this.isSending = false,
    this.errorMessage,
    this.mode = CoachMode.rules,
    this.conversationId,
    this.quotaRemaining,
    this.quotaLimit,
  });

  final List<CoachChatMessage> messages;
  final List<String> suggestions;
  final bool isSending;
  final String? errorMessage;
  final CoachMode mode;
  /// Server-assigned id for the current LLM conversation; null in rules mode
  /// or before the first /coach/chat round-trip.
  final String? conversationId;
  final int? quotaRemaining;
  final int? quotaLimit;

  CoachConversationState copyWith({
    List<CoachChatMessage>? messages,
    List<String>? suggestions,
    bool? isSending,
    Object? errorMessage = _unchanged,
    CoachMode? mode,
    Object? conversationId = _unchanged,
    int? quotaRemaining,
    int? quotaLimit,
  }) {
    return CoachConversationState(
      messages: messages ?? this.messages,
      suggestions: suggestions ?? this.suggestions,
      isSending: isSending ?? this.isSending,
      errorMessage: identical(errorMessage, _unchanged)
          ? this.errorMessage
          : errorMessage as String?,
      mode: mode ?? this.mode,
      conversationId: identical(conversationId, _unchanged)
          ? this.conversationId
          : conversationId as String?,
      quotaRemaining: quotaRemaining ?? this.quotaRemaining,
      quotaLimit: quotaLimit ?? this.quotaLimit,
    );
  }
}

const _unchanged = Object();

@riverpod
class CoachConversation extends _$CoachConversation {
  FeloApiClient get _api => ref.read(feloApiClientProvider);

  @override
  Future<CoachConversationState> build() async {
    final raw = await _api.listCoachConversations();
    final conversations = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    final latest = conversations.isEmpty ? null : conversations.first;
    return CoachConversationState(messages: _messagesFromConversation(latest));
  }

  void setMode(CoachMode mode) {
    final current =
        state.valueOrNull ?? const CoachConversationState(messages: []);
    state = AsyncData(current.copyWith(mode: mode));
  }

  /// Send a message using the currently selected mode.
  Future<void> send(String prompt) async {
    final mode = state.valueOrNull?.mode ?? CoachMode.rules;
    return mode == CoachMode.llm ? chat(prompt) : ask(prompt);
  }

  Future<void> ask(String prompt) async {
    final trimmed = prompt.trim();
    if (trimmed.isEmpty) {
      return;
    }

    final current =
        state.valueOrNull ?? const CoachConversationState(messages: []);
    final now = DateTime.now();
    final userMessage = CoachChatMessage(
      id: 'local-user-${now.microsecondsSinceEpoch}',
      author: CoachChatAuthor.user,
      text: trimmed,
      createdAt: now,
    );

    state = AsyncData(
      current.copyWith(
        messages: [...current.messages, userMessage],
        isSending: true,
        errorMessage: null,
      ),
    );

    try {
      final raw = await _api.askCoach({'prompt': trimmed});
      final response = (raw as Map?)?.cast<String, dynamic>() ?? const {};
      final receivedAt = DateTime.now();
      final coachMessage = CoachChatMessage(
        id:
            _stringValue(response['id']) ??
            'local-coach-${receivedAt.microsecondsSinceEpoch}',
        author: CoachChatAuthor.coach,
        text: _stringValue(response['text']) ?? '',
        createdAt: receivedAt,
        dataPoints: _dataPointsFrom(response['dataPoints']),
      );
      final latest = state.valueOrNull ?? current;
      state = AsyncData(
        latest.copyWith(
          messages: [...latest.messages, coachMessage],
          suggestions: _stringListFrom(response['suggestions']),
          isSending: false,
          errorMessage: null,
        ),
      );
    } catch (_) {
      final latest = state.valueOrNull ?? current;
      state = AsyncData(
        latest.copyWith(isSending: false, errorMessage: 'coachErrorMessage'),
      );
    }
  }

  /// LLM-backed chat. Hits POST /coach/chat — server enforces tier quota,
  /// runs guardrails, and persists the conversation. We pass the
  /// server-returned [conversationId] back on subsequent turns so the
  /// backend can load history and the LLM gets context.
  Future<void> chat(String prompt) async {
    final trimmed = prompt.trim();
    if (trimmed.isEmpty) {
      return;
    }

    final current =
        state.valueOrNull ?? const CoachConversationState(messages: []);
    final now = DateTime.now();
    final userMessage = CoachChatMessage(
      id: 'local-user-${now.microsecondsSinceEpoch}',
      author: CoachChatAuthor.user,
      text: trimmed,
      createdAt: now,
    );

    state = AsyncData(
      current.copyWith(
        messages: [...current.messages, userMessage],
        isSending: true,
        errorMessage: null,
      ),
    );

    try {
      final body = <String, dynamic>{'message': trimmed};
      if (current.conversationId != null) {
        body['conversationId'] = current.conversationId;
      }
      final raw = await _api.chatCoach(body);
      final response = (raw as Map?)?.cast<String, dynamic>() ?? const {};
      final receivedAt = DateTime.now();
      final triggered = response['guardrailTriggered'] == true;
      final coachMessage = CoachChatMessage(
        id: 'llm-${receivedAt.microsecondsSinceEpoch}',
        author: triggered ? CoachChatAuthor.system : CoachChatAuthor.coach,
        text: _stringValue(response['answer']) ?? '',
        createdAt: receivedAt,
        sources: _sourcesFrom(response['sources']),
        guardrailTriggered: triggered,
        refusalCategory: _stringValue(response['refusalCategory']),
      );
      final latest = state.valueOrNull ?? current;
      state = AsyncData(
        latest.copyWith(
          messages: [...latest.messages, coachMessage],
          isSending: false,
          errorMessage: null,
          conversationId: _stringValue(response['conversationId']) ??
              latest.conversationId,
          quotaRemaining: _intValue(response['quotaRemaining']),
        ),
      );
    } catch (e) {
      final latest = state.valueOrNull ?? current;
      // Distinguish quota exhaustion from generic errors so the UI can show
      // an upgrade prompt rather than a generic retry banner.
      final msg = e.toString().contains('429') ||
              e.toString().contains('quota_exceeded')
          ? 'coachQuotaExceeded'
          : 'coachErrorMessage';
      state = AsyncData(
        latest.copyWith(isSending: false, errorMessage: msg),
      );
    }
  }
}

List<CoachChatMessage> _messagesFromConversation(Map<String, dynamic>? row) {
  final rawMessages = row?['messages'];
  if (rawMessages is! List) {
    return const [];
  }

  return rawMessages
      .whereType<Map>()
      .map((message) => _messageFromJson(Map<String, dynamic>.from(message)))
      .whereType<CoachChatMessage>()
      .toList();
}

CoachChatMessage? _messageFromJson(Map<String, dynamic> json) {
  final text = _stringValue(json['text']) ?? _stringValue(json['content']);
  if (text == null || text.isEmpty) {
    return null;
  }

  final createdAt = DateTime.tryParse(_stringValue(json['createdAt']) ?? '');
  return CoachChatMessage(
    id: _stringValue(json['id']) ?? 'message-${text.hashCode}',
    author: _authorFrom(json['author'] ?? json['role']),
    text: text,
    createdAt: createdAt ?? DateTime.now(),
    dataPoints: _dataPointsFrom(json['dataPoints']),
  );
}

CoachChatAuthor _authorFrom(Object? value) {
  return switch (_stringValue(value)) {
    'user' => CoachChatAuthor.user,
    'system' => CoachChatAuthor.system,
    _ => CoachChatAuthor.coach,
  };
}

List<CoachDataPoint> _dataPointsFrom(Object? value) {
  if (value is! List) {
    return const [];
  }

  return value
      .whereType<Map>()
      .map((point) {
        final json = Map<String, dynamic>.from(point);
        final label = _stringValue(json['label'] ?? json['name'] ?? json['x']);
        final rawValue = json['value'] ?? json['amount'] ?? json['y'];
        final parsedValue = rawValue is num
            ? rawValue.toDouble()
            : double.tryParse(_stringValue(rawValue) ?? '');
        if (label == null || parsedValue == null) {
          return null;
        }
        return CoachDataPoint(label: label, value: parsedValue);
      })
      .whereType<CoachDataPoint>()
      .toList();
}

List<String> _stringListFrom(Object? value) {
  if (value is! List) {
    return const [];
  }

  return value
      .map(_stringValue)
      .whereType<String>()
      .where((suggestion) => suggestion.trim().isNotEmpty)
      .toList();
}

String? _stringValue(Object? value) {
  if (value == null) {
    return null;
  }
  return value.toString();
}

int? _intValue(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(_stringValue(value) ?? '');
}

List<CoachSource> _sourcesFrom(Object? value) {
  if (value is! List) return const [];
  return value
      .whereType<Map>()
      .map((src) {
        final json = Map<String, dynamic>.from(src);
        final type = _stringValue(json['type']);
        final label = _stringValue(json['label']);
        final v = _stringValue(json['value']);
        if (type == null || label == null || v == null) return null;
        return CoachSource(type: type, label: label, value: v);
      })
      .whereType<CoachSource>()
      .toList();
}
