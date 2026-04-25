import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';
import 'package:felo/shared/widgets/felo_progress_ring.dart';

class GoalDetailScreen extends ConsumerWidget {
  const GoalDetailScreen({required this.goalId, super.key});

  final String goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final goal = ref
        .watch(goalsProvider)
        .firstWhere((item) => item.id == goalId);
    return FeloFeaturePlaceholder(
      title: l10n.goalDetailTitle,
      body: l10n.goalsBody,
      icon: Icons.flag_rounded,
      children: [
        FeloProgressRing(
          progress: goal.savedMinor / goal.targetMinor,
          label: goal.name,
          size: 128,
        ),
        const SizedBox(height: 16),
        Text(
          '${goal.name}: ${formatMinorMoney(minor: goal.savedMinor, currency: goal.currency)}',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
