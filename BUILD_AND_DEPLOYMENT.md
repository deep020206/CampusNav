# 🚀 Build & Deployment Guide

**Project:** Campus Navigation & Smart Guide App  
**Organization:** UniNav Solutions  
**Date:** April 3, 2026  
**Status:** ✅ READY FOR DEPLOYMENT

---

## 📱 Build Commands

### Web Build (For Testing)
```bash
flutter pub get
flutter run -d chrome
```

### Android Build

#### Debug Build
```bash
flutter build apk --debug
```

#### Release Build
```bash
flutter build apk --release
```

#### Android App Bundle (for Google Play)
```bash
flutter build appbundle --release
```

**Output Location:**
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- Bundle: `build/app/outputs/bundle/release/app-release.aab`

### iOS Build

#### Debug Build
```bash
flutter build ios --debug
```

#### Release Build
```bash
flutter build ios --release
```

**Output Location:** `build/ios/Release/`

---

## 🔑 Configuration Before Build

### 1. Google Maps API Key Setup

#### For Android:
**File:** `android/app/src/main/AndroidManifest.xml`

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ANDROID_API_KEY_HERE"/>
```

#### For iOS:
**File:** `ios/Runner/Info.plist`

```xml
<key>com.google.ios.maps</key>
<string>YOUR_IOS_API_KEY_HERE</string>
```

### 2. App Name & Package Configuration

#### Android:
**File:** `android/app/build.gradle.kts`

```kotlin
namespace = "com.uninav.campus_navigation"

defaultConfig {
    applicationId = "com.uninav.campus_navigation"
    minSdk = 21
    targetSdk = 34
    versionCode = 1
    versionName = "1.0.0"
}
```

#### iOS:
**File:** `ios/Runner.xcodeproj/project.pbxproj`

```
PRODUCT_NAME = "Campus Navigation"
BUNDLE_IDENTIFIER = "com.uninav.campus-navigation"
MARKETING_VERSION = "1.0.0"
```

### 3. Version Configuration

**File:** `pubspec.yaml`

```yaml
version: 1.0.0+1
```

Format: `major.minor.patch+buildNumber`

### 4. App Icons & Splash

#### Generate Icons:
Use `flutter_launcher_icons` package (optional):

```bash
flutter pub add flutter_launcher_icons
```

**Configure in pubspec.yaml:**
```yaml
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icon.png"
  adaptive_icon_background: "#ffffff"
```

#### Generate:
```bash
flutter pub run flutter_launcher_icons
```

---

## 🔐 Signing Configuration

### Android Signing

#### Step 1: Create Keystore
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10950 -alias upload
```

#### Step 2: Create Key Properties
**File:** `android/key.properties`

```properties
storePassword=<your_password>
keyPassword=<your_key_password>
keyAlias=upload
storeFile=<path_to_keystore>/upload-keystore.jks
```

#### Step 3: Configure Gradle
**File:** `android/app/build.gradle.kts`

```kotlin
signingConfigs {
    release {
        keyAlias = keystoreProperties['keyAlias'] as String
        keyPassword = keystoreProperties['keyPassword'] as String
        storeFile = keystoreProperties['storeFile'] as File?
        storePassword = keystoreProperties['storePassword'] as String
    }
}

buildTypes {
    release {
        signingConfig = signingConfigs.release
    }
}
```

### iOS Signing

1. Open Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. Select Runner project
3. Select Runner target
4. Go to "Signing & Capabilities"
5. Set Team ID and signing certificate

---

## 📦 Building for Release

### Complete Build Process

