// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'felo_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeloTransaction _$FeloTransactionFromJson(Map<String, dynamic> json) =>
    _FeloTransaction(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      merchant: json['merchant'] as String,
      category: json['category'] as String,
      currency: json['currency'] as String,
      amountMinor: (json['amountMinor'] as num).toInt(),
      direction: $enumDecode(_$TransactionDirectionEnumMap, json['direction']),
      source: $enumDecode(_$TransactionSourceEnumMap, json['source']),
      parserConfidence: (json['parserConfidence'] as num).toDouble(),
      bookedAt: DateTime.parse(json['bookedAt'] as String),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$FeloTransactionToJson(_FeloTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'merchant': instance.merchant,
      'category': instance.category,
      'currency': instance.currency,
      'amountMinor': instance.amountMinor,
      'direction': _$TransactionDirectionEnumMap[instance.direction]!,
      'source': _$TransactionSourceEnumMap[instance.source]!,
      'parserConfidence': instance.parserConfidence,
      'bookedAt': instance.bookedAt.toIso8601String(),
      'note': instance.note,
    };

const _$TransactionDirectionEnumMap = {
  TransactionDirection.debit: 'debit',
  TransactionDirection.credit: 'credit',
};

const _$TransactionSourceEnumMap = {
  TransactionSource.sms: 'sms',
  TransactionSource.manual: 'manual',
  TransactionSource.bankAlert: 'bankAlert',
  TransactionSource.fixture: 'fixture',
};
