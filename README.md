# flutter_starter_kit

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

## TODO list on this project
- [x] Add the toggle button to switch between dark and light theme
- [x] Add provider to manage the app state (ThemeProvider)
- [ ] Add a product detail page
- [ ] Add a product list page

## Learnings on the way
- Rendering of the app starts with `MaterialApp`
- To show Flutter Code Actions bulb in Cursor IDE on Mac, just press Ctrl+Shift+R

## Configuring Firebase with Flutter project
1. Create firebase project on the console: https://console.firebase.google.com/
2. Install Firebase CLI tools: `curl -sL https://firebase.tools | bash`
3. Login to Firebase CLI: `firebase login`
4. To check if you are logged in, run: `firebase projects:list`
5. Install FlutterFire CLI: `dart pub global activate flutterfire_cli` (This does not add any new file in your project, it is a separate package). Add this to PATH: `export PATH="$PATH:$HOME/.pub-cache/bin"`
6. Add Firebase to your Flutter project: `flutterfire configure` and choose the platform you are working on (i.e. Android, iOS, Web, macOS)
7. Initialize Firebase in your main.dart file:
    ```dart
    void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
    }
    ```
8. Execute `flutter run` to see if there are any errors. Common error when setting up on iOS:
`[!] Automatically assigning platform `iOS` with version `12.0` on target `Runner` because no platform
was specified. Please specify a platform for this target in your Podfile. See
https://guides.cocoapods.org/syntax/podfile.html#platform.`

    OR

    `Error: The plugin "firebase_auth" requires a higher minimum iOS
deployment version than your application is targeting.
To build, increase your application's deployment target to at least
13.0 as described at https://docs.flutter.dev/deployment/ios`

    Solution: Go to ios/Podfile and add `platform :ios, '13.0'` to the top of the file to fix this error.

## Tutorial to learn about authentication
One can use default LoginScreen and  from Firebase to handle authentication.
1. https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps
2. https://firebase.flutter.dev/docs/ui/auth/integrating-your-first-screen/

