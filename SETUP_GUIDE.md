# Installation & Setup Guide

## Quick Start

### Prerequisites
- Flutter SDK 3.8.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio (for Android development)
- Xcode (for iOS development)
- Git
- Google Maps API Key

### Step 1: Clone Repository

```bash
git clone https://github.com/yourusername/campus-navigation.git
cd campus_navigation
```

### Step 2: Install Flutter Dependencies

```bash
flutter pub get
```

### Step 3: Configure Google Maps API Key

#### For Android

1. Open `android/app/src/main/AndroidManifest.xml`
2. Add your API key:

```xml
<application>
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="YOUR_API_KEY_HERE" />
</application>
```

#### For iOS

1. Open `ios/Runner/GeneratedPluginRegistrant.m`
2. Add API key in GoogleMaps plugin configuration

Or use CocoaPods to configure:

```bash
cd ios
pod install
cd ..
```

### Step 4: Set Up Location Permissions

#### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

#### iOS (`ios/Runner/Info.plist`)

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs your location for campus navigation</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs your location for campus navigation</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access for voice features</string>
```

### Step 5: Run the App

```bash
# For Android
flutter run

# For iOS
flutter run -d iphone

# For a specific device
flutter run -d <device-id>
```

## Detailed Setup Instructions

### Google Maps API Key Setup

1. **Create a Google Cloud Project**
   - Go to [Google Cloud Console](https://console.cloud.google.com)
   - Create a new project
   - Enable Maps APIs:
     - Google Maps Platform
     - Maps SDK for Android
     - Maps SDK for iOS

2. **Generate API Key**
   - Go to Credentials
   - Create API Key
   - Restrict to Android/iOS apps
   - Add package name and SHA-1 fingerprint for Android

3. **Get SHA-1 Fingerprint (Android)**
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```

### Database Setup

The app uses SQLite and Hive for local storage.

#### First-time Setup
```bash
flutter pub run build_runner build
```

This generates Hive adapter files for data persistence.

### Running Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/services/location_service_test.dart

# With coverage
flutter test --coverage
```

## Platform-Specific Setup

### Android Setup

1. **Minimum SDK Version**
   - Edit `android/app/build.gradle`
   - Set `minSdkVersion = 21`

2. **Enable MultiDex** (if needed)
   ```gradle
   android {
       ...
       defaultConfig {
           ...
           multiDexEnabled = true
       }
   }
   ```

3. **Configure Gradle**
   ```bash
   cd android
   ./gradlew clean
   ./gradlew build
   ```

### iOS Setup

1. **Minimum iOS Version**
   - Edit `ios/Podfile`
   - Set `platform :ios, '12.0'`

2. **Install Pods**
   ```bash
   cd ios
   pod deintegrate
   pod install
   cd ..
   ```

3. **Configure Xcode**
   - Open `ios/Runner.xcworkspace`
   - Set deployment target to iOS 12.0+
   - Select your team for code signing

## Environment Configuration

### Create `.env` file (optional)

```env
GOOGLE_MAPS_API_KEY=your_api_key_here
API_BASE_URL=https://api.example.com
DEBUG_MODE=true
```

### Load in main.dart

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main async {
  await dotenv.load();
  runApp(const MyApp());
}
```

## Development Tools Setup

### VS Code Extensions

Install recommended extensions:
- Flutter
- Dart
- Google Maps Flutter Snippets
- Dart Data Class Generator
- Build Runner

### Android Studio Plugins

- Flutter
- Dart
- Google Maps Android API Debugger

## Common Installation Issues

### Issue: "flutter: command not found"

**Solution:**
```bash
# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verify
flutter --version
```

### Issue: "CocoaPods not installed"

**Solution:**
```bash
sudo gem install cocoapods
pod setup
```

### Issue: "Xcode not found"

**Solution:**
```bash
xcode-select --install
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

### Issue: "Google Maps API Key not working"

**Solution:**
1. Verify API key is enabled in Google Cloud Console
2. Check package name and SHA-1 fingerprint match Android config
3. Ensure Maps SDK for Android is enabled
4. Clear app cache: `flutter clean && flutter pub get`

### Issue: "Location permission denied"

**Solution:**
1. Check permissions in AndroidManifest.xml and Info.plist
2. Grant permissions when app first runs
3. Test on actual device (emulator has limitations)

### Issue: "App crashes on startup"

**Solution:**
```bash
# Clear everything
flutter clean
rm -rf pubspec.lock
flutter pub get
flutter run
```

## Verification Checklist

After installation, verify:

- [ ] Flutter version is 3.8.0 or higher
  ```bash
  flutter --version
  ```

- [ ] All dependencies are installed
  ```bash
  flutter pub get
  ```

- [ ] Google Maps API key is configured
  - Check AndroidManifest.xml
  - Check Info.plist

- [ ] Location permissions are set
  - Android: AndroidManifest.xml has permissions
  - iOS: Info.plist has descriptions

- [ ] App runs without errors
  ```bash
  flutter run
  ```

- [ ] Home screen displays properly
- [ ] Location search works
- [ ] Navigation calculations work
- [ ] Settings screen is accessible

## Build Configuration

### Debug Build
```bash
flutter run
```

### Release Build
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
flutter build ipa --release
```

## Performance Optimization

### Enable Release Mode Features

```bash
flutter run --release
```

### Build Output Size Optimization

```bash
flutter build apk --release --split-per-abi
```

## Next Steps

After successful installation:

1. Review the [README.md](README.md) for feature overview
2. Read [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md) for architecture details
3. Explore the codebase structure
4. Run the app and test features
5. Configure for your campus (update location data)

## Getting Help

- **Flutter Issues:** `flutter doctor -v`
- **Dependency Issues:** `flutter pub outdated`
- **Build Issues:** `flutter clean && flutter pub get`
- **Documentation:** [Flutter Docs](https://flutter.dev/docs)

## Support

For installation issues:
1. Check this guide thoroughly
2. Review error messages carefully
3. Search Flutter documentation
4. Check platform-specific setup sections
5. Contact development team

---

**Last Updated:** 2026  
**Flutter Version:** 3.8.0+  
**Dart Version:** 3.0.0+
