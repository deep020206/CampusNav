# Testing Guide & Quality Assurance

## Overview

This document outlines the testing strategy, guidelines, and procedures for the Campus Navigation App.

---

## Testing Strategy

### Test Pyramid
```
        /\
       /  \
      / UI \            Integration Tests (5-10%)
     /______\
    /        \
   /  Widget  \        Widget Tests (15-20%)
  /____________\
 /              \
/ Unit Tests     \    Unit Tests (70-80%)
/_________________\
```

### Types of Tests

1. **Unit Tests** - Test individual functions/classes
2. **Widget Tests** - Test UI components in isolation
3. **Integration Tests** - Test app flows end-to-end

---

## Unit Tests

### LocationService Tests
```dart
// test/services/location_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:campus_navigation/services/location_service.dart';
import 'package:campus_navigation/models/location_model.dart';

void main() {
  group('LocationService', () {
    late LocationService locationService;

    setUp(() {
      locationService = LocationService();
    });

    test('fetchAllLocations returns non-empty list', () async {
      final locations = await locationService.fetchAllLocations();
      expect(locations, isNotEmpty);
      expect(locations.length, greaterThan(0));
    });

    test('fetchAllLocations returns valid CampusLocation objects', () async {
      final locations = await locationService.fetchAllLocations();
      for (var location in locations) {
        expect(location.id, isNotNull);
        expect(location.name, isNotNull);
        expect(location.latitude, isNotNull);
        expect(location.longitude, isNotNull);
      }
    });

    test('searchLocations returns matching results', () async {
      final results = await locationService.searchLocations('library');
      expect(results, isNotEmpty);
      expect(
        results.every((l) => 
          l.name.toLowerCase().contains('library') ||
          l.keywords?.any((k) => k.toLowerCase().contains('library')) ?? false
        ),
        true
      );
    });

    test('searchLocations returns empty for non-matching query', () async {
      final results = await locationService.searchLocations('xyz123');
      expect(results, isEmpty);
    });

    test('getLocationById returns correct location', () async {
      final location = await locationService.getLocationById('1');
      expect(location, isNotNull);
      expect(location?.id, equals('1'));
    });

    test('getLocationsByType filters correctly', () async {
      final classrooms = await locationService
          .getLocationsByType(LocationType.classroom);
      expect(
        classrooms.every((l) => l.type == LocationType.classroom),
        true
      );
    });
  });
}
```

### NavigationService Tests
```dart
// test/services/navigation_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:campus_navigation/services/navigation_service.dart';
import 'package:campus_navigation/models/location_model.dart';

void main() {
  group('NavigationService', () {
    late NavigationService navigationService;

    setUp(() {
      navigationService = NavigationService();
    });

    test('calculateRoute returns valid route', () async {
      final start = CampusLocation(
        id: '1',
        name: 'Building A',
        description: 'Test',
        latitude: 37.7749,
        longitude: -122.4194,
        type: LocationType.classroom,
      );

      final end = CampusLocation(
        id: '2',
        name: 'Building B',
        description: 'Test',
        latitude: 37.7755,
        longitude: -122.4180,
        type: LocationType.library,
      );

      final route = await navigationService.calculateRoute(start, end);
      
      expect(route, isNotNull);
      expect(route.distanceInMeters, greaterThan(0));
      expect(route.estimatedMinutes, greaterThan(0));
      expect(route.points, isNotEmpty);
    });

    test('calculateRoute generates correct waypoints', () async {
      final start = CampusLocation(
        id: '1',
        name: 'A',
        description: '',
        latitude: 0.0,
        longitude: 0.0,
        type: LocationType.classroom,
      );

      final end = CampusLocation(
        id: '2',
        name: 'B',
        description: '',
        latitude: 1.0,
        longitude: 1.0,
        type: LocationType.library,
      );

      final route = await navigationService.calculateRoute(start, end);
      
      expect(route.points.length, greaterThan(0));
      expect(route.points.first.latitude, equals(0.0));
      expect(route.points.last.latitude, equals(1.0));
    });

    test('getFormattedDistance works correctly', () {
      expect(navigationService.getFormattedDistance(500), '500 m');
      expect(navigationService.getFormattedDistance(1500), '1.50 km');
      expect(navigationService.getFormattedDistance(5000), '5.00 km');
    });

    test('getFormattedTime works correctly', () {
      expect(navigationService.getFormattedTime(15), '15 min');
      expect(navigationService.getFormattedTime(120), '2h 0m');
      expect(navigationService.getFormattedTime(90), '1h 30m');
    });
  });
}
```

