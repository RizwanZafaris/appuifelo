import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_errors;

/// Real biometric (fingerprint / Face ID) wrapper.
///
/// Replaces the placeholder UI toggle in `auth_recovery_screens.dart`
/// that flipped a `bool _enabled` with `setState` and called nothing —
/// users could believe biometric was protecting the app when it wasn't.
///
/// Stores the user-facing "biometric lock enabled" preference in
/// [FlutterSecureStorage] (Android Keystore / iOS Keychain backed) so
/// the setting survives reinstall iff the user restored from a managed
/// backup (otherwise it's gone, which is the right behaviour).
class BiometricService {
  BiometricService({
    LocalAuthentication? auth,
    FlutterSecureStorage? storage,
  })  : _auth = auth ?? LocalAuthentication(),
        _storage = storage ?? const FlutterSecureStorage();

  static const _enabledKey = 'felo.biometric.enabled';

  final LocalAuthentication _auth;
  final FlutterSecureStorage _storage;

  Future<bool> isAvailable() async {
    try {
      final supported = await _auth.isDeviceSupported();
      if (!supported) return false;
      final canCheck = await _auth.canCheckBiometrics;
      return canCheck;
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('BiometricService.isAvailable: $e');
      return false;
    }
  }

  Future<bool> isEnabled() async {
    final v = await _storage.read(key: _enabledKey);
    return v == 'true';
  }

  Future<bool> enable({required String reason}) async {
    final ok = await authenticate(reason: reason);
    if (ok) {
      await _storage.write(key: _enabledKey, value: 'true');
    }
    return ok;
  }

  Future<void> disable() async {
    await _storage.delete(key: _enabledKey);
  }

  Future<bool> authenticate({required String reason}) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } on Exception catch (e) {
      if (e.toString().contains(auth_errors.notAvailable) ||
          e.toString().contains(auth_errors.notEnrolled)) {
        return false;
      }
      rethrow;
    }
  }
}
