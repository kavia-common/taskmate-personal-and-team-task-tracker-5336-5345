# taskmate-personal-and-team-task-tracker-5336-5345

This workspace contains the TaskMate Flutter mobile app.

Quick start:
- cd taskmate_flutter_app
- Copy `.env.example` to `.env` and set values
- Install FlutterFire CLI (if not yet): `dart pub global activate flutterfire_cli`
- Configure Firebase:
  flutterfire configure --project <your-project-id> --platforms=android,ios --out=lib/core/firebase_options.dart
- Run:
  flutter pub get
  flutter run

The app is scaffolded with:
- Firebase initialization
- Provider-based DI
- Ocean Professional theme
- Basic routing with AuthGate placeholder