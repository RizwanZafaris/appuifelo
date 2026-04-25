import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/goals/data/goals_repository.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(goalsProvider);
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.goalsTitle,
      selectedTab: FeloRootTab.goals,
      child: goalsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(20),
          child: FeloEmptyState(
            title: 'Could not load goals',
            body: error.toString(),
          ),
        ),
        data: (goals) {
          if (goals.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: FeloEmptyState(
                title: l10n.goalsTitle,
                body: l10n.goalsBody,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref.refresh(goalsProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final goal = goals[index];
                final progress = goal.targetMinor == 0
                    ? 0.0
                    : (goal.savedMinor / goal.targetMinor).clamp(0.0, 1.0);
                return FeloCard(
                  onTap: () => context.go('/goals/${goal.id}'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      if (goal.contributionStreakWeeks >= 3) ...[
                        const SizedBox(height: 8),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Chip(
                            avatar: const Icon(
                              Icons.local_fire_department_rounded,
                            ),
                            label: Text(
                              l10n.goalStreakBadge(
                                goal.contributionStreakWeeks,
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: progress,
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
        },
      ),
    );
  }
}
