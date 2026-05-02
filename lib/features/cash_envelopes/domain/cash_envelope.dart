import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_envelope.freezed.dart';
part 'cash_envelope.g.dart';

@freezed
abstract class CashEnvelope with _$CashEnvelope {
  const factory CashEnvelope({
    required String id,
    required String name,
    required String category,
    required String currency,
    required int budgetMinor,
    required int spentMinor,
    required String period,
    required bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _CashEnvelope;

  factory CashEnvelope.fromJson(Map<String, Object?> json) =>
      _$CashEnvelopeFromJson(json);
}
