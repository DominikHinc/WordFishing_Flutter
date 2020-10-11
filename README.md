# WordFishing

Complete recreation of another project under the same name. 

Previously written in LibGDX [Link](https://github.com/DominikHinc/WordFishing)

## Setting up the environment

Simply follow official documentation: https://flutter.dev/docs/get-started/install

## Running the project

First run

  - Clone this project
  - In console in project root type `flutter pub get`
  - Run project by typing `flutter run` or use Android Studio

## File Structure
```
WordFishing
├── android
├── assets
│   ├── fonts
├── ios
├── lib
│   ├── models
│   ├── navigation
│   ├── providers
│   ├── screens
│   ├── services
│   ├── theme
│   ├── utils
│   ├── widgets
│   └── main.dart
├── test
└── pubspec.yaml
```
### ./assets directory

These should include things like fonts, logos, custom icons, and any static images used throughout the app. Once they are in here, link them to the app in the pubspec.yaml.

### ./models directory

Models are used for modeling data that is used across the app. 

### ./navigation directory

Should contain any logic related to App's navigation.

### ./providers directory

Should contain classes that are used by Provider package for state management.

### ./screens directory

Screens are just as it sounds. Every screen of the app should have it’s own screen folder. If its a simple screen, you might just need one file inside that folder. If it’s a more complex screen I also like to include a local_widgets folder to be used for bigger widgets to keep the code clean.

### ./services directory

This folder is for anything interfacing outside of the application eg. Firebase, API.

### ./theme directory

Should contain all global sttling properties.

### ./utils directory

Should contain utility functions/helpers used across the app. Some examples might be validation, timeSince function, image capture logic, etc.

### ./widgets directory

Should contain all of the application's custom widgets.

### ./test directory

Should contain all of the application's tests.








