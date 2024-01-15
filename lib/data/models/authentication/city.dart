import 'dart:convert';

import '../../../utilities/extensions.dart';

class City {
  int id;
  String uuid;
  String name;
  int countryId;
  double latitude;
  double longitude;
  bool isActive;
  DateTime createdAt;

  City({
    required this.id,
    required this.uuid,
    required this.name,
    required this.countryId,
    required this.latitude,
    required this.longitude,
    required this.isActive,
    required this.createdAt,
  });

  City copyWith({
    int? id,
    String? uuid,
    String? name,
    int? countryId,
    double? latitude,
    double? longitude,
    bool? isActive,
    DateTime? createdAt,
  }) =>
      City(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        countryId: countryId ?? this.countryId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toMap() {
    final contract = _CityContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.name: name,
      contract.countryId: countryId,
      contract.latitude: latitude.toString(),
      contract.longitude: longitude.toString(),
      contract.isActive: isActive.toInt,
      contract.createdAt: createdAt.toIso8601String(),
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    final contract = _CityContract();

    return City(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      name: map[contract.name] ?? '',
      countryId: map[contract.countryId]?.toInt() ?? 0,
      latitude: double.tryParse(map[contract.latitude]) ?? 0.0,
      longitude: double.tryParse(map[contract.longitude]) ?? 0.0,
      isActive: map[contract.isActive] != 0,
      createdAt: DateTime.parse(map[contract.createdAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));

  @override
  String toString() =>
      'City(id: $id, uuid: $uuid, name: $name, countryId: $countryId, latitude: $latitude, longitude: $longitude, isActive: $isActive, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is City &&
        other.id == id &&
        other.uuid == uuid &&
        other.name == name &&
        other.countryId == countryId &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.isActive == isActive &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      name.hashCode ^
      countryId.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode;
}

class _CityContract {
  final id = 'id';
  final uuid = 'uuid';
  final name = 'name';
  final countryId = 'country_id';
  final latitude = 'latitude';
  final longitude = 'longitude';
  final isActive = 'is_active';
  final createdAt = 'created_at';
}
