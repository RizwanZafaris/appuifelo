import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(goalsProvider);
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.goalsTitle,
      selectedTab: FeloRootTab.goals,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final goal = goals[index];
          final progress = goal.savedMinor / goal.targetMinor;
          return FeloCard(
            onTap: () => context.go('/goals/${goal.id}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (goal.contributionStreakWeeks >= 3) ...[
                  const SizedBox(height: 8),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Chip(
                      avatar: const Icon(Icons.local_fire_department_rounded),
                      label: Text(
                        l10n.goalStreakBadge(goal.contributionStreakWeeks),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: progress.clamp(0, 1),
                  minHeight: 9,
                  borderRadius: BorderRadius.circular(99),
                ),
                const SizedBox(height: 8),
                Text(
                  '${formatMinorMoney(minor: goal.savedMinor, currency: goal.currency)} / ${formatMinorMoney(minor: goal.targetMinor, currency: goal.currency)}',
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: goals.length,
      ),
    );
  }
}