```bash
# Step 1: Clean
flutter clean

# Step 2: Get dependencies
flutter pub get

# Step 3: Build
flutter build apk --release
flutter build appbundle --release
flutter build ios --release

# Step 4: Test APK (optional)
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## 📱 Google Play Store Submission

### Requirements

- ✅ Google Play Developer Account ($25 one-time fee)
- ✅ Signed APK or AAB
- ✅ App icon (512x512 PNG)
- ✅ Screenshots (minimum 2)
- ✅ Feature graphics (1024x500 PNG)
- ✅ Description (80 characters)
- ✅ Full description (4000 characters)
- ✅ Privacy policy URL

### Submission Steps

1. **Create Release:**
   ```
   Google Play Console > Select App > Release > Create new release
   ```

2. **Upload Bundle:**
   - Select built AAB file: `build/app/outputs/bundle/release/app-release.aab`

3. **Fill App Details:**
   - Title: "Campus Navigation"
   - Short description: "Navigate campus with real-time directions"
   - Full description: Complete feature list
   - Category: Travel & Local, or Education
   - Content rating: Complete questionnaire
   - Privacy policy: Add URL

4. **Add Graphics:**
   - App icon (512x512)
   - Feature graphic (1024x500)
   - Screenshots (minimum 2)
   - Video preview (optional)

5. **Pricing & Distribution:**
   - Price: Free
   - Target countries: Select all
   - Content rating: Not restricted

6. **Review & Launch:**
   - Review all details
   - Click "Review" then "Start rollout to production"
   - App appears in Play Store within hours

---

## 🍎 Apple App Store Submission

### Requirements

- ✅ Apple Developer Program membership ($99/year)
- ✅ Built iOS app (.ipa file)
- ✅ App icon (1024x1024 PNG)
- ✅ Screenshots (multiple sizes)
- ✅ Description
- ✅ Privacy policy URL
- ✅ Age rating

### Submission Steps

1. **Generate IPA:**
   ```bash
   flutter build ios --release
   cd build/ios/Release
   xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Release -derivedDataPath build -archivePath build/Runner.xcarchive archive
   xcodebuild -exportArchive -archivePath build/Runner.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath build/Runner.ipa
   ```

2. **Use Transporter App:**
   - Download from Mac App Store
   - Sign in with Apple ID
   - Drag and drop .ipa file
   - Review and submit

3. **Fill App Store Connect Details:**
   - App Name
   - Subtitle
   - Description
   - Keywords
   - Support URL
   - Privacy Policy URL

4. **Add Screenshots:**
   - iPhone screenshots
   - iPad screenshots (if applicable)
   - App Preview video (optional)

5. **Age Rating:**
   - Complete Apple questionnaire
   - Set age restrictions

6. **Submit for Review:**
   - Click "Submit for Review"
   - Apple reviews within 24-48 hours

---

## 🔍 Quality Assurance Before Release

### Pre-Release Checklist

- [ ] All screens load without errors
- [ ] Search functionality works correctly
- [ ] Location filtering works
- [ ] Route calculation is accurate
- [ ] Voice guidance initializes
- [ ] Settings persist
- [ ] No memory leaks
- [ ] App handles offline scenarios
- [ ] Crash logs reviewed
- [ ] Performance benchmarks met
- [ ] Security review completed
- [ ] Privacy policy updated
- [ ] Terms & conditions ready

### Testing Devices

**Minimum Testing:**
- 1 Android device (API 21+)
- 1 iOS device (iOS 12+)

**Recommended Testing:**
- Multiple screen sizes (phone, tablet)
- Various Android versions
- Various iOS versions
- Slow network conditions
- No network conditions

---

## 📊 Performance Optimization for Release

### Code Optimization

```bash
# Build with optimization flags
flutter build apk --split-per-abi --release
flutter build appbundle --target-platform android-arm,android-arm64,android-x86,android-x86_64 --release
```

### Bundle Size Reduction

```bash
# Analyze bundle
flutter build appbundle --analyze-size

# Build with optimizations
flutter build apk --obfuscate --split-debug-info=build/debug_info
```

### Performance Profiling

```bash
flutter run --profile
```

Use DevTools to identify bottlenecks

---

## 🐛 Debugging Release Builds

### Enable Logging in Release

**File:** `lib/main.dart`

```dart
void main() {
  // Enable logging for release builds
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {
      // Log to file or remote service
    };
  }
  
  runApp(const MyApp());
}
```

### Remote Crash Reporting

Add Firebase Crashlytics:

```bash
flutter pub add firebase_crashlytics firebase_core
```

---

## 📈 Post-Release Monitoring

### Setup Analytics

Add Firebase Analytics:

```bash
flutter pub add firebase_analytics
```

**Track custom events:**

```dart
FirebaseAnalytics.instance.logEvent(
  name: 'route_calculated',
  parameters: {
    'distance': distance,
    'duration': duration,
  },
);
```

### Monitor Crashes

- Firebase Crashlytics dashboard
- Google Play Console crash reports
- App Store Connect crash reports

### User Feedback

- In-app rating prompts
- Feedback forms
- App store reviews monitoring

---

## 🔄 Update Process

### For Minor Updates (1.0.1)

```bash
# Update pubspec.yaml
version: 1.0.1+2

