# OrganizeIt

OrganizeIt is a Flutter task management app designed to help you organize goals, tasks, and daily plans in a clean, fast, and focused experience.

## Tech Stack

- Flutter (Material)
- Riverpod (`flutter_riverpod`) for state management
- Dio for networking
- Freezed + JSON Serializable for models
- `lifecycle_logger` for app lifecycle event logging

## Project Structure

- `lib/core` → shared theme, constants, utilities
- `lib/features` → feature-first modules (data/domain/presentation)
- `lib/services` → app-wide services (for example, Dio setup)
- `test` → unit and widget tests

## Run Locally

1. Install Flutter SDK (stable channel)
2. Get dependencies:

```bash
flutter pub get
```

3. Run app:

```bash
flutter run
```

4. Run tests:

```bash
flutter test
```

## Lifecycle Logging

App lifecycle logging is enabled at startup in `main()` using:

```dart
LifecycleLogger.attach();
```

This helps track `resumed`, `paused`, `inactive`, and `detached` transitions during development.

## Public Repository Safety

Before pushing changes, ensure sensitive and generated files are not tracked:

- `.env` and `.env.*`
- `android/local.properties`
- `android/key.properties`
- `google-services.json`
- `GoogleService-Info.plist`
- signing keys (`*.jks`, `*.keystore`, `*.pem`, `*.p8`, `*.p12`)
- generated folders (`android/build/`, `ios/Pods/`, `ios/Flutter/ephemeral/`)

Use this quick check:

```bash
git ls-files | egrep -i '(.env|key.properties|local.properties|google-services.json|GoogleService-Info.plist|\.jks|\.keystore|\.pem|\.p8|\.p12)$'
```
