import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/supabase/supabase_provider.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_input.dart';

/// Sign-in / sign-up screen with email + password, Google, and Apple OAuth.
///
/// Password policy enforced client-side (min 8 chars, 1 uppercase, 1 lowercase,
/// 1 digit, 1 special character). Region and language are auto-detected from
/// device locale instead of hardcoded.
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() => _runAuth(
        (auth) => auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );

  Future<void> _signUp() => _runAuth(
        (auth) => auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          data: {
            'corridor': _detectCorridor(),
            'language_code': _detectLanguage(),
          },
        ),
      );

  String _detectCorridor() {
    try {
      final locale = Platform.localeName.toLowerCase();
      if (locale.contains('ca') || locale.contains('en_ca')) return 'canada';
      if (locale.contains('pk') || locale.contains('en_pk') || locale.contains('ur')) return 'pakistan';
      return 'global';
    } catch (_) {
      return 'global';
    }
  }

  String _detectLanguage() {
    try {
      final locale = Platform.localeName.toLowerCase();
      if (locale.startsWith('ur')) return 'ur';
      if (locale.startsWith('fr')) return 'fr';
      return 'en';
    } catch (_) {
      return 'en';
    }
  }

  bool _isPasswordValid(String password) {
    if (password.length < 8) return false;
    if (!RegExp(r'[A-Z]').hasMatch(password)) return false;
    if (!RegExp(r'[a-z]').hasMatch(password)) return false;
    if (!RegExp(r'[0-9]').hasMatch(password)) return false;
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_+=\-\[\]]').hasMatch(password)) return false;
    return true;
  }

  Future<void> _runAuth(
    Future<AuthResponse> Function(GoTrueClient auth) op,
  ) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || !_isPasswordValid(password)) {
      setState(
        () => _error = 'Enter email + a password of 8+ characters with uppercase, lowercase, number, and special character.',
      );
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final supabase = ref.read(supabaseClientProvider);
      final response = await op(supabase.auth);
      if (response.user != null && mounted) {
        context.go('/home');
      }
    } on AuthException catch (e) {
      if (mounted) {
        setState(() => _error = _sanitizeAuthError(e.message));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = 'Sign-in failed. Please try again.');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _sanitizeAuthError(String raw) {
    // Don't leak internal Supabase error details to users
    final lower = raw.toLowerCase();
    if (lower.contains('invalid login credentials')) {
      return 'Invalid email or password. Please try again.';
    }
    if (lower.contains('user not found')) {
      return 'No account found with this email. Please sign up.';
    }
    if (lower.contains('email not confirmed')) {
      return 'Please verify your email before signing in.';
    }
    if (lower.contains('rate limit')) {
      return 'Too many attempts. Please wait a moment and try again.';
    }
    return 'Something went wrong. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.authTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(l10n.authBody, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            FeloCard(
              child: Column(
                children: [
                  FeloInput(
                    label: l10n.authEmail,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),
                  FeloInput(
                    label: l10n.authPassword,
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: _busy
                          ? null
                          : () => context.go('/auth/forgot-password'),
                      child: Text(l10n.authForgot),
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red.shade400),
                    ),
                  ],
                  const SizedBox(height: 12),
                  FeloButton(
                    label: _busy ? '...' : l10n.commonSignIn,
                    onPressed: _busy ? null : _signIn,
                  ),
                  const SizedBox(height: 8),
                  FeloButton(
                    label: l10n.commonCreateAccount,
                    variant: FeloButtonVariant.ghost,
                    onPressed: _busy ? null : _signUp,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FeloButton(
              label: l10n.authGoogle,
              icon: Icons.g_mobiledata_rounded,
              variant: FeloButtonVariant.secondary,
              onPressed: _busy
                  ? null
                  : () async {
                      try {
                        await ref.read(supabaseClientProvider).auth.signInWithOAuth(
                              OAuthProvider.google,
                            );
                      } catch (e) {
                        if (mounted) {
                          setState(() => _error = 'Google sign-in failed. Please try again.');
                        }
                      }
                    },
            ),
            const SizedBox(height: 12),
            FeloButton(
              label: l10n.authApple,
              icon: Icons.apple_rounded,
              variant: FeloButtonVariant.secondary,
              onPressed: _busy
                  ? null
                  : () async {
                      try {
                        await ref.read(supabaseClientProvider).auth.signInWithOAuth(
                              OAuthProvider.apple,
                            );
                      } catch (e) {
                        if (mounted) {
                          setState(() => _error = 'Apple sign-in failed. Please try again.');
                        }
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
