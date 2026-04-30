import 'package:freezed_annotation/freezed_annotation.dart';

part 'remittance_entry.freezed.dart';
part 'remittance_entry.g.dart';

@freezed
class RemittanceEntry with _$RemittanceEntry {
  const factory RemittanceEntry({
    required String id,
    required String recipientName,
    String? recipientCountry,
    String? relationship,
    required String provider,
    required String sourceCurrency,
    String? targetCurrency,
    required int sourceAmountMinor,
    int? targetAmountMinor,
    int? feeMinor,
    double? fxRate,
    String? deliveryMethod,
    String? deliveryTime,
    required String status,
    String? plannedDate,
    DateTime? sentAt,
    DateTime? receivedAt,
    String? confirmationMethod,
    String? notes,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _RemittanceEntry;

  factory RemittanceEntry.fromJson(Map<String, Object?> json) =>
      _$RemittanceEntryFromJson(json);
}

@freezed
class RemittanceSummary with _$RemittanceSummary {
  const factory RemittanceSummary({
    required int totalSentThisYear,
    required int totalPlanned,
    required double averageFxRate,
    required Map<String, int> countByProvider,
  }) = _RemittanceSummary;

  factory RemittanceSummary.fromJson(Map<String, Object?> json) =>
      _$RemittanceSummaryFromJson(json);
}
