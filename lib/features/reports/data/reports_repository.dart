import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/features/reports/domain/report_models.dart';

part 'reports_repository.g.dart';

class ReportsRepository {
  final FeloApiClient _api;

  ReportsRepository(this._api);

  Future<WeeklyReport> getWeeklyReport() async {
    final response = await _api.weeklyReport();
    return WeeklyReport.fromJson(response as Map<String, Object?>);
  }

  Future<MonthlyReport> getMonthlyReport(int year, int month) async {
    final response = await _api.monthlyReport(year, month);
    return MonthlyReport.fromJson(response as Map<String, Object?>);
  }
}

@riverpod
ReportsRepository reportsRepository(ReportsRepositoryRef ref) {
  final api = ref.watch(feloApiClientProvider);
  return ReportsRepository(api);
}

@riverpod
Future<WeeklyReport> weeklyReport(WeeklyReportRef ref) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getWeeklyReport();
}

@riverpod
Future<MonthlyReport> monthlyReport(MonthlyReportRef ref, int year, int month) async {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.getMonthlyReport(year, month);
}
