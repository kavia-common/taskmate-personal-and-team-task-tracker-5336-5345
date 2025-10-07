# TaskMate Flutter App

TaskMate is a smart personal and team task tracker built with Flutter and Firebase.

## Prerequisites
- Flutter SDK (>= 3.29)
- Dart (>= 3.7)
- An existing Firebase project with the following products enabled:
  - Authentication (Google Sign-In)
  - Cloud Firestore (in Native mode)
  - Cloud Messaging (FCM)
  - Analytics (optional but recommended)
- FlutterFire CLI: `dart pub global activate flutterfire_cli`
- Firebase CLI: `npm i -g firebase-tools` then `firebase login`

## Environment Setup
1) Copy `.env.example` to `.env` and fill in values as needed.
2) Install dependencies:
   ```
   flutter pub get
   ```

## Firebase Configuration (Android & iOS)
This project uses FlutterFire configuration generated code and native config files.

### 1) Generate FlutterFire options
Run the FlutterFire CLI and direct output to our scaffolded path:
```
flutterfire configure \
  --project <your-firebase-project-id> \
  --platforms=android,ios \
  --out=lib/core/firebase_options.dart
```
- The generated `lib/core/firebase_options.dart` will replace the placeholder currently in `lib/core/firebase_options.dart`.
- `main.dart` imports from `core/firebase_options.dart` already, so no code changes are required if you use `--out=lib/core/firebase_options.dart`.

Notes:
- The FlutterFire generated options file contains non-secret configuration and is safe to commit.
- If you output to a different path, update the import in `lib/main.dart` accordingly.

### 2) Add platform configuration files
- Android:
  - Download `google-services.json` from the Firebase Console (Project settings > Your apps > Android) for the Android app package (default here: `com.example.taskmate_flutter_app` unless you changed it).
  - Place it at:
    `android/app/google-services.json`
- iOS:
  - Download `GoogleService-Info.plist` for the iOS app.
  - Place it in the iOS Runner target directory:
    `ios/Runner/GoogleService-Info.plist`

Important: The Android applicationId is currently set in `android/app/build.gradle.kts`:
```
defaultConfig {
    applicationId = "com.example.taskmate_flutter_app"
}
```
If you change this value, ensure that the Firebase app configuration in the console matches.

### 3) Apply Gradle plugins (Android)
The Android Gradle plugin for Google Services is applied automatically by FlutterFire when needed, but if you need to apply it manually, follow current FlutterFire Android instructions:
- Top-level `android/build.gradle` should include:
  ```
  buildscript {
    dependencies {
      classpath 'com.google.gms:google-services:<latest>'
    }
  }
  ```
- App-level `android/app/build.gradle` should apply:
  ```
  apply plugin: 'com.google.gms.google-services'
  ```
In this template, the Flutter Gradle plugin is already applied:
```
plugins {
  id("com.android.application")
  id("kotlin-android")
  id("dev.flutter.flutter-gradle-plugin")
}
```
After adding `google-services.json`, rebuild the app. If your Android build requires explicit application of `com.google.gms.google-services`, follow the snippet above.

### 4) Enable Google Sign-In
- Firebase Console > Authentication > Sign-in methods:
  - Enable Google provider.
- Android SHA keys:
  - For Google Sign-In on Android, add your SHA-1 (and SHA-256 if available) in Firebase Console > Project settings > Your apps > Android.
  - Regenerate `google-services.json` after adding SHA keys.
- iOS reversed client ID:
  - Ensure `GoogleService-Info.plist` is added to the Runner target.
  - For iOS URL types, Xcode usually configures this automatically when adding the plist via the project. Verify a URL Type exists using the REVERSED_CLIENT_ID from the plist.

### 5) Cloud Messaging (FCM) setup overview
- Android: No extra file beyond `google-services.json`. At runtime you will request notification permission (Android 13+) and handle background messages using `firebase_messaging`.
- iOS: Requires APNs configuration and notification permissions. Add your APNs key/cert in Firebase Console and enable push capabilities in Xcode. Then request permission in the app before receiving notifications.

### 6) Analytics
- Analytics is included via `firebase_analytics`. Ensure Analytics is enabled in your Firebase project and that you have added the platform config files as described. Analytics consent flows, if required, should be implemented in-app.

## Environment Variables Mapping
The app reads environment variables via `flutter_dotenv`. Keys are defined in:
- `lib/core/constants/env_keys.dart`

Key mapping:
- FIREBASE_PROJECT_ID → Firebase projectId
- FIREBASE_ANDROID_APP_ID → Android appId (if you choose to override FlutterFire file)
- FIREBASE_IOS_APP_ID → iOS appId (if you choose to override FlutterFire file)
- FIREBASE_API_KEY → Web API key (used by FirebaseOptions)
- FIREBASE_MESSAGING_SENDER_ID → Sender ID for FCM
- FIREBASE_STORAGE_BUCKET → Storage bucket name
- GOOGLE_CLIENT_ID → OAuth client for Google Sign-In (iOS may use REVERSED_CLIENT_ID from plist; Android uses the configuration in google-services.json)
- USE_FIRESTORE_EMULATOR (true/false) → Toggle emulator usage in your Firestore setup code
- FIRESTORE_EMULATOR_HOST → Emulator host (e.g., 10.0.2.2 for Android emulator)
- FIRESTORE_EMULATOR_PORT → Emulator port (e.g., 8080)
- PREVIEW_MODE → Enable non-production preview behaviors

Notes:
- By default, this template initializes Firebase using `DefaultFirebaseOptions.currentPlatform` from `lib/core/firebase_options.dart`. If you elect to drive configuration from environment variables instead of the generated file, you will need to wire a custom `FirebaseOptions` in `main.dart`.
- Do not put secrets in `.env`. Firebase client keys are not secrets, but keep consistency with your organization’s policies.

## Running the App
- Debug:
  ```
  flutter run
  ```
- If you encounter missing config errors:
  - Ensure `lib/core/firebase_options.dart` is generated by FlutterFire and up to date.
  - Ensure `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist` exist.
  - On Android, clean and rebuild after adding config:
    ```
    flutter clean
    flutter pub get
    flutter run
    ```

The app boots with:
- Ocean Professional theme
- Basic Router with an AuthGate placeholder
- Provider-based DI scaffolding
- Firebase initialization using generated options or a stub for preview

## Next Steps
- Implement Google Sign-In in the Auth provider
- Connect Firestore repositories
- Add notification handling with `firebase_messaging` and `flutter_local_notifications`
- Implement CRUD UI and Dashboard
- Gate Analytics collection based on user consent if required

## Useful Links
- Flutter: https://docs.flutter.dev
- FlutterFire: https://firebase.flutter.dev
- Google Sign-In: https://firebase.google.com/docs/auth/flutter/google-signin
- Cloud Firestore: https://firebase.google.com/docs/firestore/quickstart
- Cloud Messaging: https://firebase.google.com/docs/cloud-messaging
- Provider: https://pub.dev/packages/provider