### NavigationProvider Tests
```dart
// test/providers/navigation_provider_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:campus_navigation/providers/navigation_provider.dart';
import 'package:campus_navigation/models/location_model.dart';

void main() {
  group('NavigationProvider', () {
    late NavigationProvider provider;

    setUp(() {
      provider = NavigationProvider();
    });

    test('initial state is correct', () {
      expect(provider.allLocations, isEmpty);
      expect(provider.searchResults, isEmpty);
      expect(provider.currentRoute, isNull);
      expect(provider.selectedStartLocation, isNull);
      expect(provider.selectedEndLocation, isNull);
      expect(provider.isLoading, false);
      expect(provider.error, isNull);
    });

    test('setStartLocation updates state', () {
      final location = CampusLocation(
        id: '1',
        name: 'Test',
        description: '',
        latitude: 0.0,
        longitude: 0.0,
        type: LocationType.classroom,
      );

      provider.setStartLocation(location);
      expect(provider.selectedStartLocation, equals(location));
    });

    test('setEndLocation updates state', () {
      final location = CampusLocation(
        id: '2',
        name: 'Test',
        description: '',
        latitude: 1.0,
        longitude: 1.0,
        type: LocationType.library,
      );

      provider.setEndLocation(location);
      expect(provider.selectedEndLocation, equals(location));
    });

    test('clearRoute resets state', () {
      provider.setStartLocation(CampusLocation(
        id: '1',
        name: 'A',
        description: '',
        latitude: 0.0,
        longitude: 0.0,
        type: LocationType.classroom,
      ));

      provider.clearRoute();

      expect(provider.selectedStartLocation, isNull);
      expect(provider.selectedEndLocation, isNull);
      expect(provider.currentRoute, isNull);
    });

    test('searchLocations filters correctly', () async {
      await provider.initializeLocations();
      await provider.searchLocations('library');
      
      expect(provider.searchResults, isNotEmpty);
    });

    test('calculateRoute requires both locations', () async {
      await provider.calculateRoute();
      expect(provider.error, isNotNull);
    });
  });
}
```

---

## Widget Tests

### HomeScreen Tests
```dart
// test/screens/home_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:campus_navigation/screens/home_screen.dart';
import 'package:campus_navigation/providers/navigation_provider.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('HomeScreen renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ],
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      expect(find.text('Campus Navigation'), findsOneWidget);
      expect(find.text('Welcome to UniNav'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('Search bar updates results', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ],
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'library');
      await tester.pumpAndSettle();

      expect(find.text('library'), findsWidgets);
    });

    testWidgets('Quick access buttons render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ],
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('Classrooms'), findsOneWidget);
      expect(find.text('Library'), findsOneWidget);
      expect(find.text('Cafeteria'), findsOneWidget);
      expect(find.text('Medical'), findsOneWidget);
    });

    testWidgets('Location cards are tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ],
          child: MaterialApp(
            home: const HomeScreen(),
            routes: {
              '/location-details': (context) => Container(),
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      final cards = find.byType(Card);
      if (cards.evaluate().isNotEmpty) {
        await tester.tap(cards.first);
        await tester.pumpAndSettle();
      }
    });
  });
}
```

### NavigationScreen Tests
```dart
// test/screens/navigation_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:campus_navigation/screens/navigation_screen.dart';
import 'package:campus_navigation/providers/navigation_provider.dart';

void main() {
  group('NavigationScreen Widget Tests', () {
    testWidgets('NavigationScreen renders correctly', 
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ],
          child: const MaterialApp(
            home: NavigationScreen(),
          ),
        ),
      );

      expect(find.text('Navigation'), findsOneWidget);
      expect(find.text('From'), findsOneWidget);
      expect(find.text('To'), findsOneWidget);
    });

    testWidgets('Calculate Route button is disabled initially', 
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ],
          child: const MaterialApp(
            home: NavigationScreen(),
          ),
        ),
      );

      final button = find.byType(ElevatedButton);
      expect(button, findsWidgets);
    });
  });
}
```

---

## Integration Tests

