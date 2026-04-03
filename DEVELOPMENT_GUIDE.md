# Campus Navigation App - Development Guide

## Project Overview

**App Name:** Campus Navigation & Smart Guide  
**Organization:** UniNav Solutions  
**Purpose:** Help students and visitors navigate large campuses efficiently  
**Technology Stack:** Flutter, Dart, Google Maps, SQLite, Hive  
**Version:** 1.0.0  
**Status:** Active Development

## Problem Statement

New students and visitors struggle to navigate large campuses, often wasting time locating:
- Classrooms
- Administrative offices
- Facilities (cafeteria, library, gym)
- Emergency services

### Key Pain Points
1. **Difficulty locating specific locations** - No centralized directory
2. **Time wastage during initial campus days** - Getting lost wastes precious time
3. **Lack of integrated navigation system** - Multiple disparate systems
4. **Poor accessibility for visitors** - Unclear directions and signage

## Solution Features

### Core Functionality
✅ **Real-time Maps Integration**
   - Google Maps for outdoor navigation
   - Support for campus-specific markers
   - Route highlighting and distance display

✅ **Location Search & Discovery**
   - Full-text search across location database
   - Category-based browsing
   - Keyword filtering

✅ **Step-by-Step Navigation**
   - Turn-by-turn directions
   - Distance and time estimates
   - Progress tracking

✅ **Voice Guidance**
   - Text-to-speech navigation instructions
   - Configurable speech rate
   - Multi-language support (future)

✅ **Offline Functionality**
   - Cache maps for offline access
   - Local SQLite database for locations
   - Hive for quick data access

### Advanced Features (Future)
- AR-based indoor navigation
- Real-time location tracking
- Campus events integration
- Emergency routing
- Accessibility features

## Architecture Overview

### 1. Data Layer

**Models**
```
location_model.dart
├── CampusLocation
│   ├── id: String
│   ├── name: String
│   ├── coordinates: (lat, lon)
│   ├── type: LocationType
│   ├── description: String
│   ├── floorInfo: String?
│   └── keywords: List<String>
│
└── LocationType (enum)
    ├── classroom
    ├── office
    ├── library
    ├── cafeteria
    ├── medical
    └── ... (11 types total)

route_model.dart
├── NavigationRoute
│   ├── id: String
│   ├── startLocation: String
│   ├── endLocation: String
│   ├── points: List<RoutePoint>
│   ├── distance: double
│   └── estimatedTime: int
│
└── RoutePoint
    ├── latitude: double
    ├── longitude: double
    ├── instruction: String?
    └── stepNumber: int?
```

**Services**

```
location_service.dart
├── fetchAllLocations()
├── searchLocations(query)
├── getLocationById(id)
└── getLocationsByType(type)

navigation_service.dart
├── calculateRoute(start, end)
├── getFormattedDistance(meters)
└── getFormattedTime(minutes)

voice_service.dart
├── speak(text)
├── speakNavigation(instruction)
├── pause()
└── stop()
```

### 2. Business Logic Layer (State Management)

**NavigationProvider**
```
navigation_provider.dart
├── State
│   ├── allLocations: List<CampusLocation>
│   ├── searchResults: List<CampusLocation>
│   ├── currentRoute: NavigationRoute?
│   ├── selectedStartLocation: CampusLocation?
│   ├── selectedEndLocation: CampusLocation?
│   ├── isLoading: bool
│   └── error: String?
│
└── Methods
    ├── initializeLocations()
    ├── searchLocations(query)
    ├── setStartLocation(location)
    ├── setEndLocation(location)
    ├── calculateRoute()
    └── clearRoute()
```

### 3. Presentation Layer (UI)

**Screens**

```
home_screen.dart
├── Search bar
├── Quick access buttons (classrooms, library, etc.)
└── Location listing grid

navigation_screen.dart
├── Start location selector
├── End location selector
├── Route calculation button
└── Route details display
    ├── Distance & time info
    └── Step-by-step instructions

location_details_screen.dart
├── Location header with icon
├── Information section
│   ├── Type
│   ├── Coordinates
│   └── Keywords
└── Navigation button

locations_list_screen.dart
├── Search bar
├── Filtered location list
└── Location tiles with navigation

settings_screen.dart
├── Voice guidance toggle
├── Offline maps toggle
├── Speech rate slider
├── Language selection
└── About & support
```

## Key Technologies

### Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| provider | ^6.0.0 | State management |
| google_maps_flutter | ^2.5.0 | Map integration |
| geolocator | ^9.0.2 | GPS location |
| location | ^5.0.0 | Location services |
| flutter_tts | ^4.2.5 | Voice guidance |
| sqflite | ^2.2.8 | Local database |
| hive | ^2.2.3 | Key-value storage |
| flutter_cache_manager | ^3.3.0 | Offline maps |
| http | ^1.1.0 | API calls |
| intl | ^0.19.0 | Localization |
| lottie | ^2.7.0 | Animations |

## Development Workflow

### Phase 1: Initialization (Commit 1)
✅ Project setup
✅ Dependency installation
✅ Project structure creation
✅ Configuration files setup

### Phase 2: Maps Integration (Commit 2)
✅ Google Maps setup
✅ Location services integration
✅ Geolocator implementation
✅ Basic map view

### Phase 3: Navigation Logic (Commit 3)
✅ Route calculation algorithm
✅ Distance calculation (Haversine formula)
✅ Navigation instructions generation
✅ Voice service integration

