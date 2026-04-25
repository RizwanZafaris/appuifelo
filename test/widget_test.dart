import 'package:flutter_test/flutter_test.dart';

import 'package:felo/felo_app.dart';

void main() {
  testWidgets('shows the Felo splash entry point', (tester) async {
    await tester.pumpWidget(const FeloApp());
    await tester.pumpAndSettle();

    expect(find.text('Felo'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
  });
}
