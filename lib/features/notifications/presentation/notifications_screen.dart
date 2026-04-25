import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/budgets/data/budgets_repository.dart';
import 'package:felo/features/goals/data/goals_repository.dart';
import 'package:felo/features/notifications/domain/felo_notification.dart';
import 'package:felo/features/notifications/presentation/widgets/notification_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final filter = ref.watch(notificationFilterProvider);
    final notifications = ref.watch(filteredNotificationsProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    final inbox = ref.read(notificationInboxProvider.notifier);

    return FeloScaffold(
      title: l10n.notificationsTitle,
      selectedTab: FeloRootTab.home,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final option in FeloNotificationFilter.values) ...[
                        FeloChip(
                          label: _filterLabel(context, option),
                          selected: option == filter,
                          onTap: () {
                            ref
                                .read(notificationFilterProvider.notifier)
                                .select(option);
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.notificationsUnreadCount(unreadCount),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: unreadCount == 0 ? null : inbox.markAllRead,
                      icon: const Icon(Icons.done_all_rounded),
                      label: Text(l10n.notificationsMarkAllRead),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: notifications.isEmpty
                ? FeloEmptyState(
                    title: l10n.notificationsEmptyTitle,
                    body: l10n.notificationsEmptyBody,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      final details = _detailsFor(context, ref, notification);
                      return Dismissible(
                        key: ValueKey(notification.id),
                        direction: DismissDirection.endToStart,
                        background: _ArchiveBackground(
                          label: l10n.notificationsArchive,
                        ),
                        onDismissed: (_) => inbox.archive(notification.id),
                        child: NotificationCard(
                          title: details.title,
                          body: details.body,
                          timestamp: details.timestamp,
                          categoryLabel: details.categoryLabel,
                          icon: details.icon,
                          isRead: notification.isRead,
                          markReadLabel: l10n.notificationsMarkRead,
                          onMarkRead: () => inbox.markAsRead(notification.id),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemCount: notifications.length,
                  ),
          ),
        ],
      ),
    );
  }

  String _filterLabel(BuildContext context, FeloNotificationFilter filter) {
    final l10n = context.l10n;
    return switch (filter) {
      FeloNotificationFilter.all => l10n.notificationsFilterAll,
      FeloNotificationFilter.budgets => l10n.notificationsFilterBudgets,
      FeloNotificationFilter.goals => l10n.notificationsFilterGoals,
      FeloNotificationFilter.family => l10n.notificationsFilterFamily,
      FeloNotificationFilter.system => l10n.notificationsFilterSystem,
    };
  }

  _NotificationDetails _detailsFor(
    BuildContext context,
    WidgetRef ref,
    FeloNotification notification,
  ) {
    final l10n = context.l10n;
    final materialLocalizations = MaterialLocalizations.of(context);
    final createdAt = notification.createdAt;
    final timestamp = l10n.notificationsTimestamp(
      materialLocalizations.formatShortDate(createdAt),
      materialLocalizations.formatTimeOfDay(TimeOfDay.fromDateTime(createdAt)),
    );

    return switch (notification) {
      BudgetAlertNotification(:final budgetId, :final thresholdPercent) =>
        _NotificationDetails(
          title: l10n.notificationBudgetTitle,
          body: l10n.notificationBudgetBody(
            (ref.watch(budgetsProvider).valueOrNull ?? const [])
                .where((item) => item.id == budgetId)
                .map((b) => b.category)
                .firstOrNull ??
                '—',
            thresholdPercent,
          ),
          timestamp: timestamp,
          categoryLabel: l10n.notificationsFilterBudgets,
          icon: Icons.pie_chart_outline_rounded,
        ),
      GoalMilestoneNotification(:final goalId, :final progressPercent) =>
        _NotificationDetails(
          title: l10n.notificationGoalTitle,
          body: l10n.notificationGoalBody(
            (ref.watch(goalsProvider).valueOrNull ?? const [])
                .where((item) => item.id == goalId)
                .map((g) => g.name)
                .firstOrNull ??
                '—',
            progressPercent,
          ),
          timestamp: timestamp,
          categoryLabel: l10n.notificationsFilterGoals,
          icon: Icons.flag_outlined,
        ),
      SmsParserEventNotification(
        :final parsedSmsId,
        :final confidencePercent,
      ) =>
        _NotificationDetails(
          title: l10n.notificationSmsParserTitle,
          body: l10n.notificationSmsParserBody(
            ref
                .watch(parsedSmsMessagesProvider)
                .firstWhere((item) => item.id == parsedSmsId)
                .source,
            confidencePercent,
          ),
          timestamp: timestamp,
          categoryLabel: l10n.notificationsFilterSystem,
          icon: Icons.sms_outlined,
        ),
      FamilyActivityNotification(:final memberId) => _NotificationDetails(
        title: l10n.notificationFamilyTitle,
        body: l10n.notificationFamilyBody(
          ref
              .watch(familyMembersProvider)
              .firstWhere((item) => item.id == memberId)
              .displayName,
        ),
        timestamp: timestamp,
        categoryLabel: l10n.notificationsFilterFamily,
        icon: Icons.groups_2_outlined,
      ),
      SystemMessageNotification() => _NotificationDetails(
        title: l10n.notificationSystemTitle,
        body: l10n.notificationSystemBody,
        timestamp: timestamp,
        categoryLabel: l10n.notificationsFilterSystem,
        icon: Icons.info_outline_rounded,
      ),
    };
  }
}

class _ArchiveBackground extends StatelessWidget {
  const _ArchiveBackground({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(end: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.archive_outlined, color: colors.onErrorContainer),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.onErrorContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationDetails {
  const _NotificationDetails({
    required this.title,
    required this.body,
    required this.timestamp,
    required this.categoryLabel,
    required this.icon,
  });

  final String title;
  final String body;
  final String timestamp;
  final String categoryLabel;
  final IconData icon;
}
