# ProGuard / R8 rules for Felo release builds.
#
# Flutter, Drift (SQLite), Retrofit, Freezed, Riverpod, and Supabase all
# use reflection or generated code that R8 must not rename/strip.

# Flutter framework
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Firebase (Crashlytics, Auth, etc.) — keep all metadata so symbol
# resolution works on uploaded crash reports.
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod
-keepattributes SourceFile,LineNumberTable
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Drift / SQLite
-keep class androidx.sqlite.db.** { *; }
-dontwarn androidx.sqlite.db.**

# OkHttp / Retrofit (used transitively)
-dontwarn okhttp3.**
-dontwarn okio.**

# Drop verbose logs from release builds.
-assumenosideeffects class android.util.Log {
    public static *** v(...);
    public static *** d(...);
    public static *** i(...);
}
