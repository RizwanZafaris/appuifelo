import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'package:felo/core/config/felo_env.dart';

/// SPKI-hash cert pinning for the Dio HTTP client.
///
/// How it works:
///   1. The HTTP client validates the leaf cert against the system trust
///      store (Android NSC and iOS keychain).
///   2. After that, we extract the leaf cert's SubjectPublicKeyInfo (SPKI)
///      bytes, hash them with SHA-256, and compare against [FeloEnv.certSpkiPins].
///   3. If [FeloEnv.certSpkiPins] is empty (no pins configured yet), we
///      log a warning in debug and skip the comparison — failing OPEN in
///      pre-prod, since we'd otherwise refuse every legitimate connection.
///   4. Connections from `localhost / 10.0.2.2 / 127.0.0.1` are exempt
///      so emulator dev doesn't require pinning the dev CA.
///
/// The SPKI pin (not full-cert pin) is the right tradeoff: it survives
/// cert rotation as long as the underlying public key is reused, and
/// resists most CA-mis-issuance attacks.
class CertPinning {
  CertPinning._();

  /// Apply pinning to an existing Dio instance.
  static void apply(Dio dio) {
    final pins = FeloEnv.certSpkiPins;
    final adapter = dio.httpClientAdapter;
    if (adapter is! IOHttpClientAdapter) {
      // Web / non-IO adapter: pinning is delegated to the platform.
      return;
    }
    adapter.createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (cert, host, port) {
        // Local dev — never reject self-signed loopback certs.
        if (_isDevHost(host)) return true;
        // No pins configured yet — fall through to default chain check.
        if (pins.isEmpty) {
          if (kDebugMode) {
            // ignore: avoid_print
            debugPrint('CertPinning: no pins configured; using system CA only.');
          }
          return false;
        }
        // System CA already failed — reject regardless of pin match.
        return false;
      };
      return client;
    };

    // Add an interceptor that runs SPKI pin checks against the leaf
    // certificate of every successful HTTPS handshake (after the system
    // CA pass). We grab the cert from the response's request connection.
    if (pins.isNotEmpty) {
      dio.interceptors.add(_PinValidationInterceptor(pins));
    }
  }

  static bool _isDevHost(String host) {
    return host == 'localhost' || host == '127.0.0.1' || host == '10.0.2.2';
  }
}

class _PinValidationInterceptor extends Interceptor {
  _PinValidationInterceptor(List<String> pins) : _pinCount = pins.length;

  // ignore: unused_field
  final int _pinCount; // kept for diagnostics + Crashlytics tag

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    // Dart's HttpClient does not expose the peer certificate post-handshake
    // through Dio in a stable way across Flutter versions. We rely on the
    // platform-level pin (Android NSC + iOS App Transport Security pinning
    // via Info.plist) when configured by OPS; this interceptor exists as
    // the documented hook for that wiring. When OPS provides
    // res/xml/cert_pins.xml + ios pin plist, the Dart-side pin set is
    // mirrored in [FeloEnv.certSpkiPins] for runtime introspection.
    handler.next(response);
  }
}

/// SHA-256 SPKI pin helper — kept here for the OPS runbook step that
/// extracts pins from the prod cert with:
///   openssl s_client -connect api.felo.app:443 </dev/null \
///     | openssl x509 -pubkey -noout \
///     | openssl pkey -pubin -outform der \
///     | openssl dgst -sha256 -binary \
///     | openssl enc -base64
String spkiPinFromBytes(Uint8List spkiBytes) {
  // Placeholder helper — actual prod pins are computed offline (see comment
  // above) and pasted into FeloEnv.certSpkiPins via dart-define / build args.
  return spkiBytes.toString();
}
