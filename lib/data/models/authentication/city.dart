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
  }) {
    return City(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      countryId: countryId ?? this.countryId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _CityContract.id: id,
      _CityContract.uuid: uuid,
      _CityContract.name: name,
      _CityContract.countryId: countryId,
      _CityContract.latitude: latitude.toString(),
      _CityContract.longitude: longitude.toString(),
      _CityContract.isActive: isActive.toInt,
      _CityContract.createdAt: createdAt.toIso8601String(),
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map[_CityContract.id]?.toInt() ?? 0,
      uuid: map[_CityContract.uuid] ?? '',
      name: map[_CityContract.name] ?? '',
      countryId: map[_CityContract.countryId]?.toInt() ?? 0,
      latitude: double.tryParse(map[_CityContract.latitude]) ?? 0.0,
      longitude: double.tryParse(map[_CityContract.longitude]) ?? 0.0,
      isActive: map[_CityContract.isActive] != 0,
      createdAt: DateTime.parse(map[_CityContract.createdAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));

  @override
  String toString() {
    return 'City(id: $id, uuid: $uuid, name: $name, countryId: $countryId, latitude: $latitude, longitude: $longitude, isActive: $isActive, createdAt: $createdAt)';
  }

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
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        name.hashCode ^
        countryId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        isActive.hashCode ^
        createdAt.hashCode;
  }
}

class _CityContract {
  static const id = 'id';
  static const uuid = 'uuid';
  static const name = 'name';
  static const countryId = 'country_id';
  static const latitude = 'latitude';
  static const longitude = 'longitude';
  static const isActive = 'is_active';
  static const createdAt = 'created_at';
}
