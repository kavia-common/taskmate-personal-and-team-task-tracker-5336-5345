# TaskMate Flutter App

TaskMate is a smart personal and team task tracker built with Flutter and Firebase.

## Prerequisites
- Flutter SDK (>= 3.29)
- Dart (>= 3.7)
- Firebase project
- FlutterFire CLI: `dart pub global activate flutterfire_cli`

## Environment Setup
1) Copy `.env.example` to `.env` and fill in values as needed.
2) Install dependencies:
   flutter pub get

## Firebase Configuration
Generate platform-specific Firebase configuration:
- Ensure you are logged in: `firebase login`
- Configure:
  flutterfire configure --project <your-firebase-project-id> --platforms=android,ios

This command creates `lib/firebase_options.dart` by default. In this project,
we scaffolded a placeholder at `lib/core/firebase_options.dart`.
You can either:
- Update your flutterfire command with `--out=lib/core/firebase_options.dart`, or
- Replace imports in `lib/main.dart` to the generated path and delete the placeholder.

Note: Do NOT commit real API keys in `.env`. The FlutterFire generated file is safe to commit as it contains non-secret config.

## Running the App
- Debug:
  flutter run

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

## Useful Links
- Flutter: https://docs.flutter.dev
- FlutterFire: https://firebase.flutter.dev
- Provider: https://pub.dev/packages/provider
