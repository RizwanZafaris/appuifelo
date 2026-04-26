import 'package:flutter/material.dart';

import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_progress_bar.dart';

/// Wraps every Phase 1-8 screen with the standard onboarding chrome:
/// - Back button (top-left) — fires `onBackPressed` analytics via mixin
/// - Optional progress bar (hidden on Welcome and Phase 7)
/// - Safe-area + scrollable body
///
/// Screens that mix in `OnboardingAnalyticsMixin` should pass
/// `onBack: () => onBackPressed(); Navigator.of(context).pop();` so the
/// `_back` event fires before navigation.
class OnboardingShell extends StatelessWidget {
  const OnboardingShell({
    required this.body,
    this.title,
    this.showBackButton = true,
    this.showProgressBar = true,
    this.currentStep = 0,
    this.totalSteps = 14,
    this.onBack,
    this.bottomActions,
    this.padding = const EdgeInsets.fromLTRB(20, 8, 20, 24),
    super.key,
  });

  final Widget body;
  final String? title;
  final bool showBackButton;
  final bool showProgressBar;
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;
  final Widget? bottomActions;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top bar: back button + progress
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
              child: Row(
                children: [
                  if (showBackButton)
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      tooltip: 'Back',
                      onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                    )
                  else
                    const SizedBox(width: 48), // align with right side
                  if (showProgressBar)
                    Expanded(
                      child: OnboardingProgressBar(
                        currentStep: currentStep,
                        totalSteps: totalSteps,
                      ),
                    ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: padding,
                child: body,
              ),
            ),
            if (bottomActions != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: bottomActions!,
              ),
          ],
        ),
      ),
    );
  }
}
