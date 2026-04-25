import 'package:json_annotation/json_annotation.dart';

part 'spending_insights.g.dart';

@JsonSerializable()
class SpendingInsights {
  const SpendingInsights({
    required this.totalMinor,
    required this.currency,
    required this.byCategory,
    required this.byMerchant,
    required this.trends,
  });

  factory SpendingInsights.fromJson(Map<String, dynamic> json) =>
      _$SpendingInsightsFromJson(json);

  final int totalMinor;
  final String currency;
  final List<SpendingInsightCategory> byCategory;
  final List<SpendingInsightMerchant> byMerchant;
  final List<SpendingInsightTrend> trends;

  Map<String, dynamic> toJson() => _$SpendingInsightsToJson(this);
}

@JsonSerializable()
class SpendingInsightCategory {
  const SpendingInsightCategory({
    required this.category,
    required this.totalMinor,
  });

  factory SpendingInsightCategory.fromJson(Map<String, dynamic> json) =>
      _$SpendingInsightCategoryFromJson(json);

  final String category;
  final int totalMinor;

  Map<String, dynamic> toJson() => _$SpendingInsightCategoryToJson(this);
}

@JsonSerializable()
class SpendingInsightMerchant {
  const SpendingInsightMerchant({
    required this.merchant,
    required this.totalMinor,
  });

  factory SpendingInsightMerchant.fromJson(Map<String, dynamic> json) =>
      _$SpendingInsightMerchantFromJson(json);

  final String merchant;
  final int totalMinor;

  Map<String, dynamic> toJson() => _$SpendingInsightMerchantToJson(this);
}

@JsonSerializable()
class SpendingInsightTrend {
  const SpendingInsightTrend({required this.date, required this.totalMinor});

  factory SpendingInsightTrend.fromJson(Map<String, dynamic> json) =>
      _$SpendingInsightTrendFromJson(json);

  final String date;
  final int totalMinor;

  Map<String, dynamic> toJson() => _$SpendingInsightTrendToJson(this);
}
