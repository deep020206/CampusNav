import '../models/location_model.dart';

class LocationService {
  // Mock data - In production, this would fetch from an API or database
  static final List<CampusLocation> _mockLocations = [
    CampusLocation(
      id: '1',
      name: 'Building A - Classroom 101',
      description: 'Main classroom in Building A, 1st Floor',
      latitude: 37.7749,
      longitude: -122.4194,
      type: LocationType.classroom,
      floorInfo: 'Floor 1',
      keywords: ['classroom', 'lecture', 'room 101'],
    ),
    CampusLocation(
      id: '2',
      name: 'Central Library',
      description: 'Main library with 5 floors',
      latitude: 37.7755,
      longitude: -122.4180,
      type: LocationType.library,
      floorInfo: 'Floors 1-5',
      keywords: ['library', 'books', 'study'],
    ),
    CampusLocation(
      id: '3',
      name: 'Student Cafeteria',
      description: 'Main cafeteria for students',
      latitude: 37.7760,
      longitude: -122.4175,
      type: LocationType.cafeteria,
      keywords: ['cafeteria', 'food', 'dining'],
    ),
    CampusLocation(
      id: '4',
      name: 'Computer Lab',
      description: 'Advanced computer laboratory',
      latitude: 37.7745,
      longitude: -122.4190,
      type: LocationType.laboratory,
      floorInfo: 'Floor 2',
      keywords: ['lab', 'computer', 'technology'],
    ),
    CampusLocation(
      id: '5',
      name: 'Health Center',
      description: 'Medical facilities and health center',
      latitude: 37.7750,
      longitude: -122.4185,
      type: LocationType.medical,
      keywords: ['medical', 'health', 'clinic'],
    ),
    CampusLocation(
      id: '6',
      name: 'Administration Office',
      description: 'Main administration office',
      latitude: 37.7755,
      longitude: -122.4200,
      type: LocationType.office,
      floorInfo: 'Floor 3',
      keywords: ['admin', 'office', 'registration'],
    ),
    CampusLocation(
      id: '7',
      name: 'Main Auditorium',
      description: 'Large auditorium for events',
      latitude: 37.7765,
      longitude: -122.4165,
      type: LocationType.auditorium,
      keywords: ['auditorium', 'event', 'hall'],
    ),
    CampusLocation(
      id: '8',
      name: 'Sports Complex',
      description: 'Gymnasium and sports facilities',
      latitude: 37.7740,
      longitude: -122.4195,
      type: LocationType.gymnasium,
      keywords: ['gym', 'sports', 'fitness'],
    ),
    CampusLocation(
      id: '9',
      name: 'Parking Lot A',
      description: 'Main parking area',
      latitude: 37.7730,
      longitude: -122.4205,
      type: LocationType.parking,
      keywords: ['parking', 'lot', 'vehicle'],
    ),
    CampusLocation(
      id: '10',
      name: 'Restrooms - Building B',
      description: 'Public restrooms in Building B',
      latitude: 37.7758,
      longitude: -122.4172,
      type: LocationType.restroom,
      keywords: ['restroom', 'bathroom', 'toilet'],
    ),
  ];

  Future<List<CampusLocation>> fetchAllLocations() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockLocations;
  }

  Future<CampusLocation?> getLocationById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _mockLocations.firstWhere((location) => location.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<CampusLocation>> searchLocations(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final lowerQuery = query.toLowerCase();
    return _mockLocations
        .where((location) =>
            location.name.toLowerCase().contains(lowerQuery) ||
            location.description.toLowerCase().contains(lowerQuery) ||
            (location.keywords?.any((k) => k.toLowerCase().contains(lowerQuery)) ??
                false))
        .toList();
  }

  Future<List<CampusLocation>> getLocationsByType(LocationType type) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockLocations.where((location) => location.type == type).toList();
  }
}
