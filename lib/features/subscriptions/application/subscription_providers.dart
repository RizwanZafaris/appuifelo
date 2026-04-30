import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';

part 'subscription_providers.g.dart';

@riverpod
Future<Map<String, dynamic>> userTier(UserTierRef ref) async {
  final api = ref.watch(feloApiClientProvider);
  final response = await api.subscriptionTier();
  return response as Map<String, dynamic>;
}
