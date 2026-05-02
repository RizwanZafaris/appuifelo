import 'package:flutter/material.dart';

/// Wraps a stub feature screen with a feature-flag check.
///
/// In production builds the flag defaults to `false` (see
/// `lib/core/config/felo_env.dart`) so users see a clean
/// "Coming soon" placeholder instead of the unfinished UI. In debug
/// builds, the flag can be flipped via `--dart-define` for previews.
class StubGate extends StatelessWidget {
  const StubGate({
    required this.enabled,
    required this.featureName,
    required this.child,
    super.key,
  });

  final bool enabled;
  final String featureName;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (enabled) return child;
    return Scaffold(
      appBar: AppBar(title: Text(featureName)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.construction_outlined, size: 64),
              const SizedBox(height: 16),
              Text(
                '$featureName is coming soon',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'We\'ll let you know the moment it\'s ready. Thanks for your patience.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
