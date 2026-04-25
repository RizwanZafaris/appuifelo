import 'package:felo/features/accounts/domain/felo_account.dart';

abstract class AccountsRepository {
  List<FeloAccount> seedAccounts();

  FeloAccount connectedAccountFor({
    required FeloAccountProvider provider,
    required int sequence,
  });
}
