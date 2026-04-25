import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/referrals/data/referrals_repository.dart';
import 'package:felo/features/referrals/domain/referral_models.dart';
import 'package:felo/features/referrals/presentation/referrals_screen.dart';

void main() {
  testWidgets('referrals hub renders loaded referral data', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          referralsSnapshotProvider.overrideWith((ref) async => _snapshot),
        ],
        child: const _TestApp(child: ReferralsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Referrals'), findsOneWidget);
    expect(find.text(r'Give CAD $5, get CAD $5'), findsOneWidget);
    expect(find.text('RIZWAN5'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.text('Amina'), findsOneWidget);
    expect(find.text('Completed'), findsAtLeastNWidgets(1));
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: FeloTheme.dark(),
      home: child,
    );
  }
}

const _snapshot = ReferralsSnapshot(
  code: ReferralCode(code: 'RIZWAN5', shareUrl: 'https://felo.app/r/RIZWAN5'),
  stats: ReferralStats(
    invitedCount: 3,
    completedCount: 1,
    pendingRewardMinor: 500,
    earnedRewardMinor: 500,
    currency: 'CAD',
  ),
  invites: [
    ReferralInvite(
      id: 'referral_1',
      displayName: 'Amina',
      status: 'Completed',
      rewardMinor: 500,
      currency: 'CAD',
    ),
  ],
);
