import 'dart:convert';

class LocationModel {
  final double latitude;
  final double longitude;
  final double altitude;
  final double accuracy;
  final double heading;
  final int? buildingFloor;
  final double speed;
  final double speedAccuracy;
  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.accuracy,
    required this.heading,
    this.buildingFloor,
    required this.speed,
    required this.speedAccuracy,
  });

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source));

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      altitude: map['altitude']?.toDouble() ?? 0.0,
      accuracy: map['accuracy']?.toDouble() ?? 0.0,
      heading: map['heading']?.toDouble() ?? 0.0,
      buildingFloor: map['buildingFloor']?.toInt(),
      speed: map['speed']?.toDouble() ?? 0.0,
      speedAccuracy: map['speedAccuracy']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'latitude': latitude});
    result.addAll({'longitude': longitude});
    result.addAll({'altitude': altitude});
    result.addAll({'accuracy': accuracy});
    result.addAll({'heading': heading});
    if (buildingFloor != null) {
      result.addAll({'buildingFloor': buildingFloor});
    }
    result.addAll({'speed': speed});
    result.addAll({'speedAccuracy': speedAccuracy});

    return result;
  }
}