### Phase 4: UI Enhancements (Commit 4)
✅ Home screen implementation
✅ Navigation screen design
✅ Location details screen
✅ Settings screen
✅ Theme and styling

## Implementation Details

### Route Calculation Algorithm

```dart
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadiusM = 6371000;
  final dLat = toRad(lat2 - lat1);
  final dLon = toRad(lon2 - lon1);
  final a = sin(dLat/2)² + cos(lat1) * cos(lat2) * sin(dLon/2)²;
  final c = 2 * atan2(√a, √(1-a));
  return earthRadiusM * c;
}
```

### Waypoint Generation
- Interpolate 10 points along the straight line
- Provide instructions at start, middle, and end
- Include distance and time for each leg

### Voice Guidance
- Uses FlutterTts for text-to-speech
- Configurable speech rate (0.3 - 1.0x)
- Supports multiple languages (English default)

## File Structure

```
campus_navigation/
├── lib/
│   ├── main.dart                    # Entry point
│   ├── models/
│   │   ├── location_model.dart
│   │   └── route_model.dart
│   ├── providers/
│   │   └── navigation_provider.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── navigation_screen.dart
│   │   ├── location_details_screen.dart
│   │   ├── locations_list_screen.dart
│   │   └── settings_screen.dart
│   └── services/
│       ├── location_service.dart
│       ├── navigation_service.dart
│       └── voice_service.dart
├── android/
│   └── app/src/main/AndroidManifest.xml
├── ios/
│   └── Runner/Info.plist
├── pubspec.yaml
└── README.md
```

## Database Schema

### Locations Table (SQLite)
```sql
CREATE TABLE locations (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  latitude REAL NOT NULL,
  longitude REAL NOT NULL,
  type TEXT NOT NULL,
  floor_info TEXT,
  keywords TEXT,
  image_url TEXT,
  created_at TIMESTAMP
);

CREATE INDEX idx_type ON locations(type);
CREATE INDEX idx_keywords ON locations(keywords);
```

### Hive Models
```dart
// Location cache
@HiveType()
class CachedLocation {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  // ... other fields
}

// Route cache
@HiveType()
class CachedRoute {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List<RoutePoint> points;
  // ... other fields
}
```

## API Integration (Future)

### Endpoints
```
GET  /api/v1/locations              - All locations
GET  /api/v1/locations/{id}         - Location details
GET  /api/v1/locations/search?q=... - Search
POST /api/v1/routes/calculate       - Calculate route
GET  /api/v1/events                 - Campus events
```

### Error Handling
- Graceful fallback to local data
- User-friendly error messages
- Automatic retry logic
- Offline mode detection

## Performance Optimization

### Load Time Reduction
- Lazy load images
- Cache location data
- Minimize map updates
- Debounce search queries

### Memory Management
- Dispose of controllers properly
- Use const constructors
- Limit list rendering (pagination)
- Clear cache periodically

### Battery Optimization
- Stop GPS when app backgrounded
- Cache location results
- Minimize map rendering updates
- Implement efficient algorithms

## Security Considerations

- **API Keys:** Store in environment, not in code
- **User Data:** Handle location data carefully
- **Permissions:** Request only necessary permissions
- **Validation:** Validate all user inputs
- **Error Messages:** Don't expose system details

## Testing Strategy

### Unit Tests
```bash
flutter test test/services/
```

### Widget Tests
```bash
flutter test test/screens/
```

### Integration Tests
```bash
flutter test test/integration/
```

### Manual Testing Checklist
- [ ] Search functionality
- [ ] Route calculation
- [ ] Voice guidance
- [ ] Offline mode
- [ ] Location details
- [ ] UI responsiveness
- [ ] Error handling
- [ ] Performance

## Deployment

### Build for Android
```bash
flutter build apk --release
# or for app bundle:
flutter build appbundle --release
```

### Build for iOS
```bash
flutter build ios --release
```

### Store Deployment
- Google Play Store: .aab format
- Apple App Store: .ipa format
- Include screenshots, descriptions, privacy policy

## Future Enhancements

### Priority 1
- Real-time indoor positioning (BLE)
- User reviews and ratings
- Favorite locations save

### Priority 2
- AR navigation overlay
- Campus event integration
- Accessibility features

### Priority 3
- Social sharing
- Multi-campus support
- Analytics dashboard

## Resources

### Flutter Documentation
- [Flutter Docs](https://flutter.dev/docs)
- [Dart Docs](https://dart.dev/guides)
- [Provider Package](https://pub.dev/packages/provider)

### Maps & Location
- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
- [Geolocator](https://pub.dev/packages/geolocator)
- [Location Package](https://pub.dev/packages/location)

### Tools
- [Firebase Console](https://console.firebase.google.com)
- [Google Cloud Console](https://console.cloud.google.com)
- [VS Code](https://code.visualstudio.com)

## Troubleshooting Guide

### Map not displaying
```bash
# Clear build files
flutter clean
flutter pub get
flutter run
```

### Permission issues
- Check AndroidManifest.xml
- Verify iOS Info.plist
- Test on actual device

### Performance issues
- Profile with DevTools
- Check memory usage
- Optimize build settings

---

**Last Updated:** 2026  
**Maintained By:** Development Team  
**Contact:** dev@uninav.com
