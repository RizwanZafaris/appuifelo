import 'package:freezed_annotation/freezed_annotation.dart';

part 'felo_account.freezed.dart';
part 'felo_account.g.dart';

enum FeloAccountProvider { td, rbc, easypaisa, jazzcash, manual }

enum FeloAccountType { bank, card, wallet }

enum FeloAccountSyncStatus { synced, syncing, needsReview }

@freezed
abstract class FeloAccount with _$FeloAccount {
  const factory FeloAccount({
    required String id,
    required FeloAccountProvider provider,
    required FeloAccountType type,
    required String displayName,
    required String currency,
    required int balanceMinor,
    required DateTime lastSyncedAt,
    required FeloAccountSyncStatus syncStatus,
  }) = _FeloAccount;

  factory FeloAccount.fromJson(Map<String, Object?> json) =>
      _$FeloAccountFromJson(json);
}

@freezed
sealed class AccountConnectState with _$AccountConnectState {
  const factory AccountConnectState.picker() = AccountConnectPicker;

  const factory AccountConnectState.oauth({
    required FeloAccountProvider provider,
  }) = AccountConnectOAuth;

  const factory AccountConnectState.success({required FeloAccount account}) =
      AccountConnectSuccess;
}
