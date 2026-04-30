import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/sms_parser/domain/parsed_sms.dart';

part 'sms_parser_repository.g.dart';

// ============================================================================
// Abstract Interface
// ============================================================================

abstract class SmsParserRepository {
  Future<List<ParsedSms>> listIngestionLog();
  Future<List<SmsTemplate>> listTemplates();
  Future<void> ingest(Map<String, dynamic> payload);
}

// ============================================================================
// API Implementation (production)
// ============================================================================

class ApiSmsParserRepository implements SmsParserRepository {
  ApiSmsParserRepository(this._api);

  final FeloApiClient _api;

  @override
  Future<List<ParsedSms>> listIngestionLog() async {
    final raw = await _api.listSmsIngestionLog();
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_parsedSmsFromApi).toList(growable: false);
  }

  @override
  Future<List<SmsTemplate>> listTemplates() async {
    final raw = await _api.listSmsTemplates();
    final rows = (raw as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return rows.map(_templateFromApi).toList(growable: false);
  }

  @override
  Future<void> ingest(Map<String, dynamic> payload) async {
    await _api.ingestSms(payload);
  }
}

// ============================================================================
// Fake Implementation (demo/offline mode)
// ============================================================================

class FakeSmsParserRepository implements SmsParserRepository {
  final List<ParsedSms> _log = [
    ParsedSms(
      id: 'sms_001',
      source: 'Easypaisa',
      body: 'Amount Rs. 2,500 sent to Ali Reza.',
      amount: 2500,
      currency: 'PKR',
      merchant: 'Ali Reza',
      category: 'Family',
      confidence: 0.94,
      parsedAt: DateTime(2026, 4, 24, 15, 45),
    ),
    ParsedSms(
      id: 'sms_002',
      source: 'JazzCash',
      body: 'You paid Rs. 1,240 to K-Electric.',
      amount: 1240,
      currency: 'PKR',
      merchant: 'K-Electric',
      category: 'Bills',
      confidence: 0.91,
      parsedAt: DateTime(2026, 4, 23, 19, 12),
    ),
  ];

  @override
  Future<List<ParsedSms>> listIngestionLog() async => List.unmodifiable(_log);

  @override
  Future<List<SmsTemplate>> listTemplates() async => const [
    SmsTemplate(id: 'tmpl_easypaisa', source: 'Easypaisa', pattern: 'Amount Rs. {amount} sent to {merchant}.'),
    SmsTemplate(id: 'tmpl_jazzcash', source: 'JazzCash', pattern: 'You paid Rs. {amount} to {merchant}.'),
  ];

  @override
  Future<void> ingest(Map<String, dynamic> payload) async {
    // no-op in fake mode
  }
}

// ============================================================================
// Domain: SMS Template
// ============================================================================

class SmsTemplate {
  const SmsTemplate({
    required this.id,
    required this.source,
    required this.pattern,
  });

  final String id;
  final String source;
  final String pattern;
}

// ============================================================================
// JSON Helpers
// ============================================================================

ParsedSms _parsedSmsFromApi(Map<String, dynamic> json) {
  return ParsedSms(
    id: json['id'].toString(),
    source: (json['source'] ?? '').toString(),
    body: (json['body'] ?? '').toString(),
    amount: _intFrom(json['amount']) ?? 0,
    currency: (json['currency'] ?? 'PKR').toString(),
    merchant: (json['merchant'] ?? '').toString(),
    category: (json['category'] ?? '').toString(),
    confidence: _doubleFrom(json['confidence']),
    parsedAt: DateTime.tryParse(
          (json['parsedAt'] ?? json['parsed_at'] ?? '').toString(),
        ) ??
        DateTime.now(),
  );
}

SmsTemplate _templateFromApi(Map<String, dynamic> json) {
  return SmsTemplate(
    id: json['id'].toString(),
    source: (json['source'] ?? '').toString(),
    pattern: (json['pattern'] ?? '').toString(),
  );
}

int? _intFrom(Object? value) {
  if (value is int) return value;
  if (value is num) return value.round();
  return int.tryParse(value?.toString() ?? '');
}

double _doubleFrom(Object? value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}
