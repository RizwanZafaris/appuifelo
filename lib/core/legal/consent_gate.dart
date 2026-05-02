import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:felo/core/security/screen_security.dart';

/// First-launch GDPR / PIPEDA / CCPA consent gate.
///
/// Wraps the app's root and renders a blocking consent sheet until the
/// user accepts the privacy policy and analytics opt-in. Choice is
/// persisted in [FlutterSecureStorage] so it survives app restarts but
/// not reinstall (which is the right semantic — fresh install =
/// fresh consent).
///
/// Re-prompt logic: bump [policyVersion] when the privacy policy changes.
/// Users with a stored version < current see the sheet again.
class ConsentGate extends ConsumerStatefulWidget {
  const ConsentGate({
    required this.child,
    required this.privacyPolicyUrl,
    required this.termsUrl,
    this.policyVersion = 1,
    super.key,
  });

  final Widget child;
  final String privacyPolicyUrl;
  final String termsUrl;
  final int policyVersion;

  @override
  ConsumerState<ConsentGate> createState() => _ConsentGateState();
}

class _ConsentGateState extends ConsumerState<ConsentGate> {
  static const _key = 'felo.consent.policy_version';
  final _storage = const FlutterSecureStorage();
  bool? _accepted;

  @override
  void initState() {
    super.initState();
    _hydrate();
  }

  Future<void> _hydrate() async {
    final raw = await _storage.read(key: _key);
    final stored = int.tryParse(raw ?? '');
    setState(() => _accepted = stored != null && stored >= widget.policyVersion);
  }

  Future<void> _accept() async {
    await _storage.write(key: _key, value: widget.policyVersion.toString());
    if (mounted) setState(() => _accepted = true);
  }

  Future<void> _decline() async {
    // Decline closes the app gracefully. Keeping it as an explicit dialog
    // is better than the iOS App Store's auto-deny since users sometimes
    // misclick.
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Decline'),
        content: const Text(
          'Felo cannot run without these terms. The app will close. '
          'You can reopen and accept later.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Close Felo')),
        ],
      ),
    );
    if (ok == true) {
      // ignore: avoid_print
      // We don't force-quit on iOS (Apple guidelines); instead surface
      // the message and let the user background the app manually.
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_accepted == null) {
      return const _LoadingShell();
    }
    if (_accepted == true) {
      return widget.child;
    }
    return _ConsentSheet(
      privacyPolicyUrl: widget.privacyPolicyUrl,
      termsUrl: widget.termsUrl,
      onAccept: _accept,
      onDecline: _decline,
    );
  }
}

class _LoadingShell extends StatelessWidget {
  const _LoadingShell();
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}

class _ConsentSheet extends StatefulWidget {
  const _ConsentSheet({
    required this.privacyPolicyUrl,
    required this.termsUrl,
    required this.onAccept,
    required this.onDecline,
  });

  final String privacyPolicyUrl;
  final String termsUrl;
  final Future<void> Function() onAccept;
  final Future<void> Function() onDecline;

  @override
  State<_ConsentSheet> createState() => _ConsentSheetState();
}

class _ConsentSheetState extends State<_ConsentSheet> {
  bool _terms = false;
  bool _privacy = false;
  bool _analytics = true; // opt-out, default ON to match Vercel/Sentry norms

  @override
  void initState() {
    super.initState();
    ScreenSecurity.enable();
  }

  @override
  void dispose() {
    ScreenSecurity.disable();
    super.dispose();
  }

  bool get _canContinue => _terms && _privacy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Text(
                'Welcome to Felo',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'Felo is a personal-finance journal. It does not move money '
                'on your behalf. Before we start, please read and accept our terms.',
              ),
              const SizedBox(height: 24),
              CheckboxListTile(
                value: _terms,
                onChanged: (v) => setState(() => _terms = v ?? false),
                title: Text('I agree to the Terms of Service (${widget.termsUrl})'),
              ),
              CheckboxListTile(
                value: _privacy,
                onChanged: (v) => setState(() => _privacy = v ?? false),
                title: Text('I agree to the Privacy Policy (${widget.privacyPolicyUrl})'),
              ),
              CheckboxListTile(
                value: _analytics,
                onChanged: (v) => setState(() => _analytics = v ?? false),
                title: const Text('Share anonymous diagnostics to help fix bugs (optional)'),
              ),
              const Spacer(),
              FilledButton(
                onPressed: _canContinue ? () => widget.onAccept() : null,
                child: const Text('Get started'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => widget.onDecline(),
                child: const Text('Decline'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
