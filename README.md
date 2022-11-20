# Birdiefy Mobile App
This is the source code for a demo application built using flutter programming language and firebase for the back end.
It can be compiled for iOS, Android, windows and web platform.

Birdiefy is a simple application for Golfers to use. Users can:
-  Create accounts
-  Login
-  View Profile
-  View Rounds
-  Add Rounds

#### App Screenshots

<table>
  <tr>
    <td align="center">Welcome Page</td>
    <td>&nbsp;&nbsp;&nbsp;</td>
    <td align="center">Login Page</td>
    <td>&nbsp;&nbsp;&nbsp;</td>
    <td align="center">Registration Page</td>
  </tr>
  <tr>
    <td><img src="/assets/screenshots/1.png" width=270></td>
    <td>&nbsp;</td>
    <td><img src="/assets/screenshots/2.png" width=270></td>
    <td>&nbsp;</td>
    <td><img src="/assets/screenshots/3.png" width=270></td>
  </tr>
  <tr>
    <td colSpan=5>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">Rounds Page</td>
    <td>&nbsp;</td>
    <td align="center">User Page</td>
    <td>&nbsp;</td>
    <td align="center">Add Rounds Page</td>
  </tr>
  <tr>
    <td><img src="/assets/screenshots/4.png" width=270></td>
    <td>&nbsp;</td>
    <td><img src="/assets/screenshots/5.png" width=270></td>
    <td>&nbsp;</td>
    <td><img src="/assets/screenshots/6.png" width=270></td>
  </tr>
  <tr>
    <td colSpan=3>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">Select date modal</td>
    <td>&nbsp;</td>
    <td align="center">Select hole modal</td>
  </tr>
  <tr>
    <td><img src="/assets/screenshots/7.png" width=270></td>
    <td>&nbsp;</td>
    <td><img src="/assets/screenshots/8.png" width=270></td>
  </tr>
 </table>

## Requirements
-  Flutter version 3.3.0
-  Flutter sdk environment: ">=2.16.1 <3.0.0"

## Getting Started
For help getting started with Flutter, view their
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

For help getting started with Firebase (Google cloud), view their
[online documentation](https://firebase.flutter.dev/docs/overview), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Run `flutter pub get` to download dependencies.
Build the application by running `flutter run`.

or run and debug sidebar, click run (icon).

## Testing

### Integration tests
To run integration tests: `flutter run integration_test/init_test.dart`

### Upgrade pubspec
```bash
flutter pub upgrade --major-versions
```

### Run on device
Open run and debug sidebar, click run (icon).

### Building apk
```bash
flutter build apk
```

### Building ipa
Change bundle identifier to ng.monthly.monthly
```bash
flutter build ipa
```

### Building web
Change bundle identifier to ng.monthly.monthly
```bash
flutter build web
```

## Production Deployment Sequence
-  update version (pubspec & app store connect)
-  remove // (.*) (?!imports:) (unneccesary imports)
-  remove print statements
-  remove assert
-  clear todo
-  clear console problems
-  flutter pub run import_sorter:main
-  flutter pub run build_runner build --delete-conflicting-outputs;
-  (ios only) running -> general -> version and build
```bash
  flutter clean
```
```bash
  flutter pub get
```
```bash
  flutter build appbundle
```
```bash
  flutter build ipa
```

### Staging
Changes are deployed to the staging environment after a PR is merged into the `dev` branch

### Production
Changes are deployed to the production environment after a release is created, click [here](https://github.com/peterbrown0/birdiefy/releases/new) to create a release, see [releases section](#releases)

## Releases

### Naming Convention
Use the application version and build number.
vAppVersion+AppBuildNumber

- AppVersion (gotten from pubspec file) - 1.0.8

- AppBuildNumber (gotten from pubspec file) - 6

Example:

1st release: v1.0.8+6

-  Increase major version after a major rewrite. (1 in above example)
-  Increase minor version after adding a feature. (0 in above example)
-  Increase bug version for bug fixes. (9 in above example)
-  Increase build number for every production release. (7 in above example)
