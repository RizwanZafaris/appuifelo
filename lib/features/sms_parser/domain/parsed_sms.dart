import 'package:freezed_annotation/freezed_annotation.dart';

part 'parsed_sms.freezed.dart';
part 'parsed_sms.g.dart';

@freezed
abstract class ParsedSms with _$ParsedSms {
  const factory ParsedSms({
    required String id,
    required String source,
    required String body,
    required int amount,
    required String currency,
    required String merchant,
    required String category,
    required double confidence,
    required DateTime parsedAt,
  }) = _ParsedSms;

  factory ParsedSms.fromJson(Map<String, Object?> json) =>
      _$ParsedSmsFromJson(json);
}
