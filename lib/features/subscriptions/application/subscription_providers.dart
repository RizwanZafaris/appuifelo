import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:felo/core/config/felo_env.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';

part 'subscription_providers.g.dart';

// ============================================================================
// User Tier (legacy endpoint)
// ============================================================================

@riverpod
Future<Map<String, dynamic>> userTier(UserTierRef ref) async {
  if (FeloEnv.useFakeData) {
    return {
      'tier': 'free',
      'usage': {
        'expensesThisMonth': 12,
        'aiQueriesThisMonth': 3,
        'goalsActive': 1,
        'groupsActive': 0,
      },
      'limits': {
        'maxExpensesPerMonth': 50,
        'maxAiQueriesPerMonth': 10,
        'maxGoals': 1,
        'maxGroups': 1,
      },
    };
  }
  final api = ref.watch(feloApiClientProvider);
  final response = await api.subscriptionTier();
  return response as Map<String, dynamic>;
}

// ============================================================================
// My Subscription (new endpoint)
// ============================================================================

@riverpod
Future<Map<String, dynamic>> mySubscription(MySubscriptionRef ref) async {
  if (FeloEnv.useFakeData) {
    return {
      'tier': 'free',
      'status': 'active',
      'expiresAt': null,
      'features': ['basic_tracking', 'manual_entry'],
    };
  }
  final api = ref.watch(feloApiClientProvider);
  final response = await api.getMySubscription();
  return response as Map<String, dynamic>;
}

// ============================================================================
// Paywall Config
// ============================================================================

@riverpod
Future<Map<String, dynamic>> paywallConfig(PaywallConfigRef ref) async {
  if (FeloEnv.useFakeData) {
    return {
      'plans': [
        {
          'id': 'plus',
          'name': 'FELO Plus',
          'monthlyPrice': {'amountMinor': 499, 'currency': 'CAD'},
          'features': [
            'unlimited_expenses',
            '5_goals',
            '3_groups',
            'weekly_ai_insights',
          ],
        },
        {
          'id': 'plus-plus',
          'name': 'FELO Plus+',
          'monthlyPrice': {'amountMinor': 899, 'currency': 'CAD'},
          'features': [
            'unlimited_everything',
            'advanced_ai',
            'receipt_ocr',
            'family_roles',
          ],
          'recommended': true,
        },
      ],
    };
  }
  final api = ref.watch(feloApiClientProvider);
  final response = await api.getPaywallConfig();
  return response as Map<String, dynamic>;
}

// ============================================================================
// Checkout Session
// ============================================================================

@riverpod
class CheckoutSession extends _$CheckoutSession {
  @override
  Future<Map<String, dynamic>> build() async {
    return {};
  }

  Future<void> create({
    required String planId,
    required String currency,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (FeloEnv.useFakeData) {
        await Future<void>.delayed(const Duration(seconds: 1));
        return {'sessionId': 'fake_session_${DateTime.now().millisecondsSinceEpoch}'};
      }
      final api = ref.read(feloApiClientProvider);
      final response = await api.createCheckoutSession({
        'planId': planId,
        'currency': currency,
      });
      return (response as Map?)?.cast<String, dynamic>() ?? {};
    });
  }
}

// ============================================================================
// Restore Purchases
// ============================================================================

@riverpod
class PurchaseRestore extends _$PurchaseRestore {
  @override
  Future<void> build() async {}

  Future<bool> restore() async {
    state = const AsyncValue.loading();
    try {
      if (FeloEnv.useFakeData) {
        await Future<void>.delayed(const Duration(seconds: 1));
        return true;
      }
      final api = ref.read(feloApiClientProvider);
      await api.restorePurchases();
      ref.invalidate(mySubscriptionProvider);
      ref.invalidate(userTierProvider);
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }
}

// ============================================================================
// Apply Coupon
// ============================================================================

@riverpod
class CouponApplier extends _$CouponApplier {
  @override
  Future<Map<String, dynamic>?> build() async {
    return null;
  }

  Future<bool> apply(String code) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      if (FeloEnv.useFakeData) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        return {'discountPercent': 20, 'valid': true};
      }
      final api = ref.read(feloApiClientProvider);
      final response = await api.applyCoupon({'code': code});
      return (response as Map?)?.cast<String, dynamic>() ?? {};
    });
    state = result;
    return result.valueOrNull?['valid'] == true;
  }
}
