import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill.freezed.dart';
part 'bill.g.dart';

enum BillCategory { utility, telecom, rent, subscription }

enum BillSource { manual, sms }

enum BillStatus { upcoming, paid }

@freezed
abstract class Bill with _$Bill {
  const factory Bill({
    required String id,
    required String name,
    required BillCategory category,
    required DateTime dueDate,
    required String currency,
    required int amountMinor,
    required bool autoPayEnabled,
    required BillSource source,
    required BillStatus status,
  }) = _Bill;

  factory Bill.fromJson(Map<String, Object?> json) => _$BillFromJson(json);
}
