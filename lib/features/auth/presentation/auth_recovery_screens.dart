import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/security/biometric_service.dart';
import 'package:felo/core/security/screen_security.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/features/auth/data/mfa_repository.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

/// Forgot-password flow: email entry → "check your inbox" confirmation.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.forgotPasswordTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: _sent
            ? [
                FeloCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.mark_email_read_outlined, size: 36),
                      const SizedBox(height: 12),
                      Text(
                        l10n.forgotPasswordSentTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(l10n.forgotPasswordSentBody),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                FeloButton(
                  label: l10n.commonDone,
                  onPressed: () => context.go('/auth'),
                ),
              ]
            : [
                Text(l10n.forgotPasswordBody),
                const SizedBox(height: 16),
                FeloInput(
                  label: l10n.authEmailLabel,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                FeloButton(
                  label: l10n.forgotPasswordSendCta,
                  onPressed: () => setState(() => _sent = true),
                ),
              ],
      ),
    );
  }
}

/// Email-verification waiting screen with resend cooldown.
class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  int _cooldown = 0;

  void _resend() {
    setState(() => _cooldown = 30);
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => _cooldown--);
      return _cooldown > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.emailVerifyTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.alternate_email_rounded, size: 36),
                const SizedBox(height: 12),
                Text(
                  l10n.emailVerifyHeading,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(l10n.emailVerifyBody),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FeloButton(
            label: _cooldown == 0
                ? l10n.emailVerifyResend
                : l10n.emailVerifyResendIn(_cooldown.toString()),
            variant: FeloButtonVariant.secondary,
            onPressed: _cooldown == 0 ? _resend : null,
          ),
          const SizedBox(height: 8),
          FeloButton(
            label: l10n.commonDone,
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
    );
  }
}

/// MFA / TOTP setup — enrolls with the backend, then verifies a TOTP code.
class MfaSetupScreen extends ConsumerStatefulWidget {
  const MfaSetupScreen({super.key});

  @override
  ConsumerState<MfaSetupScreen> createState() => _MfaSetupScreenState();
}

