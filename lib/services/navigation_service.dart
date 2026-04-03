import 'dart:math';
import '../models/location_model.dart';
import '../models/route_model.dart';

class NavigationService {
  Future<NavigationRoute> calculateRoute(
    CampusLocation start,
    CampusLocation end,
  ) async {
    // Simulate route calculation
    await Future.delayed(const Duration(milliseconds: 800));

    final distance = _calculateDistance(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );

    final points = _generateRoutePoints(start, end);
    final estimatedTime = (distance / 1.4).toInt(); // ~1.4 m/s walking speed

    return NavigationRoute(
      id: '${start.id}_${end.id}_${DateTime.now().millisecondsSinceEpoch}',
      startLocationId: start.id,
      endLocationId: end.id,
      points: points,
      distanceInMeters: distance,
      estimatedMinutes: estimatedTime,
      type: RouteType.mixed,
    );
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadiusM = 6371000;
    final dLat = _toRad(lat2 - lat1);
    final dLon = _toRad(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRad(lat1)) *
            cos(_toRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusM * c;
  }

  double _toRad(double deg) {
    return deg * (pi / 180.0);
  }

  List<RoutePoint> _generateRoutePoints(
    CampusLocation start,
    CampusLocation end,
  ) {
    final points = <RoutePoint>[];
    const steps = 10;

    for (int i = 0; i <= steps; i++) {
      final ratio = i / steps;
      final lat = start.latitude + (end.latitude - start.latitude) * ratio;
      final lon = start.longitude + (end.longitude - start.longitude) * ratio;

      String? instruction;
      if (i == 0) {
        instruction = 'Start at ${start.name}';
      } else if (i == steps) {
        instruction = 'Arrive at ${end.name}';
      } else if (i == steps ~/ 2) {
        instruction = 'Continue straight';
      }

      points.add(
        RoutePoint(
          latitude: lat,
          longitude: lon,
          instruction: instruction,
          stepNumber: i,
        ),
      );
    }

    return points;
  }

  String getFormattedDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)} m';
    } else {
      return '${(meters / 1000).toStringAsFixed(2)} km';
    }
  }

  String getFormattedTime(int minutes) {
    if (minutes < 60) {
      return '$minutes min';
    } else {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      return '${hours}h ${mins}m';
    }
  }
}
