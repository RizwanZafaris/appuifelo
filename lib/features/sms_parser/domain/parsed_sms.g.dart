// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_sms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParsedSms _$ParsedSmsFromJson(Map<String, dynamic> json) => _ParsedSms(
  id: json['id'] as String,
  source: json['source'] as String,
  body: json['body'] as String,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
  merchant: json['merchant'] as String,
  category: json['category'] as String,
  confidence: (json['confidence'] as num).toDouble(),
  parsedAt: DateTime.parse(json['parsedAt'] as String),
);

Map<String, dynamic> _$ParsedSmsToJson(_ParsedSms instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'body': instance.body,
      'amount': instance.amount,
      'currency': instance.currency,
      'merchant': instance.merchant,
      'category': instance.category,
      'confidence': instance.confidence,
      'parsedAt': instance.parsedAt.toIso8601String(),
    };
