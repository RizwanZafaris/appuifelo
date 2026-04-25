import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/di/fake_repositories.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_feature_placeholder.dart';
import 'package:felo/shared/widgets/felo_progress_ring.dart';

class SmsParserScreen extends ConsumerWidget {
  const SmsParserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final messages = ref.watch(parsedSmsMessagesProvider);
    return FeloFeaturePlaceholder(
      title: l10n.smsParserTitle,
      body: l10n.smsParserBody,
      icon: Icons.sms_rounded,
      children: [
        FeloProgressRing(
          progress: 0.91,
          label: l10n.smsParserAccuracy,
          size: 120,
        ),
        const SizedBox(height: 16),
        for (final message in messages) ...[
          FeloCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.sms_outlined),
              title: Text(message.merchant),
              subtitle: Text(message.source),
              trailing: Text('${(message.confidence * 100).round()}%'),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
