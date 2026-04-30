import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:felo/core/network/felo_api_client.dart';

part 'monthly_close_providers.g.dart';

@riverpod
Future<dynamic> monthlyClose(MonthlyCloseRef ref, int year, int month) async {
  final api = ref.watch(feloApiClientProvider);
  return api.monthlyClose(year, month);
}

@riverpod
Future<List<dynamic>> monthlyChecklist(MonthlyChecklistRef ref, int year, int month) async {
  final api = ref.watch(feloApiClientProvider);
  return api.monthlyCloseChecklist(year, month) as List<dynamic>;
}