# Build and submit
flutter build appbundle --release
# Submit to stores
```

### For Major Updates (1.1.0)

```bash
# Update pubspec.yaml
version: 1.1.0+3

# Update dependencies
flutter pub get

# Build and test thoroughly
flutter test
flutter build appbundle --release
```

---

## 🛠️ Troubleshooting Deployment

### Build Failures

**Android Build Fails:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

**iOS Build Fails:**
```bash
cd ios
rm -rf Pods
pod install
cd ..
flutter clean
flutter pub get
flutter build ios --release
```

### App Store Rejection Reasons

- ❌ Incomplete app information
- ❌ Crashing behavior
- ❌ Poor performance
- ❌ Misleading screenshots
- ❌ Privacy policy missing
- ❌ Excessive ads/monetization

**Prevention:** Follow all guidelines, test thoroughly, provide complete information

### Runtime Issues in Production

**App crashes on startup:**
- Check API key configuration
- Verify minimum SDK versions
- Check permissions manifest

**Location not working:**
- Verify geolocator configuration
- Check location permissions
- Test on real device

**Voice not working:**
- Verify flutter_tts configuration
- Check platform-specific settings
- Test TTS availability

---

## 📋 Release Checklist

### Code (1-2 weeks before)
- [ ] Code review completed
- [ ] All tests passing
- [ ] No critical bugs
- [ ] Performance optimized
- [ ] Memory leaks fixed
- [ ] Security reviewed

### Documentation (1 week before)
- [ ] Privacy policy updated
- [ ] Terms updated
- [ ] Help documentation ready
- [ ] Changelog prepared
- [ ] Support email configured

### Preparation (3-4 days before)
- [ ] API keys configured
- [ ] Signing keys created
- [ ] Screenshots prepared
- [ ] Icons optimized
- [ ] Descriptions written

### Testing (2-3 days before)
- [ ] QA testing completed
- [ ] Device testing done
- [ ] Network testing complete
- [ ] Crash testing passed
- [ ] Performance verified

### Submission (1 day before)
- [ ] Final build created
- [ ] Version numbers updated
- [ ] All store assets ready
- [ ] Review team on standby
- [ ] Post-release plan ready

### Launch Day
- [ ] Submit to Google Play
- [ ] Submit to App Store
- [ ] Monitor submissions
- [ ] Prepare announcements
- [ ] Customer support ready

### Post-Launch
- [ ] Monitor crash reports
- [ ] Check user feedback
- [ ] Verify analytics
- [ ] Plan first update
- [ ] Celebrate launch! 🎉

---

## 📞 Support Resources

- **Flutter Docs:** https://flutter.dev/docs
- **Google Play Console:** https://play.google.com/console
- **App Store Connect:** https://appstoreconnect.apple.com
- **Firebase:** https://firebase.google.com
- **Stack Overflow:** Tag: `flutter`

---

## 🎯 Next Steps After Deployment

1. **Monitor Performance:**
   - Crash rates
   - User ratings
   - Download count
   - Retention metrics

2. **Gather Feedback:**
   - App store reviews
   - In-app feedback
   - Social media
   - Support tickets

3. **Plan Updates:**
   - Bug fixes
   - Feature requests
   - Performance improvements
   - New features

4. **Marketing:**
   - Social media posts
   - Press releases
   - University announcements
   - User outreach

---

**Status:** ✅ READY FOR DEPLOYMENT  
**Last Updated:** April 3, 2026  
**Next Review:** Upon first submission  

Your app is ready to go! Follow these steps and you'll have Campus Navigation available for download within days. Good luck! 🚀
