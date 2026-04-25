import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';

part 'coach_conversation_controller.g.dart';

enum CoachChatAuthor { user, coach, system }

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
  });

  final String id;
  final CoachChatAuthor author;
  final String text;
  final DateTime createdAt;
  final List<CoachDataPoint> dataPoints;
}

class CoachConversationState {
  const CoachConversationState({
    required this.messages,
    this.suggestions = const [],
    this.isSending = false,
    this.errorMessage,
  });

  final List<CoachChatMessage> messages;
  final List<String> suggestions;
  final bool isSending;
  final String? errorMessage;

  CoachConversationState copyWith({
    List<CoachChatMessage>? messages,
    List<String>? suggestions,
    bool? isSending,
    Object? errorMessage = _unchanged,
  }) {
    return CoachConversationState(
      messages: messages ?? this.messages,
      suggestions: suggestions ?? this.suggestions,
      isSending: isSending ?? this.isSending,
      errorMessage: identical(errorMessage, _unchanged)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

const _unchanged = Object();

@riverpod
class CoachConversation extends _$CoachConversation {
  FeloApiClient get _api => ref.read(feloApiClientProvider);

  @override
  Future<CoachConversationState> build() async {
    final conversations = await _api.listCoachConversations();
    final latest = conversations.firstOrNull;
    return CoachConversationState(messages: _messagesFromConversation(latest));
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
      final response = await _api.askCoach({'prompt': trimmed});
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
