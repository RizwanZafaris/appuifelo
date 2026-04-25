import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_input.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.authTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              l10n.authBody,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            FeloCard(
              child: Column(
                children: [
                  FeloInput(label: l10n.authEmail, keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 14),
                  FeloInput(label: l10n.authPassword, obscureText: true),
                  const SizedBox(height: 12),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(l10n.authForgot),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FeloButton(
                    label: l10n.commonSignIn,
                    onPressed: () => context.go('/home'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FeloButton(
              label: l10n.authGoogle,
              icon: Icons.g_mobiledata_rounded,
              variant: FeloButtonVariant.secondary,
              onPressed: () => context.go('/home'),
            ),
            const SizedBox(height: 12),
            FeloButton(
              label: l10n.authApple,
              icon: Icons.apple_rounded,
              variant: FeloButtonVariant.secondary,
              onPressed: () => context.go('/home'),
            ),
          ],
        ),
      ),
    );
  }
}
