import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/localization/generated/app_localizations.dart';
import 'package:felo/core/localization/localization_extensions.dart';
import 'package:felo/core/theme/felo_colors.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_card.dart';
import 'package:felo/shared/widgets/felo_scaffold.dart';

/// 4-step KYC onboarding stub. UI only — no real verification vendor.
/// Steps: ID type → ID front/back → selfie → review.
class KycScreen extends ConsumerStatefulWidget {
  const KycScreen({super.key});

  @override
  ConsumerState<KycScreen> createState() => _KycScreenState();
}

enum _KycStep { idType, idCapture, selfie, review }

class _KycScreenState extends ConsumerState<KycScreen> {
  _KycStep _step = _KycStep.idType;
  String? _idType;
  bool _idFrontCaptured = false;
  bool _idBackCaptured = false;
  bool _selfieCaptured = false;

  int get _stepIndex => _KycStep.values.indexOf(_step);

  void _next() {
    final idx = _stepIndex;
    if (idx < _KycStep.values.length - 1) {
      setState(() => _step = _KycStep.values[idx + 1]);
    }
  }

  void _back() {
    final idx = _stepIndex;
    if (idx > 0) {
      setState(() => _step = _KycStep.values[idx - 1]);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FeloScaffold(
      title: l10n.kycTitle,
      selectedTab: FeloRootTab.home,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StepIndicator(
            current: _stepIndex,
            total: _KycStep.values.length,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [_buildStepBody(l10n)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: FeloButton(
                    label: l10n.commonBack,
                    variant: FeloButtonVariant.secondary,
                    onPressed: _back,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FeloButton(
                    label: _step == _KycStep.review
                        ? l10n.kycSubmit
                        : l10n.commonContinue,
                    onPressed: _canAdvance() ? _onPrimary : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _canAdvance() {
    switch (_step) {
      case _KycStep.idType:
        return _idType != null;
      case _KycStep.idCapture:
        return _idFrontCaptured && _idBackCaptured;
      case _KycStep.selfie:
        return _selfieCaptured;
      case _KycStep.review:
        return true;
    }
  }

  void _onPrimary() {
    if (_step == _KycStep.review) {
      _showSubmitted();
    } else {
      _next();
    }
  }

  void _showSubmitted() {
    final l10n = context.l10n;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.verified_user_rounded, size: 48),
        title: Text(l10n.kycSubmittedTitle),
        content: Text(l10n.kycSubmittedBody),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.go('/profile');
            },
            child: Text(l10n.commonDone),
          ),
        ],
      ),
    );
  }

  Widget _buildStepBody(AppLocalizations l10n) {
    switch (_step) {
      case _KycStep.idType:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.kycChooseIdType,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            for (final type in const [
              ('passport', Icons.book_outlined),
              ('cnic', Icons.credit_card_outlined),
              ('drivers_license', Icons.directions_car_outlined),
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: FeloCard(
                  onTap: () => setState(() => _idType = type.$1),
                  child: Row(
                    children: [
                      Icon(type.$2),
                      const SizedBox(width: 12),
                      Expanded(child: Text(_idTypeLabel(l10n, type.$1))),
                      if (_idType == type.$1)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: FeloColors.feloiTeal,
                        ),
                    ],
                  ),
                ),
              ),
          ],
        );
      case _KycStep.idCapture:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.kycCaptureIdTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            _CaptureTile(
              label: l10n.kycCaptureFront,
              captured: _idFrontCaptured,
              onTap: () => setState(() => _idFrontCaptured = true),
            ),
            const SizedBox(height: 8),
            _CaptureTile(
              label: l10n.kycCaptureBack,
              captured: _idBackCaptured,
              onTap: () => setState(() => _idBackCaptured = true),
            ),
          ],
        );
      case _KycStep.selfie:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.kycSelfieTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            _CaptureTile(
              label: l10n.kycCaptureSelfie,
              icon: Icons.face_retouching_natural_rounded,
              captured: _selfieCaptured,
              onTap: () => setState(() => _selfieCaptured = true),
            ),
            const SizedBox(height: 12),
            Text(l10n.kycSelfieHint,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        );
      case _KycStep.review:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.kycReviewTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            FeloCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ReviewRow(
                    label: l10n.kycReviewIdType,
                    value: _idTypeLabel(l10n, _idType ?? '-'),
                  ),
                  _ReviewRow(
                    label: l10n.kycReviewIdImages,
                    value: _idFrontCaptured && _idBackCaptured
                        ? l10n.kycReviewCaptured
                        : l10n.kycReviewMissing,
                  ),
                  _ReviewRow(
                    label: l10n.kycReviewSelfie,
                    value: _selfieCaptured
                        ? l10n.kycReviewCaptured
                        : l10n.kycReviewMissing,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(l10n.kycReviewDisclaimer,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        );
    }
  }

  String _idTypeLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'passport':
        return l10n.kycIdPassport;
      case 'cnic':
        return l10n.kycIdCnic;
      case 'drivers_license':
        return l10n.kycIdDriversLicense;
      default:
        return '—';
    }
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          for (var i = 0; i < total; i++) ...[
            Expanded(
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: i <= current
                      ? FeloColors.feloiTeal
                      : Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            if (i != total - 1) const SizedBox(width: 6),
          ],
        ],
      ),
    );
  }
}

class _CaptureTile extends StatelessWidget {
  const _CaptureTile({
    required this.label,
    required this.captured,
    required this.onTap,
    this.icon = Icons.camera_alt_outlined,
  });

  final String label;
  final bool captured;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FeloCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(captured ? Icons.check_circle_rounded : icon,
              color: captured
                  ? FeloColors.feloiTeal
                  : Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
