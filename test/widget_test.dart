import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/felo_app.dart';

void main() {
  testWidgets('shows the Felo splash entry point', (tester) async {
    // FeloApp is a ConsumerWidget (sprint 02 — ThemeMode.system) so it
    // must be wrapped in a ProviderScope. main.dart wraps the production
    // tree similarly via runApp(ProviderScope(child: FeloApp())).
    await tester.pumpWidget(
      const ProviderScope(child: FeloApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Felo'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
  });
}
