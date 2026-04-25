import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class DoHubScreen extends StatelessWidget {
  const DoHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.doHubTitle,
      selectedTab: FeloRootTab.doHub,
      actions: [
        IconButton(
          tooltip: 'Stitch screen coverage',
          onPressed: () => context.go('/design-screens'),
          icon: const Icon(Icons.fact_check_outlined),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          Text(
            l10n.doHubSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          _AisleCard(
            title: l10n.doHubSendPay,
            body: l10n.doHubSendPayBody,
            icon: Icons.send_rounded,
            color: FeloColors.peachBase,
            iconColor: FeloColors.peachText,
            onTap: () => context.go('/send'),
          ),
          _AisleCard(
            title: l10n.doHubSaveTrack,
            body: l10n.doHubSaveTrackBody,
            icon: Icons.savings_rounded,
            color: FeloColors.mintBase,
            iconColor: FeloColors.mintText,
            onTap: () => context.go('/goals'),
          ),
          _AisleCard(
            title: l10n.doHubSpendSmart,
            body: l10n.doHubSpendSmartBody,
            icon: Icons.pie_chart_rounded,
            color: FeloColors.skyBase,
            iconColor: FeloColors.skyText,
            onTap: () => context.go('/budgets'),
          ),
          _AisleCard(
            title: l10n.doHubCardsAccounts,
            body: l10n.doHubCardsAccountsBody,
            icon: Icons.account_balance_wallet_rounded,
            color: FeloColors.butterBase,
            iconColor: FeloColors.butterText,
            onTap: () => context.go('/accounts'),
          ),
          _AisleCard(
            title: l10n.doHubMoreHelp,
            body: l10n.doHubMoreHelpBody,
            icon: Icons.favorite_rounded,
            color: FeloColors.roseBase,
            iconColor: FeloColors.roseText,
            onTap: () => context.go('/help'),
          ),
        ],
      ),
    );
  }
}

class _AisleCard extends StatelessWidget {
  const _AisleCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: FeloCard(
        onTap: onTap,
        semanticLabel: '$title, $body',
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
