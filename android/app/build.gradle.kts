import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Load android/key.properties (gitignored) for release signing.
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
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
        applicationId = "com.felo.felo"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "env"
    productFlavors {
        create("staging") {
            dimension = "env"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
            resValue("string", "app_name", "Felo Staging")
        }
        create("prod") {
            dimension = "env"
            resValue("string", "app_name", "Felo")
        }
    }

    // -------------------------------------------------------------------
    // Release signing.
    //
    // Default behaviour: build hard-fails for `flutter build apk --release`
    // unless one of the following is true:
    //   1. `android/key.properties` is present and points at a real
    //      upload keystore (production CI).
    //   2. `FELO_REQUIRE_RELEASE_SIGNING=0` is exported AND we're not in
    //      CI (FELO_CI != 1) — explicit opt-in for local-only smoke tests.
    //
    // The fence default is now ON. The previous default was off, which
    // let `flutter build apk --release` produce a publishable artifact
    // signed with the debug keystore.
    // -------------------------------------------------------------------
    val releaseSigningRequired =
        (System.getenv("FELO_REQUIRE_RELEASE_SIGNING") ?: "1") == "1"
    val keystoreConfigured = keystoreProperties.containsKey("storeFile")

    signingConfigs {
        if (keystoreConfigured) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    if (releaseSigningRequired && !keystoreConfigured) {
        gradle.projectsEvaluated {
            tasks.matching { it.name.startsWith("assembleRelease") || it.name.startsWith("bundleRelease") }
                .configureEach {
                    doFirst {
                        throw GradleException(
                            "Release build refused: android/key.properties is missing.\n" +
                                "Provision an upload keystore (see OPS_CONFIG.md → 'Mobile') or\n" +
                                "set FELO_REQUIRE_RELEASE_SIGNING=0 to opt out for a local smoke test."
                        )
                    }
                }
        }
    }

    buildTypes {
        release {
            // Use the real release config when available; otherwise fall
            // back to debug — guarded above so this only happens for
            // explicit local opt-out.
            signingConfig = if (keystoreConfigured) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}
