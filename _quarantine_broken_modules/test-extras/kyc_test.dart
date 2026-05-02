import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/kyc/data/kyc_repository.dart';
import 'package:felo/features/kyc/domain/kyc_status.dart';
import 'package:felo/features/kyc/presentation/kyc_screen.dart';
import 'package:felo/features/kyc/presentation/kyc_status_screen.dart';

void main() {
  Widget wrap(Widget child) => ProviderScope(
        overrides: [
          kycRepositoryProvider.overrideWithValue(_FakeKycRepository()),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: FeloTheme.light(),
          home: child,
        ),
      );

  group('KycScreen', () {
    testWidgets('renders 4-step KYC flow', (tester) async {
      await tester.pumpWidget(wrap(const KycScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Verify your identity'), findsOneWidget);
      expect(find.text('Passport'), findsOneWidget);
    });

    testWidgets('selects ID type and advances', (tester) async {
      await tester.pumpWidget(wrap(const KycScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Passport'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Capture your ID'), findsOneWidget);
    });
  });

  group('KycStatusScreen', () {
    testWidgets('renders not started status', (tester) async {
      await tester.pumpWidget(wrap(const KycStatusScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Verification status'), findsOneWidget);
      expect(find.text('Not started'), findsOneWidget);
    });
  });
}

class _FakeKycRepository implements KycRepository {
  @override
  Future<KycStatus> getStatus() async => const KycStatus(
        id: 'kyc_test',
        state: KycState.notStarted,
      );

  @override
  Future<KycStatus> initiate({required String idType}) async => KycStatus(
        id: 'kyc_test',
        state: KycState.inProgress,
        idType: idType,
        documentsUploaded: true,
        selfieUploaded: true,
        submittedAt: DateTime.now(),
      );
}
