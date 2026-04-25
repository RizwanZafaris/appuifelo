// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_capture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReceiptLineItem _$ReceiptLineItemFromJson(Map<String, dynamic> json) =>
    _ReceiptLineItem(
      name: json['name'] as String,
      amountMinor: (json['amountMinor'] as num).toInt(),
    );

Map<String, dynamic> _$ReceiptLineItemToJson(_ReceiptLineItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amountMinor': instance.amountMinor,
    };

_ReceiptOcrResult _$ReceiptOcrResultFromJson(Map<String, dynamic> json) =>
    _ReceiptOcrResult(
      id: json['id'] as String,
      transactionId: json['transactionId'] as String,
      merchant: json['merchant'] as String,
      purchasedAt: DateTime.parse(json['purchasedAt'] as String),
      currency: json['currency'] as String,
      totalMinor: (json['totalMinor'] as num).toInt(),
      lineItems: (json['lineItems'] as List<dynamic>)
          .map((e) => ReceiptLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$ReceiptOcrResultToJson(_ReceiptOcrResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'merchant': instance.merchant,
      'purchasedAt': instance.purchasedAt.toIso8601String(),
      'currency': instance.currency,
      'totalMinor': instance.totalMinor,
      'lineItems': instance.lineItems,
      'confidence': instance.confidence,
    };
