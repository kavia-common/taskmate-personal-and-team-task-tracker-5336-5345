# TaskMate Flutter App

TaskMate is a smart personal and team task tracker with real-time sync, Google Sign-In, Firestore storage, and push notifications.

This repository ships a production-ready scaffold that builds and runs even when Firebase is not yet configured. Until Firebase is set up, the app shows a setup-aware sign-in screen and no-ops for cloud operations.

## Features in this scaffold
- Ocean Professional theme (Material 3, rounded corners, subtle elevation)
- Provider-based state management (Auth, Tasks, Projects, Tags, Settings)
- Tab navigation: Home, Projects, Tags, Dashboard, Settings
- Guarded Firebase initialization to avoid build failures if not configured
- Firestore/Auth/FCM service abstractions (no-op until configured)
- .env support for non-secret feature toggles

## Getting started
1) Prerequisites
- Flutter SDK (3.29+)
- Android Studio/Xcode as applicable

2) Install dependencies
```
flutter pub get
```

3) Run the app (without Firebase)
```
flutter run
```
You will see the sign-in screen with guidance that Firebase is not configured yet.

## Firebase setup guide
Follow these steps to enable authentication, Firestore and notifications.

1) Create Firebase project
- Go to Firebase Console and create a project.

2) Add Android app
- Package name (applicationId): `com.example.taskmate_flutter_app` (or change in android/app/build.gradle.kts)
- Download `google-services.json` and place it at:
  `android/app/google-services.json`

3) (Optional) Add iOS app
- Download and add `GoogleService-Info.plist` to the iOS Runner target.

4) Install FlutterFire CLI
```
dart pub global activate flutterfire_cli
```

5) Configure FlutterFire and generate options
```
flutterfire configure --out=lib/firebase_options.dart
```

6) Add Firebase packages in pubspec.yaml
Uncomment firebase_* and google_sign_in dependencies and run:
```
flutter pub get
```

7) Enable Google Services Gradle plugin
- In `android/app/build.gradle.kts`, uncomment:
```
id("com.google.gms.google-services")
```
- And add at bottom (if needed):
```
apply(plugin = "com.google.gms.google-services")
```

8) Initialize services in code
- Replace service stubs in:
  - lib/core/services/auth_service.dart (use FirebaseAuth + GoogleSignIn)
  - lib/core/services/firestore_service.dart (use FirebaseFirestore)
  - lib/core/services/notification_service.dart (use FirebaseMessaging)

9) Run the app
```
flutter run
```

## Environment variables
Copy .env.example to .env and adjust values.

## Tests
Basic widget test ensures app renders.

## Notes
- The scaffold is intentionally conservative to guarantee compilation pre-Firebase. Follow the steps above to wire real services.
