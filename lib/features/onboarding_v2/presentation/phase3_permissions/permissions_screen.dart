import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_service.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_state_controller.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/permission_card.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **FR-3.0.1..3.4.1 + FR-3.0.2** — Phase 3 permissions.
///
/// 4 permission cards composed from the universal `PermissionCard`
/// widget. Each card is independently skippable per D-014. iOS hides
/// SMS card. Continue enabled once user has interacted with all
/// non-optional cards.
class PermissionsScreen extends ConsumerStatefulWidget {
  const PermissionsScreen({super.key});

  @override
  ConsumerState<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends ConsumerState<PermissionsScreen>
    with OnboardingAnalyticsMixin<PermissionsScreen> {
  @override
  int get phase => 3;

  @override
  String get stepId => 'phase3';

  @override
  String get frdId => 'FR-3.0.1';

  bool? _sms;
  bool? _notifications;
  bool? _location;
  bool? _contactsAck;

  bool get _smsCardVisible {
    if (kIsWeb) return false;
    return Platform.isAndroid;
  }

  bool get _canContinue {
    // SMS + notifications are required-interaction; location + contacts
    // are optional and the screen advances even if they're untouched.
    final smsOk = !_smsCardVisible || _sms != null;
    return smsOk && _notifications != null;
  }

  void _grantSms(bool granted) {
    setState(() => _sms = granted);
    _fire(granted ? 'phase3_sms_grant' : 'phase3_sms_skip');
  }

  void _grantNotifications(bool granted) {
    setState(() => _notifications = granted);
    _fire(granted ? 'phase3_notif_grant' : 'phase3_notif_skip');
  }

  void _grantLocation(bool granted) {
    setState(() => _location = granted);
    _fire(granted ? 'phase3_location_grant' : 'phase3_location_skip');
  }

  void _ackContacts(bool ackd) {
    setState(() => _contactsAck = ackd);
    _fire('phase3_contacts_skip');
  }

  Future<void> _fire(String name) async {
    await ref
        .read(onboardingAnalyticsServiceProvider.notifier)
        .fire(
          CanonicalEvent(
            eventName: name,
            frdId: frdId,
            stepId: stepId,
            phase: phase,
            sessionId: OnboardingAnalyticsMixin.sessionId,
            occurredAt: DateTime.now(),
          ),
        );
  }

  Future<void> _continue() async {
    await ref
        .read(onboardingStateControllerProvider.notifier)
        .patch(
          (s) => s.copyWith(
            smsGranted: _sms,
            notificationsGranted: _notifications,
            locationGranted: _location,
            contactsAck: _contactsAck,
          ),
        );
    await onContinue({
      'sms': _sms,
      'notif': _notifications,
      'location': _location,
    });
    if (!mounted) return;
    context.go('/onboarding-v2/earning-type');
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      title: 'Help us help you',
      currentStep: 6,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/name');
      },
      bottomActions: FeloButton(
        label: 'Continue',
        onPressed: _canContinue ? _continue : null,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text(
            "Tap Allow if you want the feature, or Not now to skip. Skipping never blocks anything.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          if (_smsCardVisible) ...[
            PermissionCard(
              icon: Icons.sms_outlined,
              title: 'Auto-track every transaction',
              body:
                  "If your bank sends transaction SMS to this device, FELO will categorize them automatically. You'll never type a number.",
              granted: _sms,
              skipped: _sms == false,
              onAllow: () => _grantSms(true),
              onSkip: () => _grantSms(false),
            ),
            const SizedBox(height: 12),
          ],
          PermissionCard(
            icon: Icons.notifications_active_outlined,
            title: 'Stay on top of your money',
            body: 'Bill reminders, budget alerts, and goal updates.',
            granted: _notifications,
            skipped: _notifications == false,
            onAllow: () => _grantNotifications(true),
            onSkip: () => _grantNotifications(false),
          ),
          const SizedBox(height: 12),
          PermissionCard(
            icon: Icons.place_outlined,
            title: 'Smart category suggestions',
            body:
                'We can suggest categories based on where you spent — totally optional.',
            granted: _location,
            skipped: _location == false,
            onAllow: () => _grantLocation(true),
            onSkip: () => _grantLocation(false),
            isOptional: true,
          ),
          const SizedBox(height: 12),
          PermissionCard(
            icon: Icons.contacts_outlined,
            title: 'Send money to family faster',
            body:
                "For when you want to split bills or send money — coming soon.",
            granted: _contactsAck,
            skipped: _contactsAck == false,
            onAllow: () => _ackContacts(true),
            onSkip: () => _ackContacts(false),
            isOptional: true,
            allowLabel: 'Got it',
            skipLabel: 'Skip',
          ),
        ],
      ),
    );
  }
}
