import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/theme/felo_theme.dart';
import 'package:felo/features/family/data/family_repository.dart';
import 'package:felo/features/family/domain/family_group.dart';
import 'package:felo/features/family/domain/family_member.dart';
import 'package:felo/features/family/presentation/family_screen.dart';
import 'package:felo/features/family/presentation/family_group_detail_screen.dart';
import 'package:felo/features/family/presentation/family_invite_screen.dart';

void main() {
  Widget wrap(Widget child) => ProviderScope(
        overrides: [
          familyRepositoryProvider.overrideWithValue(_FakeFamilyRepository()),
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

  group('FamilyScreen', () {
    testWidgets('renders family groups list', (tester) async {
      await tester.pumpWidget(wrap(const FamilyScreen()));
      await tester.pumpAndSettle();

      expect(find.text('My Family'), findsOneWidget);
      expect(find.text('2 members'), findsOneWidget);
    });

    testWidgets('tapping group navigates', (tester) async {
      await tester.pumpWidget(wrap(const FamilyScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('My Family'));
      await tester.pumpAndSettle();

      // After navigation, group detail should show
      expect(find.text('Group details'), findsOneWidget);
    });
  });

  group('FamilyGroupDetailScreen', () {
    testWidgets('renders group name and members', (tester) async {
      await tester.pumpWidget(
        wrap(const FamilyGroupDetailScreen(groupId: 'group_default')),
      );
      await tester.pumpAndSettle();

      expect(find.text('My Family'), findsOneWidget);
      expect(find.text('Rizwan'), findsOneWidget);
      expect(find.text('Amina'), findsOneWidget);
    });
  });

  group('FamilyInviteScreen', () {
    testWidgets('renders invite form', (tester) async {
      await tester.pumpWidget(wrap(const FamilyInviteScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Send invite'), findsOneWidget);
    });
  });
}

class _FakeFamilyRepository implements FamilyRepository {
  @override
  Future<List<FamilyGroup>> listGroups() async => [
        const FamilyGroup(
          id: 'group_default',
          name: 'My Family',
          createdBy: 'user_me',
          createdAt: DateTime(2026, 4, 1),
          isDefault: true,
          members: [
            FamilyMember(
              id: 'member_rizwan',
              displayName: 'Rizwan',
              phoneMasked: '+1 647 *** 1189',
              role: FamilyRole.admin,
              canViewSharedTransactions: true,
              canEditSharedBudgets: true,
            ),
            FamilyMember(
              id: 'member_amina',
              displayName: 'Amina',
              phoneMasked: '+92 300 *** 4412',
              role: FamilyRole.member,
              canViewSharedTransactions: true,
              canEditSharedBudgets: false,
            ),
          ],
        ),
      ];

  @override
  Future<FamilyGroup> getGroup(String id) async => (await listGroups()).first;

  @override
  Future<FamilyGroup> createGroup({required String name}) async {
    return FamilyGroup(
      id: 'group_new',
      name: name,
      createdBy: 'user_me',
      createdAt: DateTime.now(),
      members: const [],
    );
  }

  @override
  Future<void> inviteMember(String groupId, {required String phone, required FamilyRole role}) async {}

  @override
  Future<void> acceptInvitation(String code) async {}

  @override
  Future<List<FamilyMember>> listMembers(String groupId) async {
    return (await listGroups()).first.members;
  }
}
