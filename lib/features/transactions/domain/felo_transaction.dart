import 'package:freezed_annotation/freezed_annotation.dart';

part 'felo_transaction.freezed.dart';
part 'felo_transaction.g.dart';

enum TransactionSource { sms, manual, bankAlert, fixture }

enum TransactionDirection { debit, credit }

@freezed
abstract class FeloTransaction with _$FeloTransaction {
  const factory FeloTransaction({
    required String id,
    required String accountId,
    required String merchant,
    required String category,
    required String currency,
    required int amountMinor,
    required TransactionDirection direction,
    required TransactionSource source,
    required double parserConfidence,
    required DateTime bookedAt,
    String? receiptId,
    String? note,
  }) = _FeloTransaction;

  factory FeloTransaction.fromJson(Map<String, Object?> json) =>
      _$FeloTransactionFromJson(json);
}
