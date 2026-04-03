# API Documentation & Backend Integration

## Overview

This document outlines the API structure for the Campus Navigation App backend (future integration) and current data models.

---

## Current Architecture

### Data Flow
```
UI Layer (Screens)
    ↓
State Management (Provider)
    ↓
Services (Location, Navigation, Voice)
    ↓
Local Storage (SQLite, Hive)
    ↓
Mock Data (LocationService)
```

---

## Future API Endpoints

### Base URL
```
https://api.uninav.solutions/v1
```

### Authentication
```
Header: Authorization: Bearer {token}
Content-Type: application/json
```

---

## Endpoints

### 1. Locations

#### Get All Locations
```
GET /locations

Query Parameters:
  - limit (default: 50)
  - offset (default: 0)
  - type (optional: classroom, library, office, etc.)

Response (200):
{
  "success": true,
  "data": [
    {
      "id": "1",
      "name": "Central Library",
      "description": "Main library with 5 floors",
      "latitude": 37.7755,
      "longitude": -122.4180,
      "type": "library",
      "floorInfo": "Floors 1-5",
      "keywords": ["library", "books", "study"],
      "imageUrl": "https://...",
      "createdAt": "2026-01-15T10:30:00Z",
      "updatedAt": "2026-03-01T14:20:00Z"
    }
  ],
  "pagination": {
    "total": 150,
    "limit": 50,
    "offset": 0
  }
}
```

#### Get Location by ID
```
GET /locations/{id}

Response (200):
{
  "success": true,
  "data": {
    "id": "1",
    "name": "Central Library",
    "description": "Main library with 5 floors",
    "latitude": 37.7755,
    "longitude": -122.4180,
    "type": "library",
    "floorInfo": "Floors 1-5",
    "keywords": ["library", "books", "study"],
    "imageUrl": "https://...",
    "openingHours": {
      "monday": "08:00-22:00",
      "tuesday": "08:00-22:00",
      "wednesday": "08:00-22:00",
      "thursday": "08:00-22:00",
      "friday": "08:00-20:00",
      "saturday": "10:00-18:00",
      "sunday": "10:00-18:00"
    },
    "phone": "+1-234-567-8900",
    "email": "library@uninav.edu"
  }
}
```

#### Search Locations
```
GET /locations/search

Query Parameters:
  - q (search query, required)
  - type (optional filter)
  - limit (default: 20)

Response (200):
{
  "success": true,
  "data": [
    {
      "id": "1",
      "name": "Central Library",
      "description": "Main library with 5 floors",
      "latitude": 37.7755,
      "longitude": -122.4180,
      "type": "library",
      "keywords": ["library", "books", "study"],
      "matchScore": 0.95
    }
  ],
  "query": "library",
  "resultCount": 5
}
```

#### Get Locations by Type
```
GET /locations/type/{type}

Query Parameters:
  - type: classroom, office, library, cafeteria, medical, laboratory, auditorium, gymnasium, parking, restroom, other
  - limit (default: 50)
  - offset (default: 0)

Response (200):
{
  "success": true,
  "data": [
    {
      "id": "1",
      "name": "Building A - Classroom 101",
      "description": "Main classroom in Building A, 1st Floor",
      "latitude": 37.7749,
      "longitude": -122.4194,
      "type": "classroom",
      "floorInfo": "Floor 1"
    }
  ],
  "type": "classroom",
  "count": 45
}
```

#### Create Location (Admin)
```
POST /locations

Body:
{
  "name": "New Building",
  "description": "Description here",
  "latitude": 37.7755,
  "longitude": -122.4180,
  "type": "classroom",
  "floorInfo": "Floor 1",
  "keywords": ["keyword1", "keyword2"],
  "imageUrl": "https://...",
  "openingHours": {
    "monday": "08:00-17:00"
  }
}

Response (201):
{
  "success": true,
  "data": {
    "id": "123",
    "name": "New Building",
    "createdAt": "2026-04-03T12:00:00Z"
  }
}
```

#### Update Location (Admin)
```
PUT /locations/{id}

Body:
{
  "name": "Updated Name",
  "description": "Updated description",
  ...
}

Response (200):
{
  "success": true,
  "data": {
    "id": "123",
    "name": "Updated Name",
    "updatedAt": "2026-04-03T12:00:00Z"
  }
}
```

#### Delete Location (Admin)
```
DELETE /locations/{id}

Response (204):
No content
```

---

### 2. Routes / Navigation

