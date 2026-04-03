import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../models/route_model.dart';
import '../services/location_service.dart';
import '../services/navigation_service.dart';

class NavigationProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final NavigationService _navigationService = NavigationService();

  List<CampusLocation> _allLocations = [];
  List<CampusLocation> _searchResults = [];
  NavigationRoute? _currentRoute;
  CampusLocation? _selectedStartLocation;
  CampusLocation? _selectedEndLocation;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<CampusLocation> get allLocations => _allLocations;
  List<CampusLocation> get searchResults => _searchResults;
  NavigationRoute? get currentRoute => _currentRoute;
  CampusLocation? get selectedStartLocation => _selectedStartLocation;
  CampusLocation? get selectedEndLocation => _selectedEndLocation;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Initialize locations
  Future<void> initializeLocations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allLocations = await _locationService.fetchAllLocations();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  // Search locations
  Future<void> searchLocations(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }
    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = _allLocations
          .where((location) {
            final nameMatch =
                location.name.toLowerCase().contains(query.toLowerCase());
            final keywordMatch = location.keywords != null &&
                location.keywords!.any((k) =>
                    k.toLowerCase().contains(query.toLowerCase()));
            return nameMatch || keywordMatch;
          })
          .toList();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Set start location
  void setStartLocation(CampusLocation location) {
    _selectedStartLocation = location;
    notifyListeners();
  }

  // Set end location
  void setEndLocation(CampusLocation location) {
    _selectedEndLocation = location;
    notifyListeners();
  }

  // Calculate route
  Future<void> calculateRoute() async {
    if (_selectedStartLocation == null || _selectedEndLocation == null) {
      _error = 'Please select both start and end locations';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentRoute = await _navigationService.calculateRoute(
        _selectedStartLocation!,
        _selectedEndLocation!,
      );
      _error = null;
    } catch (e) {
      _error = e.toString();
      _currentRoute = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear route
  void clearRoute() {
    _currentRoute = null;
    _selectedStartLocation = null;
    _selectedEndLocation = null;
    _searchResults = [];
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
