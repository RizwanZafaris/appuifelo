import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/felo_app.dart';
import 'package:felo/features/profile/data/profile_repository.dart';
import 'package:felo/features/profile/domain/profile_settings.dart';

class _FakeRepo implements ProfileRepository {
  _FakeRepo(this._mode);
  final FeloThemeMode _mode;

  @override
  ProfileSettings settings() => ProfileSettings(
        languageCode: 'en',
        themeMode: _mode,
        operationalNotifications: true,
        marketingConsent: false,
        smsParserEnabled: false,
      );

  @override
  Future<ProfileSettings> fetch() async => settings();

  @override
  Future<ProfileSettings> update({
    String? languageCode,
    FeloThemeMode? themeMode,
    bool? operationalNotifications,
    bool? marketingConsent,
    bool? smsParserEnabled,
  }) async =>
      settings();
}

void main() {
  Future<ThemeMode> resolvedThemeMode(WidgetTester tester, FeloThemeMode mode) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileRepositoryProvider.overrideWithValue(_FakeRepo(mode)),
        ],
        child: const FeloApp(),
      ),
    );
    await tester.pumpAndSettle();
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    return app.themeMode!;
  }

  testWidgets('themeMode follows FeloThemeMode.system', (tester) async {
    expect(await resolvedThemeMode(tester, FeloThemeMode.system), ThemeMode.system);
  });

  testWidgets('themeMode honors FeloThemeMode.dark override', (tester) async {
    expect(await resolvedThemeMode(tester, FeloThemeMode.dark), ThemeMode.dark);
  });

  testWidgets('themeMode honors FeloThemeMode.light override', (tester) async {
    expect(await resolvedThemeMode(tester, FeloThemeMode.light), ThemeMode.light);
  });
}