class _MfaSetupScreenState extends ConsumerState<MfaSetupScreen> {
  final _codeController = TextEditingController();
  bool _verifying = false;
  String? _errorText;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final enrollment = ref.watch(mfaEnrollmentProvider);
    return FeloScaffold(
      title: l10n.mfaTitle,
      selectedTab: FeloRootTab.home,
      child: enrollment.when(
        data: (data) => _MfaEnrollmentBody(
          enrollment: data,
          codeController: _codeController,
          errorText: _errorText,
          verifying: _verifying,
          onVerify: _verify,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            FeloCard(
              child: Row(
                children: [
                  const Icon(Icons.error_outline_rounded),
                  const SizedBox(width: 12),
                  Expanded(child: Text(l10n.mfaWrongCode)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FeloButton(
              label: l10n.commonContinue,
              variant: FeloButtonVariant.secondary,
              onPressed: () => ref.invalidate(mfaEnrollmentProvider),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verify() async {
    final l10n = context.l10n;
    final code = _codeController.text.trim();
    if (code.length != 6) {
      setState(() => _errorText = l10n.mfaWrongCode);
      return;
    }

    setState(() {
      _verifying = true;
      _errorText = null;
    });

    try {
      final codes = await ref
          .read(mfaRepositoryProvider)
          .verifyEnrollment(code);
      ref.invalidate(mfaStatusProvider);
      if (!mounted) return;
      context.go('/auth/mfa/recovery-codes', extra: codes);
    } catch (_) {
      if (!mounted) return;
      setState(() => _errorText = l10n.mfaWrongCode);
    } finally {
      if (mounted) {
        setState(() => _verifying = false);
      }
    }
  }
}

class _MfaEnrollmentBody extends StatelessWidget {
  const _MfaEnrollmentBody({
    required this.enrollment,
    required this.codeController,
    required this.errorText,
    required this.verifying,
    required this.onVerify,
  });

  final MfaEnrollment enrollment;
  final TextEditingController codeController;
  final String? errorText;
  final bool verifying;
  final VoidCallback onVerify;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(l10n.mfaBody),
        const SizedBox(height: 16),
        FeloCard(
          child: Column(
            children: [
              SizedBox(
                height: 196,
                child: Center(
                  child: _QrCodeImage(dataUrl: enrollment.qrPngDataUrl),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.mfaScanQrPrompt,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        FeloCard(
          onTap: () async {
            final messenger = ScaffoldMessenger.of(context);
            final copiedLabel = l10n.mfaSecretCopied;
            await Clipboard.setData(ClipboardData(text: enrollment.secret));
            messenger.showSnackBar(SnackBar(content: Text(copiedLabel)));
          },
          child: Row(
            children: [
              const Icon(Icons.key_outlined),
              const SizedBox(width: 12),
              Expanded(child: Text(l10n.mfaCopySecret)),
              const Icon(Icons.copy_rounded, size: 18),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FeloInput(
          label: l10n.mfaCodeLabel,
          controller: codeController,
          keyboardType: TextInputType.number,
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            errorText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
        const SizedBox(height: 20),
        FeloButton(
          label: verifying ? l10n.mfaVerifyCta : l10n.mfaVerifyCta,
          onPressed: verifying ? null : onVerify,
        ),
      ],
    );
  }
}

class _QrCodeImage extends StatelessWidget {
  const _QrCodeImage({required this.dataUrl});

  final String dataUrl;

  @override
  Widget build(BuildContext context) {
    final bytes = _pngBytes(dataUrl);
    return Container(
      width: 172,
      height: 172,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: bytes == null
          ? const Icon(Icons.qr_code_2_rounded, size: 140, color: Colors.black)
          : Image.memory(bytes, fit: BoxFit.contain),
    );
  }

  Uint8List? _pngBytes(String dataUrl) {
    final comma = dataUrl.indexOf(',');
    if (comma == -1) return null;
    try {
      return base64Decode(dataUrl.substring(comma + 1));
    } on FormatException {
      return null;
    }
  }
}

class MfaRecoveryCodesScreen extends StatelessWidget {
  const MfaRecoveryCodesScreen({required this.recoveryCodes, super.key});

  final List<String> recoveryCodes;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.mfaRecoveryCodesTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded),
                const SizedBox(width: 12),
                Expanded(child: Text(l10n.mfaRecoveryCodesWarning)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final code in recoveryCodes)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      code,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFeatures: const [FontFeature.tabularFigures()],
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FeloButton(
            label: l10n.mfaCopyAllCodes,
            icon: Icons.copy_rounded,
            onPressed: recoveryCodes.isEmpty
                ? null
                : () async {
                    final messenger = ScaffoldMessenger.of(context);
                    await Clipboard.setData(
                      ClipboardData(text: recoveryCodes.join('\n')),
                    );
                    messenger.showSnackBar(
                      SnackBar(content: Text(l10n.mfaCopyAllCodes)),
                    );
                  },
          ),
          const SizedBox(height: 8),
          FeloButton(
            label: l10n.commonDone,
            variant: FeloButtonVariant.secondary,
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
    );
  }
}

/// Biometric lock toggle screen.
///
/// Wires the real `BiometricService` (local_auth + flutter_secure_storage)
/// instead of a `bool` toggle. Flow:
///   - On open, query `isAvailable` to decide whether to render the switch.
///   - On open, query `isEnabled` to reflect persisted state.
///   - Toggling on → prompt biometric. On success, persist enabled=true.
///   - Toggling off → disable + remove persisted flag.
///   - On any sensitive screen entry, callers should call
///     `BiometricService.authenticate(...)` and FLAG_SECURE the screen
///     via `ScreenSecurity.enable()`.
class BiometricLockScreen extends ConsumerStatefulWidget {
  const BiometricLockScreen({super.key, BiometricService? service})
      : _injected = service;

  final BiometricService? _injected;

  @override
  ConsumerState<BiometricLockScreen> createState() =>
      _BiometricLockScreenState();
}

class _BiometricLockScreenState extends ConsumerState<BiometricLockScreen> {
  late final BiometricService _service =
      widget._injected ?? BiometricService();

  bool _available = false;
  bool _enabled = false;
  bool _busy = false;
  Duration _autoLock = const Duration(minutes: 1);

  @override
  void initState() {
    super.initState();
    // Lock the screen against screenshots / recording while we render
    // controls that may eventually show recovery codes.
    ScreenSecurity.enable();
    _hydrate();
  }

  @override
  void dispose() {
    ScreenSecurity.disable();
    super.dispose();
  }

  Future<void> _hydrate() async {
    final available = await _service.isAvailable();
    final enabled = await _service.isEnabled();
    if (!mounted) return;
    setState(() {
      _available = available;
      _enabled = enabled;
    });
  }

  Future<void> _toggle(bool target) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      if (target) {
        final ok = await _service.enable(
          reason: 'Allow Felo to use your biometric to unlock the app',
        );
        if (!mounted) return;
        setState(() => _enabled = ok);
      } else {
        await _service.disable();
        if (!mounted) return;
        setState(() => _enabled = false);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.biometricTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.biometricBody),
          const SizedBox(height: 16),
          if (!_available)
            FeloCard(
              child: ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: Text(l10n.biometricUnavailable),
              ),
            )
          else
            FeloCard(
              child: SwitchListTile.adaptive(
                value: _enabled,
                onChanged: _busy ? null : _toggle,
                title: Text(l10n.biometricEnable),
                secondary: _busy
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.fingerprint_rounded),
              ),
            ),
          if (_enabled) ...[
            const SizedBox(height: 8),
            Text(
              l10n.biometricAutoLock,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            for (final option in const [
              (Duration(seconds: 0), 'biometricImmediate'),
              (Duration(minutes: 1), 'biometricAfter1Min'),
              (Duration(minutes: 5), 'biometricAfter5Min'),
              (Duration(minutes: 15), 'biometricAfter15Min'),
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: FeloCard(
                  onTap: () => setState(() => _autoLock = option.$1),
                  child: Row(
                    children: [
                      Expanded(child: Text(_optionLabel(l10n, option.$2))),
                      if (_autoLock == option.$1)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: FeloColors.feloiTeal,
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  String _optionLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'biometricImmediate':
        return l10n.biometricImmediate;
      case 'biometricAfter1Min':
        return l10n.biometricAfter1Min;
      case 'biometricAfter5Min':
        return l10n.biometricAfter5Min;
      case 'biometricAfter15Min':
        return l10n.biometricAfter15Min;
      default:
        return '';
    }
  }
}
