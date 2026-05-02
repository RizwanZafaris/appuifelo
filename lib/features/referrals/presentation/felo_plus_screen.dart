import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/referrals/data/referrals_repository.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_empty_state.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class FeloPlusScreen extends ConsumerWidget {
  const FeloPlusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final profile = ref.watch(feloPlusProfileProvider);

    return FeloScaffold(
      title: l10n.feloPlusTitle,
      child: profile.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => FeloEmptyState(
          title: l10n.feloPlusErrorTitle,
          body: l10n.feloPlusErrorBody,
          actionLabel: l10n.commonRetry,
          onAction: () => ref.invalidate(feloPlusProfileProvider),
        ),
        data: (data) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            FeloCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        data.isPlus
                            ? Icons.workspace_premium_rounded
                            : Icons.lock_open_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          data.isPlus
                              ? l10n.feloPlusActiveTitle
                              : l10n.feloPlusFreeTitle,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.isPlus
                        ? l10n.feloPlusActiveBody
                        : l10n.feloPlusFreeBody,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n.feloPlusTierLabel(data.subscriptionTier),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            for (final benefit in [
              l10n.feloPlusBenefitFx,
              l10n.feloPlusBenefitSupport,
              l10n.feloPlusBenefitCard,
              l10n.feloPlusBenefitLimits,
            ]) ...[
              FeloCard(
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded),
                    const SizedBox(width: 12),
                    Expanded(child: Text(benefit)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}