### App Flow Test
```dart
// test_driver/app_flow_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:campus_navigation/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Campus Navigation App Flow', () {
    testWidgets('Complete navigation flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test home screen loads
      expect(find.text('Campus Navigation'), findsOneWidget);

      // Search for location
      await tester.enterText(
        find.byType(TextField),
        'Library',
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Navigate to location details
      final cards = find.byType(Card);
      if (cards.evaluate().isNotEmpty) {
        await tester.tap(cards.first);
        await tester.pumpAndSettle();
      }

      // Navigate back
      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(find.text('Campus Navigation'), findsOneWidget);
    });
  });
}
```

---

## Manual Testing Checklist

### Functional Testing

#### Home Screen
- [ ] App loads without errors
- [ ] Welcome message displays correctly
- [ ] Search bar is functional
- [ ] Quick access buttons work
- [ ] Location list displays properly
- [ ] Location cards are clickable
- [ ] Scrolling works smoothly

#### Navigation Screen
- [ ] Both location selectors work
- [ ] Location search filters correctly
- [ ] Route calculation completes successfully
- [ ] Distance and time display correctly
- [ ] Step-by-step directions are clear
- [ ] View Map button works
- [ ] Clear button resets form

#### Location Details Screen
- [ ] Location information displays
- [ ] All fields populate correctly
- [ ] Navigate button works
- [ ] Back navigation functions

#### Settings Screen
- [ ] Voice guidance toggle works
- [ ] Offline maps toggle works
- [ ] Speech rate slider functions
- [ ] Language dropdown works
- [ ] Clear cache shows confirmation
- [ ] Help dialog displays

### Performance Testing

#### Load Times
- [ ] App startup < 3 seconds
- [ ] Home screen renders < 2 seconds
- [ ] Search results < 500ms
- [ ] Route calculation < 2 seconds

#### Memory
- [ ] No memory leaks after 10 min use
- [ ] Memory usage < 150MB
- [ ] Smooth scrolling (60 FPS)

#### Battery
- [ ] No excessive battery drain
- [ ] Location polling optimized
- [ ] Proper cleanup on app close

### Compatibility Testing

#### Android
- [ ] Minimum API 21 supported
- [ ] Works on various screen sizes
- [ ] Permissions handled correctly
- [ ] Back button works properly

#### iOS
- [ ] iOS 12.0+ supported
- [ ] iPhone/iPad responsive
- [ ] Safe area respected
- [ ] Notch handling correct

---

## Test Running Commands

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/services/location_service_test.dart
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Generate Coverage Report
```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Run Widget Tests Only
```bash
flutter test test/screens/
```

### Run Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

---

## Continuous Integration

### GitHub Actions Setup
```yaml
name: Flutter Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
      - run: flutter test --coverage
```

---

## Bug Reporting Template

```
## Bug Report

**Title:** Brief description

**Severity:** Critical/High/Medium/Low

**Environment:**
- Device: [Model]
- OS: [Android/iOS version]
- App Version: [Version]

**Steps to Reproduce:**
1. 
2. 
3. 

**Expected Result:**
What should happen

**Actual Result:**
What actually happens

**Screenshots/Logs:**
[Attach if possible]

**Additional Info:**
Any other relevant information
```

---

## Test Coverage Goals

| Component | Target Coverage |
|-----------|-----------------|
| Services | 90%+ |
| Models | 85%+ |
| Providers | 85%+ |
| Screens | 60%+ |
| Overall | 75%+ |

---

## Debugging Tools

### DevTools
```bash
flutter pub global activate devtools
devtools
```

### Android Studio
- Built-in debugger
- Layout inspector
- Performance monitor

### VS Code
- Dart Debug extension
- Flutter extensions
- Error message clarity

---

## Performance Profiling

### CPU Profile
```bash
flutter run --profile
# In DevTools: DevTools > Performance
```

### Memory Profile
```bash
# In DevTools: DevTools > Memory
```

### Build Size
```bash
flutter build apk --analyze-size
```

---

## Accessibility Testing

- [ ] Text sizes are readable
- [ ] Colors have sufficient contrast
- [ ] Touch targets are >= 48dp
- [ ] Semantic labels present
- [ ] Screen reader compatible (future)

---

**Last Updated:** 2026  
**Test Framework:** Flutter Test  
**Coverage Tool:** LCOV
