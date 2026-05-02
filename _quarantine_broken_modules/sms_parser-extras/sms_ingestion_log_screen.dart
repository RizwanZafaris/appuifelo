import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/sms_parser/data/sms_parser_repository.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';
import 'package:felo/shared/utils/money_format.dart';

class SmsIngestionLogScreen extends ConsumerWidget {
  const SmsIngestionLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final messagesAsync = ref.watch(parsedSmsMessagesProvider);

    return FeloScaffold(
      title: l10n.smsIngestionLogTitle,
      selectedTab: FeloRootTab.home,
      child: messagesAsync.when(
        data: (messages) => _LogContent(messages: messages),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.errorGeneric(e.toString()))),
      ),
    );
  }
}

class _LogContent extends StatelessWidget {
  const _LogContent({required this.messages});

  final List messages;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (messages.isEmpty) {
      return FeloEmptyState(
        title: l10n.smsIngestionEmptyTitle,
        body: l10n.smsIngestionEmptyBody,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: messages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final message = messages[index];
        return FeloCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      message.merchant,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  _ConfidenceBadge(confidence: message.confidence),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                message.body,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(message.source),
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(message.category),
                    visualDensity: VisualDensity.compact,
                  ),
                  const Spacer(),
                  Text(
                    formatMinorMoney(
                      minor: message.amount,
                      currency: message.currency,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                l10n.smsParsedAt(
                  MaterialLocalizations.of(context).formatShortDate(message.parsedAt),
                  MaterialLocalizations.of(context).formatTimeOfDay(
                    TimeOfDay.fromDateTime(message.parsedAt),
                  ),
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ConfidenceBadge extends StatelessWidget {
  const _ConfidenceBadge({required this.confidence});

  final double confidence;

  @override
  Widget build(BuildContext context) {
    final percent = (confidence * 100).round();
    final color = confidence >= 0.9
        ? Colors.green
        : confidence >= 0.7
            ? Colors.orange
            : Theme.of(context).colorScheme.error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        '$percent%',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
