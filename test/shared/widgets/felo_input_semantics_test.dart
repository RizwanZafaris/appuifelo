import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/shared/widgets/felo_input.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  group('FeloInput semantics', () {
    testWidgets('exposes textField semantics with the label', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_wrap(const FeloInput(label: 'Email')));

      expect(
        find.bySemanticsLabel('Email'),
        findsWidgets,
        reason: 'Label should be reachable as a semantic label',
      );

      handle.dispose();
    });

    testWidgets('marks liveRegion when errorText is present',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(const FeloInput(label: 'Email', errorText: 'Required field')),
      );

      // Walk semantics tree and find the FeloInput's Semantics node.
      final semantics = tester.getSemantics(find.byType(FeloInput));
      expect(semantics.hasFlag(SemanticsFlag.isLiveRegion), isTrue,
          reason: 'Error state should be a live region for screen readers');

      handle.dispose();
    });

    testWidgets('does not mark liveRegion when no error', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_wrap(const FeloInput(label: 'Email')));

      final semantics = tester.getSemantics(find.byType(FeloInput));
      expect(semantics.hasFlag(SemanticsFlag.isLiveRegion), isFalse);

      handle.dispose();
    });

    testWidgets('announces new error via SemanticsService.announce',
        (tester) async {
      final handle = tester.ensureSemantics();
      final List<String> announcements = <String>[];
      // Intercept the platform announce channel.
      tester.binding.defaultBinaryMessenger.setMockMessageHandler(
        SystemChannels.accessibility.name,
        (ByteData? message) async {
          if (message == null) return null;
          final decoded = SystemChannels.accessibility.codec.decodeMessage(message);
          if (decoded is Map && decoded['type'] == 'announce') {
            announcements.add((decoded['data'] as Map)['message'] as String);
          }
          return null;
        },
      );

      // Initial render with no error.
      await tester.pumpWidget(_wrap(const FeloInput(label: 'Email')));
      expect(announcements, isEmpty);

      // Re-render with an error → triggers announce.
      await tester.pumpWidget(
        _wrap(const FeloInput(label: 'Email', errorText: 'Invalid format')),
      );
      await tester.pumpAndSettle();
      expect(announcements, contains('Email: Invalid format'));

      // Re-render with same error → should NOT re-announce.
      announcements.clear();
      await tester.pumpWidget(
        _wrap(const FeloInput(label: 'Email', errorText: 'Invalid format')),
      );
      await tester.pumpAndSettle();
      expect(announcements, isEmpty,
          reason: 'Identical error should not re-announce');

      tester.binding.defaultBinaryMessenger
          .setMockMessageHandler(SystemChannels.accessibility.name, null);
      handle.dispose();
    });

    testWidgets('required flag adds visual asterisk and semantic hint',
        (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(const FeloInput(label: 'Email', required: true)),
      );

      // Visual: labelText is "Email *"
      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.decoration!.labelText, 'Email *');

      // Semantic hint mentions "required"
      final semantics = tester.getSemantics(find.byType(FeloInput));
      expect(semantics.hint, contains('required'));

      handle.dispose();
    });
  });
}
