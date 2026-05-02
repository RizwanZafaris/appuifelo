plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.felo.felo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.felo.felo"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // -------------------------------------------------------------------
    // RELEASE SIGNING — PRODUCTION BLOCKER
    //
    // The release build below is currently signed with the Android *debug*
    // keystore so `flutter run --release` works during development.
    // This MUST be replaced with a real upload keystore before any APK or
    // AAB is published to internal testing, beta, or production tracks.
    //
    // Steps to wire production signing:
    //   1. Generate a keystore:
    //        keytool -genkey -v -keystore upload-keystore.jks \
    //          -keyalg RSA -keysize 2048 -validity 10000 -alias upload
    //   2. Store credentials outside source control in
    //        android/key.properties (gitignored).
    //   3. Replace the `release` block with a `signingConfigs.create("release")`
    //        that loads from key.properties.
    //   4. Wire CI secrets (GitHub Actions / Codemagic) — never commit the keystore.
    //
    // Build will hard-fail if FELO_REQUIRE_RELEASE_SIGNING=1 is set, to
    // prevent shipping debug-signed binaries from CI by accident.
    // -------------------------------------------------------------------
    val requireReleaseSigning =
        (System.getenv("FELO_REQUIRE_RELEASE_SIGNING") ?: "0") == "1"
    if (requireReleaseSigning) {
        throw GradleException(
            "FELO_REQUIRE_RELEASE_SIGNING is set but no real release " +
                "signingConfig is configured. Refusing to build with the " +
                "debug keystore. See android/app/build.gradle.kts.",
        )
    }

    buildTypes {
        release {
            // DEV ONLY — see signing block above.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
