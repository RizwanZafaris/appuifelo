import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class CoachScreen extends ConsumerWidget {
  const CoachScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final messages = ref.watch(coachMessagesProvider);
    return FeloScaffold(
      title: l10n.coachTitle,
      selectedTab: FeloRootTab.coach,
      child: ListView(
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
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FeloChip(label: l10n.coachPromptOne),
              FeloChip(label: l10n.coachPromptTwo),
              FeloChip(label: l10n.coachPromptThree),
            ],
          ),
          const SizedBox(height: 16),
          for (final message in messages) ...[
            Align(
              alignment: message.author.name == 'coach'
                  ? AlignmentDirectional.centerStart
                  : AlignmentDirectional.centerEnd,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: FeloCard(child: Text(message.text)),
              ),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
          FeloInput(label: l10n.coachInputHint),
        ],
      ),
    );
  }
}
