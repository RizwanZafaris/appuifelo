import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/features/cash_envelopes/domain/cash_envelope.dart';

part 'cash_envelopes_repository.g.dart';

class CashEnvelopesRepository {
  final FeloApiClient _api;

  CashEnvelopesRepository(this._api);

  Future<List<CashEnvelope>> findAll() async {
    final response = await _api.cashEnvelopes() as List<dynamic>;
    return response
        .map((e) => CashEnvelope.fromJson(e as Map<String, Object?>))
        .toList();
  }

  Future<CashEnvelope> create({
    required String name,
    required String category,
    required int budgetMinor,
    String currency = 'PKR',
    String period = 'monthly',
  }) async {
    final response = await _api.createCashEnvelope({
      'name': name,
      'category': category,
      'budgetMinor': budgetMinor,
      'currency': currency,
      'period': period,
    }) as Map<String, Object?>;
    return CashEnvelope.fromJson(response);
  }

  Future<CashEnvelope> spend(String envelopeId, int amountMinor) async {
    final response = await _api.spendCashEnvelope(envelopeId, {
      'amountMinor': amountMinor,
    }) as Map<String, Object?>;
    return CashEnvelope.fromJson(response);
  }

  Future<void> delete(String envelopeId) async {
    await _api.deleteCashEnvelope(envelopeId);
  }
}

@riverpod
CashEnvelopesRepository cashEnvelopesRepository(CashEnvelopesRepositoryRef ref) {
  final api = ref.watch(feloApiClientProvider);
  return CashEnvelopesRepository(api);
}

@riverpod
Future<List<CashEnvelope>> cashEnvelopes(CashEnvelopesRef ref) async {
  final repo = ref.watch(cashEnvelopesRepositoryProvider);
  return repo.findAll();
}
