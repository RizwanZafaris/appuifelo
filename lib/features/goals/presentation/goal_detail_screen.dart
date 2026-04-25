import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/network/dio_provider.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/goals/domain/goal.dart';
import 'package:felo/shared/utils/money_format.dart';
import 'package:felo/shared/widgets/felo_bottom_sheet.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_progress_ring.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class GoalDetailScreen extends ConsumerStatefulWidget {
  const GoalDetailScreen({required this.goalId, super.key});

  final String goalId;

  @override
  ConsumerState<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends ConsumerState<GoalDetailScreen> {
  int? _savedMinorOverride;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final goal = ref
        .watch(goalsProvider)
        .firstWhere((item) => item.id == widget.goalId);
    final savedMinor = _savedMinorOverride ?? goal.savedMinor;
    final progress = savedMinor / goal.targetMinor;

    return FeloScaffold(
      title: l10n.goalDetailTitle,
      selectedTab: FeloRootTab.goals,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: FeloProgressRing(
              progress: progress,
              label: goal.name,
              size: 136,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            goal.name,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.goalProgressSummary(
              formatMinorMoney(minor: savedMinor, currency: goal.currency),
              formatMinorMoney(
                minor: goal.targetMinor,
                currency: goal.currency,
              ),
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          _GoalLinkedCardTeaser(goal: goal),
          const SizedBox(height: 12),
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.goalContributorsTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final name in goal.contributorNames)
                      Chip(label: Text(name)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FeloButton(
            label: l10n.goalContributeButton,
            icon: Icons.add_rounded,
            onPressed: () => _openContributionSheet(goal, savedMinor),
          ),
        ],
      ),
    );
  }

  Future<void> _openContributionSheet(Goal goal, int savedMinor) async {
    final result = await showFeloBottomSheet<int>(
      context: context,
      builder: (context) =>
          _ContributionSheet(goal: goal, savedMinor: savedMinor),
    );
    if (result == null || !mounted) {
      return;
    }

    final beforeMinor = savedMinor;
    final afterMinor = (beforeMinor + result).clamp(0, goal.targetMinor);
    try {
      await ref.read(feloApiClientProvider).contributeToGoal(goal.id, {
        'amountMinor': result,
        'currency': goal.currency,
      });
      if (!mounted) {
        return;
      }
      setState(() => _savedMinorOverride = afterMinor);
      ref.invalidate(goalsProvider);
      final milestone = _crossedMilestone(
        beforeMinor: beforeMinor,
        afterMinor: afterMinor,
        targetMinor: goal.targetMinor,
      );
      if (milestone != null) {
        await showDialog<void>(
          context: context,
          builder: (context) => _GoalMilestoneDialog(
            goalName: goal.name,
            milestonePercent: milestone,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.goalContributionSaved)),
        );
      }
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.goalContributionFailed)),
      );
    }
  }
}

class _GoalLinkedCardTeaser extends StatelessWidget {
  const _GoalLinkedCardTeaser({required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: FeloColors.mintBase.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: FeloColors.mintText.withValues(alpha: 0.22)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.credit_card_rounded, color: FeloColors.mintText),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.goalCardTeaserTitle,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.goalCardTeaserBody(goal.name),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContributionSheet extends StatefulWidget {
  const _ContributionSheet({required this.goal, required this.savedMinor});

  final Goal goal;
  final int savedMinor;

  @override
  State<_ContributionSheet> createState() => _ContributionSheetState();
}

class _ContributionSheetState extends State<_ContributionSheet> {
  late final TextEditingController _controller;
  int _amountMinor = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_syncAmount);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final afterMinor = (widget.savedMinor + _amountMinor).clamp(
      0,
      widget.goal.targetMinor,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        8,
        20,
        MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.goalContributionSheetTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
            decoration: InputDecoration(
              labelText: l10n.goalContributionAmountLabel,
              prefixText: '${widget.goal.currency} ',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ProgressPreviewValue(
                  label: l10n.goalContributionBefore,
                  amount: formatMinorMoney(
                    minor: widget.savedMinor,
                    currency: widget.goal.currency,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ProgressPreviewValue(
                  label: l10n.goalContributionAfter,
                  amount: formatMinorMoney(
                    minor: afterMinor,
                    currency: widget.goal.currency,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FeloButton(
            label: l10n.goalContributeButton,
            icon: Icons.savings_rounded,
            onPressed: _amountMinor > 0
                ? () => Navigator.of(context).pop(_amountMinor)
                : null,
          ),
        ],
      ),
    );
  }

  void _syncAmount() {
    setState(() {
      _amountMinor = _parseMinor(_controller.text);
    });
  }

  int _parseMinor(String value) {
    final normalized = value.replaceAll(',', '').trim();
    if (normalized.isEmpty) {
      return 0;
    }
    final parts = normalized.split('.');
    final dollars = int.tryParse(parts.first) ?? 0;
    final cents = parts.length > 1
        ? int.tryParse(parts[1].padRight(2, '0').substring(0, 2)) ?? 0
        : 0;
    return (dollars * 100) + cents;
  }
}

class _ProgressPreviewValue extends StatelessWidget {
  const _ProgressPreviewValue({required this.label, required this.amount});

  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalMilestoneDialog extends StatefulWidget {
  const _GoalMilestoneDialog({
    required this.goalName,
    required this.milestonePercent,
  });

  final String goalName;
  final int milestonePercent;

  @override
  State<_GoalMilestoneDialog> createState() => _GoalMilestoneDialogState();
}

class _GoalMilestoneDialogState extends State<_GoalMilestoneDialog> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 2));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 96,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  ConfettiWidget(
                    confettiController: _controller,
                    blastDirectionality: BlastDirectionality.explosive,
                    numberOfParticles: 18,
                    shouldLoop: false,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      Icons.emoji_events_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 44,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.goalMilestoneDialogTitle,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.goalMilestoneDialogBody(
                widget.goalName,
                widget.milestonePercent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.l10n.commonContinue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int? _crossedMilestone({
  required int beforeMinor,
  required int afterMinor,
  required int targetMinor,
}) {
  final beforePercent = beforeMinor / targetMinor * 100;
  final afterPercent = afterMinor / targetMinor * 100;
  for (final milestone in [100, 75, 50, 25]) {
    if (beforePercent < milestone && afterPercent >= milestone) {
      return milestone;
    }
  }
  return null;
}
