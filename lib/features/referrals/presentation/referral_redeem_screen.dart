import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/features/referrals/data/referrals_repository.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_input.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

class ReferralRedeemScreen extends ConsumerStatefulWidget {
  const ReferralRedeemScreen({super.key});

  @override
  ConsumerState<ReferralRedeemScreen> createState() =>
      _ReferralRedeemScreenState();
}

class _ReferralRedeemScreenState extends ConsumerState<ReferralRedeemScreen> {
  final _controller = TextEditingController();
  bool _isSubmitting = false;
  String? _errorText;
  bool _redeemed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.referralsRedeemTitle,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FeloCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.referralsRedeemHeading,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(l10n.referralsRedeemBody),
                const SizedBox(height: 16),
                FeloInput(
                  label: l10n.referralsRedeemCodeLabel,
                  hint: l10n.referralsRedeemCodeHint,
                  controller: _controller,
                ),
                if (_errorText != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    _errorText!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                if (_redeemed) ...[
                  const SizedBox(height: 10),
                  Text(
                    l10n.referralsRedeemSuccess,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                FeloButton(
                  label: _isSubmitting
                      ? l10n.commonLoading
                      : l10n.referralsRedeemSubmit,
                  icon: Icons.redeem_rounded,
                  onPressed: _isSubmitting ? null : _submit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final code = _controller.text.trim();
    if (code.isEmpty) {
      setState(() {
        _errorText = l10n.referralsRedeemRequired;
        _redeemed = false;
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorText = null;
      _redeemed = false;
    });

    try {
      await ref.read(referralsRepositoryProvider).redeem(code);
      ref.invalidate(referralsSnapshotProvider);
      if (!mounted) return;
      setState(() => _redeemed = true);
    } on ReferralRedeemException catch (error) {
      if (!mounted) return;
      setState(() => _errorText = _messageFor(error.error));
    } catch (_) {
      if (!mounted) return;
      setState(() => _errorText = l10n.referralsRedeemUnknown);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String _messageFor(ReferralRedeemError error) {
    final l10n = context.l10n;
    return switch (error) {
      ReferralRedeemError.notFound => l10n.referralsRedeemNotFound,
      ReferralRedeemError.alreadyRedeemed => l10n.referralsRedeemConflict,
      ReferralRedeemError.unknown => l10n.referralsRedeemUnknown,
    };
  }
}
