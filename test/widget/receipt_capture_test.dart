import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/receipt_capture/presentation/receipt_capture_screen.dart';

void main() {
  testWidgets('receipt capture processes and confirms mock OCR', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: _ReceiptCaptureTestApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Receipt capture'), findsOneWidget);

    await tester.tap(find.text('Choose from gallery'));
    await tester.pump();

    expect(find.text('Processing receipt...'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    expect(find.text('Mock OCR result'), findsOneWidget);

    await tester.tap(find.text('Confirm receipt'));
    await tester.pumpAndSettle();

    expect(find.text('Receipt confirmed'), findsOneWidget);
  });
}

class _ReceiptCaptureTestApp extends StatelessWidget {
  const _ReceiptCaptureTestApp();

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
      home: const ReceiptCaptureScreen(transactionId: 'txn_002'),
    );
  }
}
