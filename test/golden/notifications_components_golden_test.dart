import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/notifications/presentation/widgets/notification_card.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  testGoldens('Notifications component suite', (tester) async {
    final builder =
        GoldenBuilder.column(wrap: (child) => _GoldenHost(child: child))
          ..addScenario(
            'Unread notification',
            NotificationCard(
              title: 'Budget alert',
              body: 'Groceries reached 80% of its envelope.',
              timestamp: 'Apr 25 · 9:12 AM',
              categoryLabel: 'Budgets',
              icon: Icons.pie_chart_outline_rounded,
              isRead: false,
              markReadLabel: 'Mark read',
              onMarkRead: () {},
            ),
          )
          ..addScenario(
            'Read notification',
            const NotificationCard(
              title: 'System message',
              body: 'Phase 1 keeps payments and money movement turned off.',
              timestamp: 'Apr 22 · 10:15 AM',
              categoryLabel: 'System',
              icon: Icons.info_outline_rounded,
              isRead: true,
            ),
          );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(430, 760),
    );
    await screenMatchesGolden(tester, 'notifications_components');
  });
}

class _GoldenHost extends StatelessWidget {
  const _GoldenHost({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = FeloTheme.dark();
    return Localizations(
      locale: const Locale('en'),
      delegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: MediaQuery(
        data: const MediaQueryData(size: Size(390, 844)),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Theme(
            data: theme,
            child: Material(
              color: theme.scaffoldBackgroundColor,
              child: SizedBox(
                width: 390,
                child: Padding(padding: const EdgeInsets.all(20), child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
