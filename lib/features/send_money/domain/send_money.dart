import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_money.freezed.dart';
part 'send_money.g.dart';

@freezed
abstract class SendRecipient with _$SendRecipient {
  const factory SendRecipient({
    required String id,
    required String displayName,
    required String phoneMasked,
    required String countryCode,
  }) = _SendRecipient;

  factory SendRecipient.fromJson(Map<String, Object?> json) =>
      _$SendRecipientFromJson(json);
}

@freezed
abstract class SendMoneyQuote with _$SendMoneyQuote {
  const factory SendMoneyQuote({
    required String sourceCurrency,
    required String targetCurrency,
    required int sourceAmountMinor,
    required int targetAmountMinor,
    required double rate,
  }) = _SendMoneyQuote;

  factory SendMoneyQuote.fromJson(Map<String, Object?> json) =>
      _$SendMoneyQuoteFromJson(json);
}

@freezed
abstract class SendMoneyDraft with _$SendMoneyDraft {
  const factory SendMoneyDraft({
    SendRecipient? recipient,
    SendMoneyQuote? quote,
    String? referenceId,
  }) = _SendMoneyDraft;

  factory SendMoneyDraft.fromJson(Map<String, Object?> json) =>
      _$SendMoneyDraftFromJson(json);
}
