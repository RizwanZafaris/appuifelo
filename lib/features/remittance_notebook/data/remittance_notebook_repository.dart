import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/features/remittance_notebook/domain/remittance_entry.dart';

part 'remittance_notebook_repository.g.dart';

class RemittanceNotebookRepository {
  final FeloApiClient _api;

  RemittanceNotebookRepository(this._api);

  Future<List<RemittanceEntry>> findAll({String? status}) async {
    final response = await _api.remittanceNotebook(status: status) as List<dynamic>;
    return response
        .map((e) => RemittanceEntry.fromJson(e as Map<String, Object?>))
        .toList();
  }

  Future<RemittanceEntry> create(Map<String, dynamic> data) async {
    final response = await _api.createRemittanceEntry(data) as Map<String, Object?>;
    return RemittanceEntry.fromJson(response);
  }

  Future<RemittanceSummary> getSummary() async {
    final response = await _api.remittanceSummary() as Map<String, Object?>;
    return RemittanceSummary.fromJson(response);
  }

  Future<void> markAsSent(String entryId) async {
    await _api.markRemittanceSent(entryId);
  }

  Future<void> delete(String entryId) async {
    await _api.deleteRemittanceEntry(entryId);
  }
}

@riverpod
RemittanceNotebookRepository remittanceNotebookRepository(RemittanceNotebookRepositoryRef ref) {
  final api = ref.watch(feloApiClientProvider);
  return RemittanceNotebookRepository(api);
}

@riverpod
Future<List<RemittanceEntry>> remittanceEntries(RemittanceEntriesRef ref, {String? status}) async {
  final repo = ref.watch(remittanceNotebookRepositoryProvider);
  return repo.findAll(status: status);
}

@riverpod
Future<RemittanceSummary> remittanceSummary(RemittanceSummaryRef ref) async {
  final repo = ref.watch(remittanceNotebookRepositoryProvider);
  return repo.getSummary();
}