#### Calculate Route
```
POST /routes/calculate

Body:
{
  "startLocationId": "1",
  "endLocationId": "2"
}

Response (200):
{
  "success": true,
  "data": {
    "id": "route_123",
    "startLocationId": "1",
    "endLocationId": "2",
    "distanceInMeters": 250.5,
    "estimatedMinutes": 4,
    "type": "mixed",
    "points": [
      {
        "latitude": 37.7749,
        "longitude": -122.4194,
        "instruction": "Start at Building A - Classroom 101",
        "stepNumber": 0
      },
      {
        "latitude": 37.7752,
        "longitude": -122.4190,
        "instruction": "Continue straight",
        "stepNumber": 1
      },
      {
        "latitude": 37.7755,
        "longitude": -122.4180,
        "instruction": "Arrive at Central Library",
        "stepNumber": 2
      }
    ]
  }
}
```

#### Get Route by ID
```
GET /routes/{id}

Response (200):
{
  "success": true,
  "data": {
    "id": "route_123",
    "startLocationId": "1",
    "endLocationId": "2",
    "distanceInMeters": 250.5,
    "estimatedMinutes": 4,
    "type": "mixed",
    "points": [...]
  }
}
```

#### Get User Routes (History)
```
GET /routes/user/history

Query Parameters:
  - limit (default: 20)
  - offset (default: 0)

Response (200):
{
  "success": true,
  "data": [
    {
      "id": "route_123",
      "startLocation": "Building A",
      "endLocation": "Library",
      "distanceInMeters": 250.5,
      "estimatedMinutes": 4,
      "createdAt": "2026-04-03T10:00:00Z"
    }
  ]
}
```

---

### 3. Users

#### Register
```
POST /users/register

Body:
{
  "email": "user@example.com",
  "password": "password123",
  "firstName": "John",
  "lastName": "Doe"
}

Response (201):
{
  "success": true,
  "data": {
    "id": "user_123",
    "email": "user@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "createdAt": "2026-04-03T12:00:00Z"
  },
  "token": "eyJhbGciOiJIUzI1NiIs..."
}
```

#### Login
```
POST /users/login

Body:
{
  "email": "user@example.com",
  "password": "password123"
}

Response (200):
{
  "success": true,
  "data": {
    "id": "user_123",
    "email": "user@example.com",
    "firstName": "John"
  },
  "token": "eyJhbGciOiJIUzI1NiIs..."
}
```

#### Get User Profile
```
GET /users/profile

Response (200):
{
  "success": true,
  "data": {
    "id": "user_123",
    "email": "user@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "preferences": {
      "voiceGuidance": true,
      "language": "en",
      "speechRate": 0.5
    },
    "favoriteLocations": ["1", "5", "12"],
    "createdAt": "2026-04-03T12:00:00Z"
  }
}
```

#### Update User Preferences
```
PUT /users/preferences

Body:
{
  "voiceGuidance": true,
  "language": "en",
  "speechRate": 0.6
}

Response (200):
{
  "success": true,
  "data": {
    "preferences": {
      "voiceGuidance": true,
      "language": "en",
      "speechRate": 0.6
    },
    "updatedAt": "2026-04-03T12:00:00Z"
  }
}
```

---

### 4. Favorites

#### Add to Favorites
```
POST /favorites

Body:
{
  "locationId": "1"
}

Response (201):
{
  "success": true,
  "data": {
    "id": "fav_123",
    "locationId": "1",
    "createdAt": "2026-04-03T12:00:00Z"
  }
}
```

#### Get User Favorites
```
GET /favorites

Response (200):
{
  "success": true,
  "data": [
    {
      "id": "1",
      "name": "Central Library",
      "type": "library",
      "latitude": 37.7755,
      "longitude": -122.4180
    }
  ],
  "count": 5
}
```

#### Remove from Favorites
```
DELETE /favorites/{locationId}

Response (204):
No content
```

---

### 5. Events (Future)

#### Get Campus Events
```
GET /events

Query Parameters:
  - date (optional: YYYY-MM-DD)
  - category (optional)
  - limit (default: 50)

Response (200):
{
  "success": true,
  "data": [
    {
      "id": "event_1",
      "title": "Campus Tour",
      "description": "Guided tour of campus",
      "location": "Main Auditorium",
      "locationId": "7",
      "startTime": "2026-04-10T14:00:00Z",
      "endTime": "2026-04-10T16:00:00Z",
      "capacity": 50,
      "attendees": 32
    }
  ]
}
```

---

### 6. Reviews (Future)

#### Get Location Reviews
```
GET /locations/{id}/reviews

Response (200):
{
  "success": true,
  "data": [
    {
      "id": "review_1",
      "locationId": "1",
      "userId": "user_123",
      "rating": 4.5,
      "title": "Great library!",
      "comment": "Very quiet and well-organized",
      "createdAt": "2026-04-01T10:00:00Z"
    }
  ],
  "averageRating": 4.6,
  "totalReviews": 23
}
```

#### Post Review
```
POST /locations/{id}/reviews

Body:
{
  "rating": 4.5,
  "title": "Great library!",
  "comment": "Very quiet and well-organized"
}

Response (201):
{
  "success": true,
  "data": {
    "id": "review_1",
    "rating": 4.5,
    "createdAt": "2026-04-03T12:00:00Z"
  }
}
```

