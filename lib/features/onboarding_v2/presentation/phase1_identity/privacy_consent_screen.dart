import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/shared/widgets/felo_button.dart';

/// **Privacy & Consent Screen** — GDPR / PIPEDA compliant data consent.
///
/// Shown before signup method selection. User must explicitly consent to:
/// 1. Data collection and processing
/// 2. Storage location and encryption
/// 3. Data sharing with partners/regulators
/// 4. Their rights (access, delete, export)
class PrivacyConsentScreen extends ConsumerStatefulWidget {
  const PrivacyConsentScreen({super.key});

  @override
  ConsumerState<PrivacyConsentScreen> createState() => _PrivacyConsentScreenState();
}

class _PrivacyConsentScreenState extends ConsumerState<PrivacyConsentScreen>
    with OnboardingAnalyticsMixin<PrivacyConsentScreen> {
  @override
  int get phase => 1;

  @override
  String get stepId => 'phase1_privacy_consent';

  @override
  String get frdId => 'FR-1.0.1';

  bool _accepted = false;
  bool _busy = false;

  Future<void> _continue() async {
    if (!_accepted) {
      await onValidationError('consent_not_accepted');
      return;
    }
    await onContinue({'consentAccepted': true});
    if (!mounted) return;
    context.go('/onboarding-v2/signup-method');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return OnboardingShell(
      title: 'Your Privacy Matters',
      currentStep: 1,
      totalSteps: 15,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/welcome');
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text(
            'Before you begin, we want to be transparent about how we handle your data.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          _ConsentCard(
            icon: Icons.storage_outlined,
            title: 'What we collect',
            body:
                'We collect your email, phone number, transaction history, and device information solely to provide financial tracking and remittance services. We do not sell your data.',
          ),
          const SizedBox(height: 12),
          _ConsentCard(
            icon: Icons.lock_outline,
            title: 'How we protect it',
            body:
                'Your data is encrypted at rest (AES-256) and in transit (TLS 1.3). We use Supabase SOC 2 compliant infrastructure. Passwords are hashed with bcrypt.',
          ),
          const SizedBox(height: 12),
          _ConsentCard(
            icon: Icons.share_outlined,
            title: 'Who we share with',
            body:
                'We share data only with: (1) regulated payment partners to process transfers, (2) regulators when legally required, and (3) analytics providers in anonymized form.',
          ),
          const SizedBox(height: 12),
          _ConsentCard(
            icon: Icons.person_outline,
            title: 'Your rights',
            body:
                'You can access, export, correct, or delete your data at any time from Settings. Account deletion removes all personal data within 30 days (retaining anonymized audit logs for compliance).',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: _accepted,
                onChanged: (v) => setState(() => _accepted = v ?? false),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _accepted = !_accepted),
                  child: Text(
                    'I agree to the Privacy Policy and Terms of Service',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // In production, open full privacy policy URL
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Privacy Policy'),
                      content: const SingleChildScrollView(
                        child: Text(
                          'Full privacy policy will be hosted at https://felo.money/privacy\n\n'
                          'Key points:\n'
                          '• Data controller: Felo Financial Inc.\n'
                          '• DPO contact: privacy@felo.money\n'
                          '• Lawful basis: Contract necessity + Consent\n'
                          '• Retention: 7 years for financial records (regulatory), 30 days after account deletion for personal data\n'
                          '• Cross-border transfers: Canada (primary), US (Supabase hosting), Pakistan (remittance processing)\n'
                          '• Automated decisions: FX rate selection (no profiling)\n'
                          '• Complaints: You may lodge a complaint with the Office of the Privacy Commissioner of Canada.',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Read full Privacy Policy'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Terms of Service'),
                      content: const SingleChildScrollView(
                        child: Text(
                          'Full terms will be hosted at https://felo.money/terms\n\n'
                          '• You must be 18+ to use Felo\n'
                          '• You are responsible for accurate transaction data\n'
                          '• Felo is not a bank; funds are not FDIC/CMHC insured\n'
                          '• Remittances are subject to KYC/AML verification\n'
                          '• We may suspend accounts for suspicious activity\n'
                          '• Dispute resolution: Arbitration in Toronto, Ontario',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Read Terms of Service'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FeloButton(
            label: _busy ? '...' : 'Continue',
            onPressed: _busy ? null : _continue,
          ),
        ],
      ),
    );
  }
}

class _ConsentCard extends StatelessWidget {
  const _ConsentCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
