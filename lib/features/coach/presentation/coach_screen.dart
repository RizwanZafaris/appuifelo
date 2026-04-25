import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/coach/application/coach_conversation_controller.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class CoachScreen extends ConsumerStatefulWidget {
  const CoachScreen({super.key});

  @override
  ConsumerState<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends ConsumerState<CoachScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final conversation = ref.watch(coachConversationProvider);
    return FeloScaffold(
      title: l10n.coachTitle,
      selectedTab: FeloRootTab.coach,
      child: conversation.when(
        data: (state) => _CoachConversationView(
          state: state,
          controller: _controller,
          onPromptSelected: _send,
          onSend: () => _send(_controller.text),
        ),
        error: (_, _) => _CoachLoadError(
          onRetry: () {
            ref.invalidate(coachConversationProvider);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> _send(String prompt) async {
    final trimmed = prompt.trim();
    if (trimmed.isEmpty) {
      return;
    }
    _controller.clear();
    await ref.read(coachConversationProvider.notifier).ask(trimmed);
  }
}

class _CoachConversationView extends StatelessWidget {
  const _CoachConversationView({
    required this.state,
    required this.controller,
    required this.onPromptSelected,
    required this.onSend,
  });

  final CoachConversationState state;
  final TextEditingController controller;
  final ValueChanged<String> onPromptSelected;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final prompts = state.suggestions.isEmpty
        ? [l10n.coachPromptOne, l10n.coachPromptTwo, l10n.coachPromptThree]
        : state.suggestions;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        FeloCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline_rounded),
              const SizedBox(width: 12),
              Expanded(child: Text(l10n.coachDisclaimer)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final prompt in prompts) ...[
                FeloChip(
                  label: prompt,
                  icon: Icons.auto_awesome_rounded,
                  onTap: state.isSending
                      ? null
                      : () => onPromptSelected(prompt),
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (state.messages.isEmpty) ...[
          FeloCard(child: Text(l10n.coachEmptyState)),
          const SizedBox(height: 10),
        ],
        for (final message in state.messages) ...[
          _CoachBubble(message: message),
          const SizedBox(height: 10),
        ],
        if (state.isSending) ...[
          _TypingIndicator(label: l10n.coachTypingIndicator),
          const SizedBox(height: 10),
        ],
        if (state.errorMessage != null) ...[
          Text(
            l10n.coachErrorMessage,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 12),
        _CoachInput(
          controller: controller,
          enabled: !state.isSending,
          hint: l10n.coachInputHint,
          sendLabel: l10n.coachSendLabel,
          onSubmitted: (_) => onSend(),
          onSend: onSend,
        ),
      ],
    );
  }
}

class _CoachBubble extends StatelessWidget {
  const _CoachBubble({required this.message});

  final CoachChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isCoach = message.author != CoachChatAuthor.user;
    return Align(
      alignment: isCoach
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: FeloCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message.text),
              if (message.dataPoints.isNotEmpty) ...[
                const SizedBox(height: 14),
                _CoachDataChart(dataPoints: message.dataPoints),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CoachDataChart extends StatelessWidget {
  const _CoachDataChart({required this.dataPoints});

  final List<CoachDataPoint> dataPoints;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final maxValue = dataPoints
        .map((point) => point.value)
        .fold<double>(
          0,
          (previous, value) => value > previous ? value : previous,
        );
    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxValue <= 0 ? 1 : maxValue * 1.2,
          barTouchData: const BarTouchData(enabled: false),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= dataPoints.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      dataPoints[index].label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (final (index, point) in dataPoints.indexed)
              BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: point.value,
                    width: 18,
                    borderRadius: BorderRadius.circular(6),
                    color: colors.primary,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: FeloCard(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 10),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _CoachInput extends StatelessWidget {
  const _CoachInput({
    required this.controller,
    required this.enabled,
    required this.hint,
    required this.sendLabel,
    required this.onSubmitted,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool enabled;
  final String hint;
  final String sendLabel;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      minLines: 1,
      maxLines: 4,
      textInputAction: TextInputAction.send,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: hint,
        suffixIcon: IconButton(
          tooltip: sendLabel,
          icon: const Icon(Icons.send_rounded),
          onPressed: enabled ? onSend : null,
        ),
      ),
    );
  }
}

class _CoachLoadError extends StatelessWidget {
  const _CoachLoadError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.l10n.coachErrorMessage, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            IconButton(
              tooltip: context.l10n.coachRetryLabel,
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
