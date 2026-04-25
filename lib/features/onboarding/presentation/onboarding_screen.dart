import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_chip.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final slides = [
      _OnboardingSlide(
        icon: Icons.account_balance_wallet_outlined,
        title: l10n.onboardingSlideOneTitle,
        body: l10n.onboardingSlideOneBody,
        accent: FeloColors.feloiBlue,
      ),
      _OnboardingSlide(
        icon: Icons.pie_chart_outline_rounded,
        title: l10n.onboardingSlideTwoTitle,
        body: l10n.onboardingSlideTwoBody,
        accent: FeloColors.feloiTeal,
      ),
      _OnboardingSlide(
        icon: Icons.sms_outlined,
        title: l10n.onboardingSlideThreeTitle,
        body: l10n.onboardingSlideThreeBody,
        accent: FeloColors.skyBlue,
        extra: const _SmsTrustPanel(),
      ),
      _OnboardingSlide(
        icon: Icons.school_outlined,
        title: l10n.onboardingSlideFourTitle,
        body: l10n.onboardingSlideFourBody,
        accent: FeloColors.royalPurple,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.onboardingTitle),
        actions: [
          TextButton(
            onPressed: () => context.go('/home'),
            child: Text(l10n.commonSkip),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                l10n.onboardingSubtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) => setState(() => _index = index),
                children: slides,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < slides.length; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: i == _index ? 28 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: i == _index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.outlineVariant,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FeloButton(
                    label: _index == slides.length - 1
                        ? l10n.commonCreateAccount
                        : l10n.commonContinue,
                    icon: Icons.arrow_forward_rounded,
                    onPressed: _continue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _continue() {
    if (_index == 3) {
      context.go('/auth');
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
    this.extra,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color accent;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      children: [
        const SizedBox(height: 8),
        _SamplePhone(accent: accent),
        const SizedBox(height: 24),
        CircleAvatar(
          radius: 28,
          backgroundColor: accent.withValues(alpha: 0.14),
          child: Icon(icon, color: accent),
        ),
        const SizedBox(height: 18),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        Text(
          body,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        if (extra != null) ...[const SizedBox(height: 20), extra!],
      ],
    );
  }
}

class _SamplePhone extends StatelessWidget {
  const _SamplePhone({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      label: l10n.sampleDesignLabel,
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: FeloColors.ink800,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.shield_outlined,
                  color: Colors.white70,
                  size: 20,
                ),
              ],
            ),
            const Spacer(),
            Text(
              l10n.homeNetPosition,
              style: const TextStyle(color: Colors.white60, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.sampleDashboardAmount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _MiniMetric(
                    label: l10n.homeBudgetLeft,
                    value: l10n.sampleBudgetAmount,
                    color: FeloColors.feloiTeal,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _MiniMetric(
                    label: l10n.sampleGoalName,
                    value: l10n.sampleOnTrack,
                    color: FeloColors.mintGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, color: color, size: 10),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmsTrustPanel extends StatelessWidget {
  const _SmsTrustPanel();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.smsTrustTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(l10n.smsTrustBody),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FeloChip(label: l10n.smsPatternOne, icon: Icons.check_rounded),
              FeloChip(label: l10n.smsPatternTwo, icon: Icons.check_rounded),
              FeloChip(label: l10n.smsPatternThree, icon: Icons.close_rounded),
            ],
          ),
          const SizedBox(height: 12),
          Text(l10n.smsRevoke, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
