import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/core/network/felo_api_client_provider.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/coach/presentation/coach_screen.dart';

class _MockFeloApiClient extends Mock implements FeloApiClient {}

void main() {
  testWidgets('coach appends prompt and renders backend response', (
    tester,
  ) async {
    final api = _MockFeloApiClient();
    final response = Completer<Map<String, dynamic>>();

    when(api.listCoachConversations).thenAnswer((_) async => []);
    when(
      () => api.askCoach({'prompt': 'Where did my money go?'}),
    ).thenAnswer((_) => response.future);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [feloApiClientProvider.overrideWithValue(api)],
        child: const _CoachTestApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Where did my money go?');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pump();

    expect(find.text('Where did my money go?'), findsOneWidget);
    expect(find.text('Felo Coach is thinking...'), findsOneWidget);

    response.complete({
      'text': 'Groceries were your largest category this week.',
      'suggestions': ['How can I lower groceries?'],
      'dataPoints': [
        {'label': 'Food', 'value': 120},
        {'label': 'Bills', 'value': 80},
      ],
    });
    await tester.pumpAndSettle();

    expect(
      find.text('Groceries were your largest category this week.'),
      findsOneWidget,
    );
    expect(find.text('Food'), findsOneWidget);
    expect(find.text('Bills'), findsOneWidget);
    verify(() => api.askCoach({'prompt': 'Where did my money go?'})).called(1);
  });
}

class _CoachTestApp extends StatelessWidget {
  const _CoachTestApp();

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
      home: const CoachScreen(),
    );
  }
}
