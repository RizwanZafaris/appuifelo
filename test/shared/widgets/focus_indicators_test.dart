import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

bool _anyDecoratedBoxHasBorder(WidgetTester tester) {
  // FeloCard renders its border via DecoratedBox; FeloButton renders via
  // Ink (which paints on the parent Material). Check both.
  final fromDecoratedBox = tester
      .widgetList<DecoratedBox>(find.byType(DecoratedBox))
      .map((d) => d.decoration)
      .whereType<BoxDecoration>();
  final fromInk = tester
      .widgetList<Ink>(find.byType(Ink))
      .map((i) => i.decoration)
      .whereType<BoxDecoration>();
  return [...fromDecoratedBox, ...fromInk].any((d) => d.border != null);
}

InkWell _inkWell(WidgetTester tester) =>
    tester.widget<InkWell>(find.byType(InkWell));

/// Synthetically drive the focus border by invoking the InkWell's
/// `onFocusChange` callback. We test the widget's *response* to a focus
/// event, not Flutter's traversal machinery (which is exercised by the
/// Flutter framework's own tests). This isolates the contract we own.
Future<void> _simulateFocus(WidgetTester tester, {required bool hasFocus}) async {
  _inkWell(tester).onFocusChange?.call(hasFocus);
  await tester.pumpAndSettle();
}

void main() {
  group('FeloButton focus indicator', () {
    testWidgets('wires onFocusChange + focusColor on InkWell', (tester) async {
      await tester.pumpWidget(
        _wrap(FeloButton(label: 'Hi', onPressed: () {})),
      );
      final inkWell = _inkWell(tester);
      expect(inkWell.onFocusChange, isNotNull,
          reason: 'FeloButton must hook InkWell.onFocusChange');
      expect(inkWell.focusColor, isNotNull,
          reason: 'FeloButton must set a brand-tinted focusColor');
    });

    testWidgets('focus event renders a focus border', (tester) async {
      await tester.pumpWidget(
        _wrap(FeloButton(label: 'Hi', onPressed: () {})),
      );
      expect(_anyDecoratedBoxHasBorder(tester), isFalse);

      await _simulateFocus(tester, hasFocus: true);
      expect(_anyDecoratedBoxHasBorder(tester), isTrue);

      await _simulateFocus(tester, hasFocus: false);
      expect(_anyDecoratedBoxHasBorder(tester), isFalse);
    });
  });

  group('FeloCard focus indicator', () {
    testWidgets('non-tappable card has no InkWell and no border', (tester) async {
      await tester.pumpWidget(_wrap(const FeloCard(child: Text('static'))));
      expect(find.byType(InkWell), findsNothing);
      expect(_anyDecoratedBoxHasBorder(tester), isFalse);
    });

    testWidgets('tappable card wires focus + renders border on focus',
        (tester) async {
      await tester.pumpWidget(
        _wrap(FeloCard(onTap: () {}, child: const Text('tappable'))),
      );
      final inkWell = _inkWell(tester);
      expect(inkWell.onFocusChange, isNotNull);
      expect(inkWell.focusColor, isNotNull);
      expect(_anyDecoratedBoxHasBorder(tester), isFalse);

      await _simulateFocus(tester, hasFocus: true);
      expect(_anyDecoratedBoxHasBorder(tester), isTrue);

      await _simulateFocus(tester, hasFocus: false);
      expect(_anyDecoratedBoxHasBorder(tester), isFalse);
    });
  });
}
