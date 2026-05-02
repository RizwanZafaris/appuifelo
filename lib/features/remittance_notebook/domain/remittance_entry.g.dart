// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remittance_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemittanceEntry _$RemittanceEntryFromJson(Map<String, dynamic> json) =>
    _RemittanceEntry(
      id: json['id'] as String,
      recipientName: json['recipientName'] as String,
      recipientCountry: json['recipientCountry'] as String?,
      relationship: json['relationship'] as String?,
      provider: json['provider'] as String,
      sourceCurrency: json['sourceCurrency'] as String,
      targetCurrency: json['targetCurrency'] as String?,
      sourceAmountMinor: (json['sourceAmountMinor'] as num).toInt(),
      targetAmountMinor: (json['targetAmountMinor'] as num?)?.toInt(),
      feeMinor: (json['feeMinor'] as num?)?.toInt(),
      fxRate: (json['fxRate'] as num?)?.toDouble(),
      deliveryMethod: json['deliveryMethod'] as String?,
      deliveryTime: json['deliveryTime'] as String?,
      status: json['status'] as String,
      plannedDate: json['plannedDate'] as String?,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      receivedAt: json['receivedAt'] == null
          ? null
          : DateTime.parse(json['receivedAt'] as String),
      confirmationMethod: json['confirmationMethod'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RemittanceEntryToJson(_RemittanceEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipientName': instance.recipientName,
      'recipientCountry': instance.recipientCountry,
      'relationship': instance.relationship,
      'provider': instance.provider,
      'sourceCurrency': instance.sourceCurrency,
      'targetCurrency': instance.targetCurrency,
      'sourceAmountMinor': instance.sourceAmountMinor,
      'targetAmountMinor': instance.targetAmountMinor,
      'feeMinor': instance.feeMinor,
      'fxRate': instance.fxRate,
      'deliveryMethod': instance.deliveryMethod,
      'deliveryTime': instance.deliveryTime,
      'status': instance.status,
      'plannedDate': instance.plannedDate,
      'sentAt': instance.sentAt?.toIso8601String(),
      'receivedAt': instance.receivedAt?.toIso8601String(),
      'confirmationMethod': instance.confirmationMethod,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_RemittanceSummary _$RemittanceSummaryFromJson(Map<String, dynamic> json) =>
    _RemittanceSummary(
      totalSentThisYear: (json['totalSentThisYear'] as num).toInt(),
      totalPlanned: (json['totalPlanned'] as num).toInt(),
      averageFxRate: (json['averageFxRate'] as num).toDouble(),
      countByProvider: Map<String, int>.from(json['countByProvider'] as Map),
    );

Map<String, dynamic> _$RemittanceSummaryToJson(_RemittanceSummary instance) =>
    <String, dynamic>{
      'totalSentThisYear': instance.totalSentThisYear,
      'totalPlanned': instance.totalPlanned,
      'averageFxRate': instance.averageFxRate,
      'countByProvider': instance.countByProvider,
    };
