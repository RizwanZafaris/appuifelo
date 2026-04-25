import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:felo/core/network/dio_provider.dart';
import 'package:felo/core/network/felo_api_client.dart';

part 'felo_api_client_provider.g.dart';

@riverpod
FeloApiClient feloApiClient(FeloApiClientRef ref) {
  return FeloApiClient(ref.watch(dioProvider));
}
