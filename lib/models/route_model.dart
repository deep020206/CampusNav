class NavigationRoute {
  final String id;
  final String startLocationId;
  final String endLocationId;
  final List<RoutePoint> points;
  final double distanceInMeters;
  final int estimatedMinutes;
  final RouteType type;

  NavigationRoute({
    required this.id,
    required this.startLocationId,
    required this.endLocationId,
    required this.points,
    required this.distanceInMeters,
    required this.estimatedMinutes,
    required this.type,
  });

  factory NavigationRoute.fromJson(Map<String, dynamic> json) {
    return NavigationRoute(
      id: json['id'],
      startLocationId: json['startLocationId'],
      endLocationId: json['endLocationId'],
      points: List<RoutePoint>.from(
        (json['points'] as List).map((p) => RoutePoint.fromJson(p)),
      ),
      distanceInMeters: json['distanceInMeters'],
      estimatedMinutes: json['estimatedMinutes'],
      type: RouteType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
    );
  }
}

class RoutePoint {
  final double latitude;
  final double longitude;
  final String? instruction;
  final int? stepNumber;

  RoutePoint({
    required this.latitude,
    required this.longitude,
    this.instruction,
    this.stepNumber,
  });

  factory RoutePoint.fromJson(Map<String, dynamic> json) {
    return RoutePoint(
      latitude: json['latitude'],
      longitude: json['longitude'],
      instruction: json['instruction'],
      stepNumber: json['stepNumber'],
    );
  }
}

enum RouteType {
  indoor,
  outdoor,
  mixed
}
