import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/network/dio_provider.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/loading_status_item.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';

/// **FR-7.0.1..7.0.8** — Phase 7 personalization loading screen (D-025).
///
/// Visual UX:
/// - Six cycling status rows (LoadingStatusItem) animate pending →
///   inProgress → complete as the orchestrator works.
/// - Friendly "We're building your dashboard…" headline above.
/// - Auto-routes to /onboarding-v2/dashboard-handoff on success;
///   shows retry on failure (FR-7.0.8).
///
/// Mechanism:
/// - On mount: POST /v1/onboarding/complete (server-side fan-out).
/// - We optimistically advance the local UI (200ms cadence) while the
///   server runs so the user perceives instant progress; on response
///   we reconcile against the server's `steps[]` ground truth.
class PersonalizeScreen extends ConsumerStatefulWidget {
  const PersonalizeScreen({super.key});

  @override
  ConsumerState<PersonalizeScreen> createState() => _PersonalizeScreenState();
}

class _PersonalizeScreenState extends ConsumerState<PersonalizeScreen>
    with OnboardingAnalyticsMixin<PersonalizeScreen> {
  @override
  int get phase => 7;

  @override
  String get stepId => 'phase7_step1';

  @override
  String get frdId => 'FR-7.0.1';

  // Step keys must match server `complete.service.ts` `steps[].key`.
  static const List<({String key, String label})> _steps = [
    (key: 'profile', label: 'Saving your profile…'),
    (key: 'budget', label: 'Setting up your budget envelopes…'),
    (key: 'goals', label: 'Pinning your goals…'),
    (key: 'corridors', label: 'Mapping your remittance corridors…'),
    (key: 'accounts', label: 'Preparing your account cards…'),
    (key: 'dashboard', label: 'Building your dashboard…'),
  ];

  Map<String, LoadingStatusState> _status = {};
  Object? _error;
  Timer? _ticker;
  int _optimisticIndex = 0;

  @override
  void initState() {
    super.initState();
    _status = {for (final s in _steps) s.key: LoadingStatusState.pending};
    _runComplete();
    _startOptimisticTicker();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  /// Advance the visual indicator every 250ms even while the network
  /// request is in flight — D-025: the UI must feel instant.
  void _startOptimisticTicker() {
    _ticker = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (!mounted) return;
      if (_optimisticIndex >= _steps.length) return;
      final key = _steps[_optimisticIndex].key;
      setState(() {
        // Mark previous as complete (if not already failed)
        if (_optimisticIndex > 0) {
          final prevKey = _steps[_optimisticIndex - 1].key;
          if (_status[prevKey] != LoadingStatusState.failed) {
            _status[prevKey] = LoadingStatusState.complete;
          }
        }
        _status[key] = LoadingStatusState.inProgress;
      });
      _optimisticIndex++;
    });
  }

  Future<void> _runComplete() async {
    final dio = ref.read(dioProvider);
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/onboarding/complete',
      );
      // Reconcile against server's authoritative steps list
      final serverSteps =
          (response.data?['steps'] as List<dynamic>?) ?? const [];
      _ticker?.cancel();
      if (!mounted) return;
      setState(() {
        for (final raw in serverSteps) {
          final step = raw as Map<String, dynamic>;
          final key = step['key']?.toString();
          final status = step['status']?.toString();
          if (key == null) continue;
          _status[key] = switch (status) {
            'ok' => LoadingStatusState.complete,
            'skipped' => LoadingStatusState.complete,
            'failed' => LoadingStatusState.failed,
            _ => _status[key] ?? LoadingStatusState.pending,
          };
        }
      });

      // Persist the local "completed" marker
      await ref
          .read(onboardingStateControllerProvider.notifier)
          .markStepCompleted('phase7_complete');

      await onContinue({
        'goal_count': (response.data?['goal_ids'] as List?)?.length ?? 0,
        'corridor_count': (response.data?['corridor_ids'] as List?)?.length ?? 0,
        'widgets':
            (response.data?['dashboard_widgets'] as List?)?.cast<String>() ??
                const <String>[],
      });

      // Slight pause so user sees the final ✓ before nav.
      await Future<void>.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      context.go('/onboarding-v2/dashboard-handoff');
    } on DioException catch (e) {
      _ticker?.cancel();
      if (!mounted) return;
      setState(() {
        _error = e;
        // Mark current step as failed
        if (_optimisticIndex > 0 && _optimisticIndex <= _steps.length) {
          final key = _steps[_optimisticIndex - 1].key;
          _status[key] = LoadingStatusState.failed;
        }
      });
      await onValidationError('complete_failed');
    } catch (e) {
      _ticker?.cancel();
      if (!mounted) return;
      setState(() => _error = e);
    }
  }

  Future<void> _retry() async {
    setState(() {
      _error = null;
      _optimisticIndex = 0;
      _status = {for (final s in _steps) s.key: LoadingStatusState.pending};
    });
    _startOptimisticTicker();
    await _runComplete();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      title: '',
      currentStep: 14,
      totalSteps: 14,
      // Phase 7 is non-interruptible — no back button while running.
      onBack: _error == null
          ? null
          : () async {
              await onBackPressed();
              if (!mounted) return;
              context.go('/onboarding-v2/corridor');
            },
      bottomActions: _error == null
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(8),
              child: FilledButton(
                onPressed: _retry,
                child: const Text('Try again'),
              ),
            ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          Container(
            width: 96,
            height: 96,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: FeloColors.mintBase.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: FeloColors.feloiTeal,
              size: 48,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Personalizing your FELO',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "We're building your dashboard around what you told us.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 32),
          for (final step in _steps)
            LoadingStatusItem(
              label: step.label,
              state: _status[step.key] ?? LoadingStatusState.pending,
            ),
          if (_error != null) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.red.shade700),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Couldn't finish setup. Check your connection and tap Try again.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
