import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
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

/// MFA / TOTP setup — QR code placeholder + 6-digit input + recovery codes.
class MfaSetupScreen extends ConsumerStatefulWidget {
  const MfaSetupScreen({super.key});

  @override
  ConsumerState<MfaSetupScreen> createState() => _MfaSetupScreenState();
}

class _MfaSetupScreenState extends ConsumerState<MfaSetupScreen> {
  final _codeController = TextEditingController();
  bool _verified = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.mfaTitle,
      selectedTab: FeloRootTab.home,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.mfaBody),
          const SizedBox(height: 16),
          FeloCard(
            child: SizedBox(
              height: 180,
              child: Center(
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.qr_code_2_rounded,
                    size: 140,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          FeloCard(
            onTap: () async {
              final messenger = ScaffoldMessenger.of(context);
              final copiedLabel = l10n.mfaSecretCopied;
              await Clipboard.setData(
                const ClipboardData(text: 'JBSWY3DPEHPK3PXP'),
              );
              if (!mounted) return;
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
            controller: _codeController,
            keyboardType: TextInputType.number,
          ),
          if (_verified) ...[
            const SizedBox(height: 12),
            FeloCard(
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: FeloColors.feloiTeal,
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(l10n.mfaVerified)),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          FeloButton(
            label: _verified ? l10n.commonDone : l10n.mfaVerifyCta,
            onPressed: () {
              if (_verified) {
                context.go('/profile');
              } else if (_codeController.text.trim().length == 6) {
                setState(() => _verified = true);
              }
            },
          ),
        ],
      ),
    );
  }
}

/// Biometric lock toggle screen.
class BiometricLockScreen extends ConsumerStatefulWidget {
  const BiometricLockScreen({super.key});

  @override
  ConsumerState<BiometricLockScreen> createState() =>
      _BiometricLockScreenState();
}

class _BiometricLockScreenState extends ConsumerState<BiometricLockScreen> {
  bool _enabled = false;
  Duration _autoLock = const Duration(minutes: 1);

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
          FeloCard(
            child: SwitchListTile.adaptive(
              value: _enabled,
              onChanged: (v) => setState(() => _enabled = v),
              title: Text(l10n.biometricEnable),
              secondary: const Icon(Icons.fingerprint_rounded),
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
                      Expanded(
                        child: Text(_optionLabel(l10n, option.$2)),
                      ),
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
