import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';

/// Universal permission card — Phase 3 cards (D-014).
///
/// One file controls all 4 permission cards (SMS, notifications,
/// location, contacts). Change styling here → all 4 update.
class PermissionCard extends StatelessWidget {
  const PermissionCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.onAllow,
    required this.onSkip,
    this.granted,
    this.skipped,
    this.isOptional = false,
    this.allowLabel = 'Allow',
    this.skipLabel = 'Not now',
    super.key,
  });

  final IconData icon;
  final String title;
  final String body;
  final VoidCallback onAllow;
  final VoidCallback onSkip;
  final bool? granted;
  final bool? skipped;
  final bool isOptional;
  final String allowLabel;
  final String skipLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final settled = granted == true || skipped == true;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: granted == true
            ? FeloColors.mintBase.withValues(alpha: 0.18)
            : colors.surfaceContainerHighest.withValues(alpha: 0.5),
        border: Border.all(
          color: granted == true
              ? FeloColors.feloiTeal
              : colors.outlineVariant.withValues(alpha: 0.4),
          width: granted == true ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: FeloColors.mintBase.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: FeloColors.feloiTeal),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        if (isOptional)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              'Optional',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      body,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: settled ? null : onSkip,
                  child: Text(skipLabel),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: settled ? null : onAllow,
                  child: Text(
                    granted == true
                        ? 'Allowed'
                        : skipped == true
                        ? 'Skipped'
                        : allowLabel,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
