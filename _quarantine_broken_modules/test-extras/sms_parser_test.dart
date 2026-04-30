import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/sms_parser/data/sms_parser_repository.dart';
import 'package:felo/features/sms_parser/domain/parsed_sms.dart';
import 'package:felo/features/sms_parser/presentation/sms_parser_screen.dart';
import 'package:felo/features/sms_parser/presentation/sms_ingestion_log_screen.dart';

void main() {
  Widget wrap(Widget child) => ProviderScope(
        overrides: [
          smsParserRepositoryProvider.overrideWithValue(_FakeSmsParserRepository()),
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

  group('SmsParserScreen', () {
    testWidgets('renders SMS parser screen', (tester) async {
      await tester.pumpWidget(wrap(const SmsParserScreen()));
      await tester.pumpAndSettle();

      expect(find.text('SMS parser'), findsOneWidget);
      expect(find.text('Easypaisa'), findsOneWidget);
      expect(find.text('JazzCash'), findsOneWidget);
    });
  });

  group('SmsIngestionLogScreen', () {
    testWidgets('renders ingestion log with messages', (tester) async {
      await tester.pumpWidget(wrap(const SmsIngestionLogScreen()));
      await tester.pumpAndSettle();

      expect(find.text('SMS ingestion log'), findsOneWidget);
      expect(find.text('Ali Reza'), findsOneWidget);
      expect(find.text('K-Electric'), findsOneWidget);
    });
  });
}

class _FakeSmsParserRepository implements SmsParserRepository {
  @override
  Future<List<ParsedSms>> listIngestionLog() async => [
        ParsedSms(
          id: 'sms_001',
          source: 'Easypaisa',
          body: 'Amount Rs. 2,500 sent to Ali Reza.',
          amount: 2500,
          currency: 'PKR',
          merchant: 'Ali Reza',
          category: 'Family',
          confidence: 0.94,
          parsedAt: DateTime(2026, 4, 24, 15, 45),
        ),
        ParsedSms(
          id: 'sms_002',
          source: 'JazzCash',
          body: 'You paid Rs. 1,240 to K-Electric.',
          amount: 1240,
          currency: 'PKR',
          merchant: 'K-Electric',
          category: 'Bills',
          confidence: 0.91,
          parsedAt: DateTime(2026, 4, 23, 19, 12),
        ),
      ];

  @override
  Future<List<SmsTemplate>> listTemplates() async => const [];

  @override
  Future<void> ingest(Map<String, dynamic> payload) async {}
}
