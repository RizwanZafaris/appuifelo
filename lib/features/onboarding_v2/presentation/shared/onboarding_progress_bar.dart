import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';

/// Dynamic progress bar shown on every onboarding screen except Welcome
/// and Phase 7 loading. Recalculates when conditional branches resolve
/// (e.g., domestic-only Pakistani has 14 total steps; diaspora investor
/// has 17).
class OnboardingProgressBar extends StatelessWidget {
  const OnboardingProgressBar({
    required this.currentStep,
    required this.totalSteps,
    super.key,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final progress =
        totalSteps == 0 ? 0.0 : (currentStep / totalSteps).clamp(0.0, 1.0);
    return SizedBox(
      height: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 4,
          backgroundColor: FeloColors.mintBase.withValues(alpha: 0.25),
          valueColor: const AlwaysStoppedAnimation<Color>(FeloColors.feloiTeal),
        ),
      ),
    );
  }
}
