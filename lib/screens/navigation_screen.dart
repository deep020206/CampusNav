import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/location_model.dart';
import '../providers/navigation_provider.dart';
import '../services/navigation_service.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final NavigationService _navigationService = NavigationService();
  late TextEditingController _startSearchController;
  late TextEditingController _endSearchController;
  bool _showStartSearch = false;
  bool _showEndSearch = false;

  @override
  void initState() {
    super.initState();
    _startSearchController = TextEditingController();
    _endSearchController = TextEditingController();
  }

  @override
  void dispose() {
    _startSearchController.dispose();
    _endSearchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Modern Header
            _buildModernHeader(context),
            const SizedBox(height: 24),
            // Route Display
            Consumer<NavigationProvider>(
              builder: (context, provider, _) {
                if (provider.currentRoute != null) {
                  return _buildRouteDetails(context, provider);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Navigation',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Plan Your Route',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 24),
            _buildRouteSelection(context),
          ],
        ),
      ),
    );
  }
  Widget _buildRouteSelection(BuildContext context) {
    return Column(
      children: [
        // Start Location
        Consumer<NavigationProvider>(
          builder: (context, provider, _) {
            return _buildLocationSelector(
              label: 'From',
              selectedLocation: provider.selectedStartLocation,
              showSearch: _showStartSearch,
              searchController: _startSearchController,
              onTap: () {
                setState(() {
                  _showStartSearch = !_showStartSearch;
                  _showEndSearch = false;
                });
              },
              onLocationSelected: (location) {
                provider.setStartLocation(location);
                setState(() {
                  _showStartSearch = false;
                  _startSearchController.clear();
                });
              },
              onSearchChanged: (value) {
                provider.searchLocations(value);
              },
            );
          },
        ),
        const SizedBox(height: 16),
        // Swap Button
        _buildSwapButton(context),
        const SizedBox(height: 16),
        // End Location
        Consumer<NavigationProvider>(
          builder: (context, provider, _) {
            return _buildLocationSelector(
              label: 'To',
              selectedLocation: provider.selectedEndLocation,
              showSearch: _showEndSearch,
              searchController: _endSearchController,
              onTap: () {
                setState(() {
                  _showEndSearch = !_showEndSearch;
                  _showStartSearch = false;
                });
              },
              onLocationSelected: (location) {
                provider.setEndLocation(location);
                setState(() {
                  _showEndSearch = false;
                  _endSearchController.clear();
                });
              },
              onSearchChanged: (value) {
                provider.searchLocations(value);
              },
            );
          },
        ),
        const SizedBox(height: 24),
        // Calculate Route Button
        Consumer<NavigationProvider>(
          builder: (context, provider, _) {
            return SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed:
                    (provider.selectedStartLocation != null &&
                            provider.selectedEndLocation != null)
                        ? () {
                            provider.calculateRoute();
                          }
                        : null,
                icon: const Icon(Icons.directions),
                label: const Text(
                  'Calculate Route',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6A1B9A),
                  disabledBackgroundColor: Colors.white24,
                  disabledForegroundColor: Colors.white54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSwapButton(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.swap_vert,
            color: Color(0xFF6A1B9A),
            size: 24,
          ),
          onPressed: () {
            context.read<NavigationProvider>().clearRoute();
          },
        ),
      ),
    );
  }
  Widget _buildLocationSelector({
    required String label,
    required CampusLocation? selectedLocation,
    required bool showSearch,
    required TextEditingController searchController,
    required VoidCallback onTap,
    required Function(CampusLocation) onLocationSelected,
    required Function(String) onSearchChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),                boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: const Color(0xFF6A1B9A),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedLocation?.name ?? 'Select location',
                    style: TextStyle(
                      fontSize: 15,
                      color: selectedLocation != null
                          ? Colors.black87
                          : Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  showSearch ? Icons.expand_less : Icons.expand_more,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showSearch) ...[
          const SizedBox(height: 10),
          TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search locations...',
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF6A1B9A),
                size: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 10),
          Consumer<NavigationProvider>(
            builder: (context, provider, _) {
              final locations = provider.searchResults.isNotEmpty
                  ? provider.searchResults
                  : provider.allLocations;

              return Container(
                constraints: const BoxConstraints(maxHeight: 220),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: locations.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final location = locations[index];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          onLocationSelected(location);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      location.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      location.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ],
    );
  }
  Widget _buildRouteDetails(BuildContext context, NavigationProvider provider) {
    final route = provider.currentRoute!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Route Summary Card
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [                BoxShadow(
                  color: const Color(0xFF6A1B9A).withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Route Found',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Route Summary',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRouteInfo(
                      icon: Icons.straighten,
                      label: 'Distance',
                      value: _navigationService
                          .getFormattedDistance(route.distanceInMeters),
                      color: Colors.white,
                    ),
                    _buildRouteInfo(
                      icon: Icons.schedule,
                      label: 'Time',
                      value: _navigationService
                          .getFormattedTime(route.estimatedMinutes),
                      color: Colors.white,
                    ),
                    _buildRouteInfo(
                      icon: Icons.directions_walk,
                      label: 'Steps',
                      value: route.points.length.toString(),
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          // Step by Step Directions
          const Text(
            'Directions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            itemCount: route.points.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final point = route.points[index];
              if (point.instruction == null) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${point.stepNumber}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              point.instruction!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${(index + 1) * 10}m',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implement full screen map view
                  },
                  icon: const Icon(Icons.map, size: 20),
                  label: const Text(
                    'View Map',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    provider.clearRoute();
                  },
                  icon: const Icon(Icons.clear, size: 20),
                  label: const Text(
                    'Clear',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6A1B9A),
                    side: const BorderSide(
                      color: Color(0xFF6A1B9A),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildRouteInfo({
    required IconData icon,
    required String label,
    required String value,
    Color color = const Color(0xFF6A1B9A),
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          label,          style: TextStyle(
            fontSize: 12,
            color: color.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
