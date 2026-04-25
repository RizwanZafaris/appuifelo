import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/supabase/supabase_provider.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_input.dart';

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
          data: const {'corridor': 'canada', 'language_code': 'en'},
        ),
      );

  Future<void> _runAuth(
    Future<AuthResponse> Function(GoTrueClient auth) op,
  ) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.length < 8) {
      setState(() => _error = 'Enter email + a password of 8+ characters.');
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
      if (mounted) setState(() => _error = e.message);
    } catch (e) {
      if (mounted) setState(() => _error = 'Sign-in failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
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
                      // Supabase OAuth opens a browser/webview flow.
                      await ref.read(supabaseClientProvider).auth.signInWithOAuth(
                            OAuthProvider.google,
                          );
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
                      await ref.read(supabaseClientProvider).auth.signInWithOAuth(
                            OAuthProvider.apple,
                          );
                    },
            ),
          ],
        ),
      ),
    );
  }
}
