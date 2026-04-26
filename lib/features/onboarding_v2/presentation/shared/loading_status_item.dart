import 'package:flutter/material.dart';

import 'package:felo/core/theme/felo_colors.dart';

enum LoadingStatusState { pending, inProgress, complete, failed }

/// Universal status row for Phase 7 loading screen (D-025).
///
/// One row per cycling status message. ✓ when complete, spinner while
/// in progress, faded when pending, red ⚠ on failure.
class LoadingStatusItem extends StatelessWidget {
  const LoadingStatusItem({
    required this.label,
    required this.state,
    super.key,
  });

  final String label;
  final LoadingStatusState state;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _icon(colors),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: switch (state) {
                      LoadingStatusState.complete => colors.onSurface,
                      LoadingStatusState.inProgress => colors.onSurface,
                      LoadingStatusState.pending => colors.onSurfaceVariant
                          .withValues(alpha: 0.6),
                      LoadingStatusState.failed => Colors.red.shade400,
                    },
                    fontWeight: state == LoadingStatusState.complete
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
              child: Text(label),
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(ColorScheme colors) {
    switch (state) {
      case LoadingStatusState.complete:
        return const Icon(
          Icons.check_circle_rounded,
          key: ValueKey('complete'),
          color: FeloColors.feloiTeal,
          size: 22,
        );
      case LoadingStatusState.inProgress:
        return const SizedBox(
          key: ValueKey('progress'),
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(FeloColors.feloiTeal),
          ),
        );
      case LoadingStatusState.failed:
        return Icon(
          Icons.error_outline_rounded,
          key: const ValueKey('failed'),
          color: Colors.red.shade400,
          size: 22,
        );
      case LoadingStatusState.pending:
        return Container(
          key: const ValueKey('pending'),
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
        );
    }
  }
}
