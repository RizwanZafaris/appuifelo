import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **FR-8.0.1..3** — Dashboard handoff (Phase 8).
///
/// Final onboarding screen. Shows a confetti-style celebration plus a
/// preview of the dashboard widgets the personalize step seeded.
/// User taps "Take me to my dashboard" to leave the onboarding flow.
///
/// **D-027 contract**: the widget keys here must match what the
/// NestJS `complete.service.ts` `seedDashboardWidgets()` writes to
/// `dashboard_widgets`. The home dashboard reads that table and renders
/// the same set in the same order.
class DashboardHandoffScreen extends ConsumerStatefulWidget {
  const DashboardHandoffScreen({super.key});

  @override
  ConsumerState<DashboardHandoffScreen> createState() =>
      _DashboardHandoffScreenState();
}

class _DashboardHandoffScreenState extends ConsumerState<DashboardHandoffScreen>
    with OnboardingAnalyticsMixin<DashboardHandoffScreen> {
  @override
  int get phase => 8;

  @override
  String get stepId => 'phase8_step1';

  @override
  String get frdId => 'FR-8.0.1';

  Future<void> _enterDashboard() async {
    await ref
        .read(onboardingStateControllerProvider.notifier)
        .markStepCompleted('phase8_done');
    await onContinue({'event': 'enter_dashboard'});
    if (!mounted) return;
    // Hand off to the main app shell. The router redirects new users
    // here on first launch only; on subsequent launches /home is direct.
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingStateControllerProvider).valueOrNull;
    final name = state?.name?.trim();
    final greeting = (name == null || name.isEmpty)
        ? "You're all set"
        : 'You\'re all set, $name';

    // Lightweight stub of the dashboard preview. Each row maps to a
    // widget key the server will have seeded. Real widgets live on the
    // home shell; here we just show the silhouette so the user knows
    // what to expect.
    final widgetPreview = _previewWidgets(state);

    return Scaffold(
      backgroundColor: FeloColors.paper50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  color: FeloColors.feloiTeal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.celebration_rounded,
                  color: FeloColors.feloiTeal,
                  size: 56,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                greeting,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your dashboard is ready. Here\'s what you\'ll see.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: ListView.separated(
                  itemCount: widgetPreview.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) =>
                      _WidgetPreviewRow(spec: widgetPreview[i]),
                ),
              ),
              FeloButton(
                label: 'Take me to my dashboard',
                onPressed: _enterDashboard,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<_WidgetSpec> _previewWidgets(dynamic state) {
    final widgets = <_WidgetSpec>[
      const _WidgetSpec(
        key: 'balances',
        icon: Icons.account_balance_wallet_outlined,
        title: 'Balances',
        subtitle: 'All your accounts in one view',
      ),
      const _WidgetSpec(
        key: 'budget_progress',
        icon: Icons.pie_chart_outline_rounded,
        title: 'Budget progress',
        subtitle: 'Track this month vs your envelopes',
      ),
    ];
    if ((state?.goals as List?)?.isNotEmpty == true) {
      widgets.add(
        const _WidgetSpec(
          key: 'goals_progress',
          icon: Icons.flag_outlined,
          title: 'Goals progress',
          subtitle: 'Pacing toward your two goals',
        ),
      );
    }
    final hasCorridor =
        ((state?.sendsTo as List?)?.isNotEmpty == true) ||
        ((state?.receivesFrom as List?)?.isNotEmpty == true);
    if (hasCorridor) {
      widgets.add(
        const _WidgetSpec(
          key: 'remittance_corridors',
          icon: Icons.swap_horiz_rounded,
          title: 'Remittance corridors',
          subtitle: 'FX & fee snapshots for your routes',
        ),
      );
    }
    if (state?.invests == true) {
      widgets.add(
        const _WidgetSpec(
          key: 'investments_overview',
          icon: Icons.trending_up_rounded,
          title: 'Investments overview',
          subtitle: 'Holdings across your account types',
        ),
      );
    }
    if (state?.accountsDeferred == true) {
      widgets.add(
        const _WidgetSpec(
          key: 'sms_paste_inbox',
          icon: Icons.sms_outlined,
          title: 'SMS paste inbox',
          subtitle: 'Forward bank SMS to enrich your data',
        ),
      );
    }
    return widgets;
  }
}

class _WidgetSpec {
  const _WidgetSpec({
    required this.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String key;
  final IconData icon;
  final String title;
  final String subtitle;
}

class _WidgetPreviewRow extends StatelessWidget {
  const _WidgetPreviewRow({required this.spec});

  final _WidgetSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: FeloColors.mintBase.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(spec.icon, color: FeloColors.feloiTeal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spec.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 2),
                Text(
                  spec.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: FeloColors.feloiTeal),
        ],
      ),
    );
  }
}
