import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:felo/core/network/dio_provider.dart';
import 'package:felo/features/onboarding_v2/application/onboarding_analytics_mixin.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/onboarding_shell.dart';
import 'package:felo/features/onboarding_v2/presentation/shared/otp_input.dart';
import 'package:felo/shared/widgets/felo_button.dart';
import 'package:felo/shared/widgets/felo_input.dart';

/// **FR-1.3.1 + FR-1.3.2** — OTP entry + verification.
///
/// Flow:
/// 1. User enters phone (Mobile path) or email (Email path)
/// 2. Tap Send → POST /v1/sms/otp/send (Mobile) or Supabase Auth OTP (Email)
/// 3. 6-digit auto-submit on completion
/// 4. POST /v1/sms/otp/verify → on ok=true, navigate to Phase 2
///
/// Per D-011: TTL 5min, 3 attempts/challenge, 3 resends max → force
/// method switch.
class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({required this.method, super.key});

  /// 'email' or 'mobile' — drives which entry field is shown.
  final String method;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen>
    with OnboardingAnalyticsMixin<OtpScreen> {
  @override
  int get phase => 1;

  @override
  String get stepId => 'phase1_step3';

  @override
  String get frdId => 'FR-1.3.1';

  final _identifierController = TextEditingController();
  String? _challengeId;
  bool _otpSent = false;
  bool _otpError = false;
  bool _busy = false;
  String? _statusLine;
  int _resendCount = 0;
  static const _maxResends = 3;

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  bool get _isMobile => widget.method == 'mobile';

  Future<void> _sendOtp() async {
    final identifier = _identifierController.text.trim();
    if (identifier.isEmpty) {
      await onValidationError('empty');
      setState(
        () => _statusLine =
            'Please enter your ${_isMobile ? 'phone number' : 'email'}.',
      );
      return;
    }
    if (_isMobile && !RegExp(r'^\+[1-9]\d{1,14}$').hasMatch(identifier)) {
      await onValidationError('invalid_e164');
      setState(
        () => _statusLine = "Use international format, e.g. +923001234567",
      );
      return;
    }
    if (!_isMobile && !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(identifier)) {
      await onValidationError('invalid_email');
      setState(
        () => _statusLine = "Please enter a valid email address.",
      );
      return;
    }

    setState(() {
      _busy = true;
      _statusLine = 'Sending code…';
    });

    try {
      final dio = ref.read(dioProvider);
      if (_isMobile) {
        final response = await dio.post<Map<String, dynamic>>(
          '/sms/otp/send',
          data: {
            'phoneE164': identifier,
            // ipDetectedCountry not yet known at Phase 1 — Phase 2's
            // resolver will set it. Backend falls back to E.164 prefix
            // routing per D-006.
          },
        );
        _challengeId = response.data?['challenge_id']?.toString();
        setState(() {
          _otpSent = true;
          _busy = false;
          _statusLine =
              'Code sent to ${response.data?['masked_phone'] ?? identifier}.';
        });
      } else {
        // Email path: call backend email OTP endpoint
        final response = await dio.post<Map<String, dynamic>>(
          '/auth/otp/email/send',
          data: {'email': identifier},
        );
        _challengeId = response.data?['challenge_id']?.toString() ?? identifier;
        setState(() {
          _otpSent = true;
          _busy = false;
          _statusLine = 'Code sent to $identifier.';
        });
      }
    } on DioException catch (err) {
      setState(() {
        _busy = false;
        _statusLine =
            err.response?.data?['message']?.toString() ??
            'Failed to send code — please try again.';
      });
    }
  }

  Future<void> _verifyOtp(String code) async {
    if (_challengeId == null) return;
    setState(() {
      _busy = true;
      _statusLine = 'Verifying…';
    });

    try {
      final dio = ref.read(dioProvider);
      if (_isMobile) {
        final response = await dio.post<Map<String, dynamic>>(
          '/sms/otp/verify',
          data: {'challengeId': _challengeId, 'code': code},
        );
        final ok = response.data?['ok'] == true;
        if (ok) {
          await onContinue({'method': widget.method});
          if (!mounted) return;
          context.go('/onboarding-v2/region');
        } else {
          final reason = response.data?['reason']?.toString() ?? 'wrong_code';
          await onValidationError(reason);
          setState(() {
            _busy = false;
            _otpError = true;
            _statusLine = _humanReason(reason);
          });
        }
      } else {
        // Email path: verify via backend
        final response = await dio.post<Map<String, dynamic>>(
          '/auth/otp/email/verify',
          data: {'email': _challengeId, 'code': code},
        );
        final ok = response.data?['ok'] == true;
        if (ok) {
          await onContinue({'method': widget.method});
          if (!mounted) return;
          context.go('/onboarding-v2/region');
        } else {
          final reason = response.data?['reason']?.toString() ?? 'wrong_code';
          await onValidationError(reason);
          setState(() {
            _busy = false;
            _otpError = true;
            _statusLine = _humanReason(reason);
          });
        }
      }
    } catch (err) {
      setState(() {
        _busy = false;
        _otpError = true;
        _statusLine = 'Verification failed. Please try again.';
      });
    }
  }

  Future<void> _resend() async {
    if (_resendCount >= _maxResends) {
      // D-011: max 3 resends → force user to switch signup method.
      await onValidationError('max_resends_reached');
      if (!mounted) return;
      context.go('/onboarding-v2/signup-method');
      return;
    }
    setState(() {
      _resendCount += 1;
      _otpError = false;
    });
    await _sendOtp();
  }

  String _humanReason(String reason) {
    return switch (reason) {
      'wrong_code' => "Code didn't match. Try again.",
      'wrong_code_max_attempts_reached' =>
        'Too many attempts — request a new code.',
      'expired' => 'Code expired. Tap Resend.',
      'max_attempts' => 'Too many attempts — request a new code.',
      'already_used' => 'Code already used.',
      'rate_limited' => 'Too many attempts. Please try again later.',
      _ => 'Verification failed.',
    };
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      title: _otpSent
          ? 'Enter the code'
          : 'Verify your ${_isMobile ? 'phone' : 'email'}',
      currentStep: 3,
      totalSteps: 14,
      onBack: () async {
        await onBackPressed();
        if (!mounted) return;
        context.go('/onboarding-v2/signup-method');
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          if (!_otpSent) ...[
            Text(
              _isMobile
                  ? "We'll send you a 6-digit code."
                  : "We'll email you a 6-digit code.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FeloInput(
              label: _isMobile ? 'Phone number (e.g. +923001234567)' : 'Email',
              controller: _identifierController,
              keyboardType: _isMobile
                  ? TextInputType.phone
                  : TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            FeloButton(
              label: _busy ? 'Sending…' : 'Send code',
              onPressed: _busy ? null : _sendOtp,
            ),
          ] else ...[
            Text(
              _statusLine ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _otpError
                    ? Colors.red.shade400
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 28),
            OtpInput(
              error: _otpError,
              onCompleted: (code) {
                if (!_busy) _verifyOtp(code);
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: _busy ? null : _resend,
                child: Text(
                  _resendCount >= _maxResends
                      ? 'Try a different signup method'
                      : 'Resend code (${_maxResends - _resendCount} left)',
                ),
              ),
            ),
          ],
          if (_otpSent && _statusLine != null && !_otpError) ...[
            const SizedBox(height: 16),
            Text(
              _statusLine!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
