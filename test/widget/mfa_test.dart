import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/auth/data/mfa_repository.dart';
import 'package:felo/features/auth/presentation/auth_recovery_screens.dart';

void main() {
  testWidgets('mfa setup verifies and shows recovery codes', (tester) async {
    final router = GoRouter(
      initialLocation: '/auth/mfa',
      routes: [
        GoRoute(
          path: '/auth/mfa',
          builder: (context, state) => const MfaSetupScreen(),
        ),
        GoRoute(
          path: '/auth/mfa/recovery-codes',
          builder: (context, state) {
            final codes = state.extra is List<String>
                ? state.extra! as List<String>
                : const <String>[];
            return MfaRecoveryCodesScreen(recoveryCodes: codes);
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const SizedBox.shrink(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          mfaRepositoryProvider.overrideWithValue(_FakeMfaRepository()),
        ],
        child: MaterialApp.router(
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: FeloTheme.light(),
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Two-factor authentication'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '123456');
    await tester.tap(find.text('Verify code'));
    await tester.pumpAndSettle();

    expect(find.text('Recovery codes'), findsOneWidget);
    expect(find.text('AAAA-BBBB'), findsOneWidget);

    await tester.tap(find.text('Copy all codes'));
    await tester.pump();
    final copied = await Clipboard.getData(Clipboard.kTextPlain);
    expect(copied?.text, contains('CCCC-DDDD'));
  });
}

class _FakeMfaRepository implements MfaRepository {
  static const _qrPngDataUrl =
      'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+/p9sAAAAASUVORK5CYII=';

  @override
  Future<void> disable() async {}

  @override
  Future<MfaEnrollment> enroll() async {
    return const MfaEnrollment(
      secret: 'JBSWY3DPEHPK3PXP',
      otpauth: 'otpauth://totp/Felo:test@example.com',
      qrPngDataUrl: _qrPngDataUrl,
    );
  }

  @override
  Future<MfaStatus> status() async {
    return const MfaStatus(enabled: true, recoveryCodesRemaining: 8);
  }

  @override
  Future<List<String>> verifyEnrollment(String code) async {
    expect(code, '123456');
    return const ['AAAA-BBBB', 'CCCC-DDDD'];
  }
}
