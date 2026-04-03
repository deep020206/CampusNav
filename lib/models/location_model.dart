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

  CampusLocation({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.type,
    this.imageUrl,
    this.floorInfo,
    this.keywords,
  });

  factory CampusLocation.fromJson(Map<String, dynamic> json) {
    return CampusLocation(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      type: LocationType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      imageUrl: json['imageUrl'],
      floorInfo: json['floorInfo'],
      keywords: List<String>.from(json['keywords'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'type': type.toString().split('.').last,
      'imageUrl': imageUrl,
      'floorInfo': floorInfo,
      'keywords': keywords,
    };
  }
}

enum LocationType {
  classroom,
  office,
  library,
  cafeteria,
  restroom,
  parking,
  medical,
  laboratory,
  auditorium,
  gymnasium,
  other
}
