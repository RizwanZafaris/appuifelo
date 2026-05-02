// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_envelope.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CashEnvelope _$CashEnvelopeFromJson(Map<String, dynamic> json) =>
    _CashEnvelope(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      currency: json['currency'] as String,
      budgetMinor: (json['budgetMinor'] as num).toInt(),
      spentMinor: (json['spentMinor'] as num).toInt(),
      period: json['period'] as String,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CashEnvelopeToJson(_CashEnvelope instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'currency': instance.currency,
      'budgetMinor': instance.budgetMinor,
      'spentMinor': instance.spentMinor,
      'period': instance.period,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
