import 'package:flutter/material.dart';
import '../models/location_model.dart';

class LocationsListScreen extends StatelessWidget {
  final LocationType? locationType;

  const LocationsListScreen({super.key, this.locationType});

  String get _title {
    if (locationType == null) return 'All Locations';
    final name = locationType.toString().split('.').last;
    return '${name[0].toUpperCase()}${name.substring(1)}s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: const Center(child: Text('No locations available.')),
    );
  }
}
