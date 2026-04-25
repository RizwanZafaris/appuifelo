import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FeloMark(size: 72),
              const Spacer(),
              Text(
                l10n.appName,
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.splashTitle,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.splashBody,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              FeloCard(
                child: Row(
                  children: [
                    const Icon(
                      Icons.verified_user_rounded,
                      color: FeloColors.feloiTeal,
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(l10n.splashTrust)),
                  ],
                ),
              ),
              const Spacer(),
              FeloButton(
                label: l10n.commonGetStarted,
                icon: Icons.arrow_forward_rounded,
                onPressed: () => context.go('/onboarding'),
              ),
              const SizedBox(height: 12),
              FeloButton(
                label: l10n.commonSignIn,
                variant: FeloButtonVariant.ghost,
                onPressed: () => context.go('/auth'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeloMark extends StatelessWidget {
  const _FeloMark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            FeloColors.feloiBlue,
            FeloColors.skyBlue,
            FeloColors.feloiTeal,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.35),
      ),
      child: Center(
        child: Text(
          'F',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
