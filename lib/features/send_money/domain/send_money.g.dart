// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_money.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SendRecipient _$SendRecipientFromJson(Map<String, dynamic> json) =>
    _SendRecipient(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      phoneMasked: json['phoneMasked'] as String,
      countryCode: json['countryCode'] as String,
    );

Map<String, dynamic> _$SendRecipientToJson(_SendRecipient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'phoneMasked': instance.phoneMasked,
      'countryCode': instance.countryCode,
    };

_SendMoneyQuote _$SendMoneyQuoteFromJson(Map<String, dynamic> json) =>
    _SendMoneyQuote(
      sourceCurrency: json['sourceCurrency'] as String,
      targetCurrency: json['targetCurrency'] as String,
      sourceAmountMinor: (json['sourceAmountMinor'] as num).toInt(),
      targetAmountMinor: (json['targetAmountMinor'] as num).toInt(),
      rate: (json['rate'] as num).toDouble(),
    );

Map<String, dynamic> _$SendMoneyQuoteToJson(_SendMoneyQuote instance) =>
    <String, dynamic>{
      'sourceCurrency': instance.sourceCurrency,
      'targetCurrency': instance.targetCurrency,
      'sourceAmountMinor': instance.sourceAmountMinor,
      'targetAmountMinor': instance.targetAmountMinor,
      'rate': instance.rate,
    };

_SendMoneyDraft _$SendMoneyDraftFromJson(Map<String, dynamic> json) =>
    _SendMoneyDraft(
      recipient: json['recipient'] == null
          ? null
          : SendRecipient.fromJson(json['recipient'] as Map<String, dynamic>),
      quote: json['quote'] == null
          ? null
          : SendMoneyQuote.fromJson(json['quote'] as Map<String, dynamic>),
      referenceId: json['referenceId'] as String?,
    );

Map<String, dynamic> _$SendMoneyDraftToJson(_SendMoneyDraft instance) =>
    <String, dynamic>{
      'recipient': instance.recipient,
      'quote': instance.quote,
      'referenceId': instance.referenceId,
    };
