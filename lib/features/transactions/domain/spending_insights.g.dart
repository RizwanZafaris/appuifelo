// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spending_insights.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpendingInsights _$SpendingInsightsFromJson(
  Map<String, dynamic> json,
) => SpendingInsights(
  totalMinor: (json['totalMinor'] as num).toInt(),
  currency: json['currency'] as String,
  byCategory: (json['byCategory'] as List<dynamic>)
      .map((e) => SpendingInsightCategory.fromJson(e as Map<String, dynamic>))
      .toList(),
  byMerchant: (json['byMerchant'] as List<dynamic>)
      .map((e) => SpendingInsightMerchant.fromJson(e as Map<String, dynamic>))
      .toList(),
  trends: (json['trends'] as List<dynamic>)
      .map((e) => SpendingInsightTrend.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SpendingInsightsToJson(SpendingInsights instance) =>
    <String, dynamic>{
      'totalMinor': instance.totalMinor,
      'currency': instance.currency,
      'byCategory': instance.byCategory,
      'byMerchant': instance.byMerchant,
      'trends': instance.trends,
    };

SpendingInsightCategory _$SpendingInsightCategoryFromJson(
  Map<String, dynamic> json,
) => SpendingInsightCategory(
  category: json['category'] as String,
  totalMinor: (json['totalMinor'] as num).toInt(),
);

Map<String, dynamic> _$SpendingInsightCategoryToJson(
  SpendingInsightCategory instance,
) => <String, dynamic>{
  'category': instance.category,
  'totalMinor': instance.totalMinor,
};

SpendingInsightMerchant _$SpendingInsightMerchantFromJson(
  Map<String, dynamic> json,
) => SpendingInsightMerchant(
  merchant: json['merchant'] as String,
  totalMinor: (json['totalMinor'] as num).toInt(),
);

Map<String, dynamic> _$SpendingInsightMerchantToJson(
  SpendingInsightMerchant instance,
) => <String, dynamic>{
  'merchant': instance.merchant,
  'totalMinor': instance.totalMinor,
};

SpendingInsightTrend _$SpendingInsightTrendFromJson(
  Map<String, dynamic> json,
) => SpendingInsightTrend(
  date: json['date'] as String,
  totalMinor: (json['totalMinor'] as num).toInt(),
);

Map<String, dynamic> _$SpendingInsightTrendToJson(
  SpendingInsightTrend instance,
) => <String, dynamic>{
  'date': instance.date,
  'totalMinor': instance.totalMinor,
};
