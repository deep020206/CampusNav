import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/location_model.dart';
import '../providers/navigation_provider.dart';

class LocationDetailsScreen extends StatelessWidget {
  final CampusLocation location;

  const LocationDetailsScreen({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Header
            _buildLocationHeader(context),
            const SizedBox(height: 20),
            // Information
            _buildInformation(context),
            const SizedBox(height: 20),
            // Navigation Button
            _buildNavigationButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              _getLocationIcon(location.type),
              size: 40,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            location.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            location.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          if (location.floorInfo != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.layers, color: Colors.deepPurple, size: 18),
                const SizedBox(width: 8),
                Text(
                  location.floorInfo!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            icon: Icons.location_on,
            label: 'Location Type',
            value: _getLocationTypeName(location.type),
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            icon: Icons.gps_fixed,
            label: 'Coordinates',
            value:
                '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}',
          ),
          if (location.keywords != null && location.keywords!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoItem(
              icon: Icons.label,
              label: 'Tags',
              value: location.keywords!.join(', '),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.deepPurple, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: () {
            context.read<NavigationProvider>().setEndLocation(location);
            Navigator.pushNamed(context, '/navigation');
          },
          icon: const Icon(Icons.directions),
          label: const Text(
            'Navigate to Here',
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getLocationIcon(LocationType type) {
    return switch (type) {
      LocationType.classroom => Icons.school,
      LocationType.office => Icons.business,
      LocationType.library => Icons.library_books,
      LocationType.cafeteria => Icons.restaurant,
      LocationType.restroom => Icons.wc,
      LocationType.parking => Icons.directions_car,
      LocationType.medical => Icons.local_hospital,
      LocationType.laboratory => Icons.science,
      LocationType.auditorium => Icons.event,
      LocationType.gymnasium => Icons.fitness_center,
      LocationType.other => Icons.location_on,
    };
  }

  String _getLocationTypeName(LocationType type) {
    return type.toString().split('.').last.toUpperCase();
  }
}