---

## Error Responses

### Standard Error Format
```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable error message",
    "details": {}
  }
}
```

### Common Error Codes

| Code | HTTP Status | Description |
|------|------------|-------------|
| INVALID_REQUEST | 400 | Missing or invalid parameters |
| UNAUTHORIZED | 401 | Invalid or missing authentication token |
| FORBIDDEN | 403 | User lacks permission for operation |
| NOT_FOUND | 404 | Resource not found |
| CONFLICT | 409 | Resource already exists |
| RATE_LIMIT | 429 | Too many requests |
| INTERNAL_ERROR | 500 | Server error |

### Example Error Response
```json
{
  "success": false,
  "error": {
    "code": "NOT_FOUND",
    "message": "Location not found",
    "details": {
      "locationId": "999"
    }
  }
}
```

---

## Rate Limiting

```
Rate Limit: 100 requests per minute
Rate Limit: 10000 requests per day

Headers:
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1617552000
```

---

## Data Models

### Location Model
```dart
class CampusLocation {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final LocationType type;
  final String? imageUrl;
  final String? floorInfo;
  final List<String>? keywords;
  final Map<String, String>? openingHours;
  final String? phone;
  final String? email;
}

enum LocationType {
  classroom, office, library, cafeteria, restroom,
  parking, medical, laboratory, auditorium, gymnasium, other
}
```

### Route Model
```dart
class NavigationRoute {
  final String id;
  final String startLocationId;
  final String endLocationId;
  final List<RoutePoint> points;
  final double distanceInMeters;
  final int estimatedMinutes;
  final RouteType type;
}

class RoutePoint {
  final double latitude;
  final double longitude;
  final String? instruction;
  final int? stepNumber;
}

enum RouteType { indoor, outdoor, mixed }
```

### User Model
```dart
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final UserPreferences preferences;
  final List<String> favoriteLocationIds;
}

class UserPreferences {
  final bool voiceGuidance;
  final String language;
  final double speechRate;
  final bool offlineMapsEnabled;
}
```

---

## Authentication

### Token-Based Authentication
```
Header: Authorization: Bearer {token}
```

### Token Expiration
- Access Token: 1 hour
- Refresh Token: 30 days

### Refresh Token Endpoint
```
POST /auth/refresh

Body:
{
  "refreshToken": "refresh_token_here"
}

Response (200):
{
  "success": true,
  "data": {
    "accessToken": "new_token_here",
    "expiresIn": 3600
  }
}
```

---

## Pagination

### Query Parameters
```
- limit: number of items per page (default: 50, max: 100)
- offset: starting position (default: 0)
```

### Response Format
```json
{
  "success": true,
  "data": [...],
  "pagination": {
    "total": 500,
    "limit": 50,
    "offset": 0,
    "hasMore": true
  }
}
```

---

## Versioning

### API Versions
```
Current: v1
Future: v2, v3, etc.
```

### Deprecation Policy
- Minimum 6 months notice before deprecation
- Old versions supported for 12 months
- Warnings in response headers

---

## WebSocket (Real-time) - Future

### Connection
```
wss://api.uninav.solutions/ws?token={token}
```

### Events
```
{
  "type": "location_updated",
  "data": {
    "locationId": "1",
    "updates": {...}
  }
}
```

---

## SDK Implementation

### Example Usage (Future HTTP Client)
```dart
class LocationApiClient {
  final http.Client _httpClient;
  final String _baseUrl = 'https://api.uninav.solutions/v1';
  String? _token;

  Future<List<CampusLocation>> getLocations() async {
    final response = await _httpClient.get(
      Uri.parse('$_baseUrl/locations'),
      headers: {'Authorization': 'Bearer $_token'},
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List)
          .map((l) => CampusLocation.fromJson(l))
          .toList();
    }
    throw Exception('Failed to load locations');
  }
}
```

---

## Testing the API

### Using cURL
```bash
# Get all locations
curl -X GET https://api.uninav.solutions/v1/locations \
  -H "Authorization: Bearer YOUR_TOKEN"

# Calculate route
curl -X POST https://api.uninav.solutions/v1/routes/calculate \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "startLocationId": "1",
    "endLocationId": "2"
  }'
```

### Using Postman
- Import collection from `postman_collection.json`
- Set environment variables (token, baseUrl)
- Test endpoints with pre-built requests

---

## Changelog

### Version 1.0 (Current)
- Initial API design
- Location management
- Route calculation
- User authentication
- Favorites system

### Version 1.1 (Planned)
- Events integration
- Reviews system
- Real-time updates via WebSockets
- Analytics endpoints

### Version 2.0 (Future)
- AR navigation API
- Indoor positioning
- Social features
- Advanced analytics

---

**Last Updated:** 2026-04-03  
**API Version:** 1.0  
**Status:** Design Phase
