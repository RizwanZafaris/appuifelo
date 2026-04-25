import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/accounts/presentation/account_connect_screen.dart';

void main() {
  testWidgets('account connect moves from picker to success', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: _AccountConnectTestApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Choose a provider'), findsOneWidget);

    await tester.tap(find.text('JazzCash'));
    await tester.pumpAndSettle();

    expect(find.text('JazzCash secure preview'), findsOneWidget);

    await tester.tap(find.text('Continue preview'));
    await tester.pumpAndSettle();

    expect(find.text('Account connected'), findsOneWidget);
  });
}

class _AccountConnectTestApp extends StatelessWidget {
  const _AccountConnectTestApp();

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
      home: const AccountConnectScreen(),
    );
  }
}
