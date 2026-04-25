import 'package:flutter_test/flutter_test.dart';

import 'package:felo/felo_app.dart';

void main() {
  testWidgets('onboarding reaches the auth screen', (tester) async {
    await tester.pumpWidget(const FeloApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('Set up Felo'), findsOneWidget);

    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text(i == 3 ? 'Create account' : 'Continue'));
      await tester.pumpAndSettle();
    }

    expect(find.text('Welcome back'), findsOneWidget);
  });
}
