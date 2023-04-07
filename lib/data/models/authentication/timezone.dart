import 'dart:convert';

import '../../../utilities/extensions.dart';

class Timezone {
  int id;
  String uuid;
  int countryId;
  String timezone;
  Duration offset;
  DateTime createdAt;

  Timezone({
    required this.id,
    required this.uuid,
    required this.countryId,
    required this.timezone,
    required this.offset,
    required this.createdAt,
  });

  Timezone copyWith({
    int? id,
    String? uuid,
    int? countryId,
    String? timezone,
    Duration? offset,
    DateTime? createdAt,
  }) {
    return Timezone(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      countryId: countryId ?? this.countryId,
      timezone: timezone ?? this.timezone,
      offset: offset ?? this.offset,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _TimezoneContract.id: id,
      _TimezoneContract.uuid: uuid,
      _TimezoneContract.countryId: countryId,
      _TimezoneContract.timezone: timezone,
      _TimezoneContract.offset: offset.timezoneOffset,
      _TimezoneContract.createdAt: createdAt.toIso8601String(),
    };
  }

  factory Timezone.fromMap(Map<String, dynamic> map) {
    return Timezone(
      id: map[_TimezoneContract.id]?.toInt() ?? 0,
      uuid: map[_TimezoneContract.uuid] ?? '',
      countryId: map[_TimezoneContract.countryId]?.toInt() ?? 0,
      timezone: map[_TimezoneContract.timezone] ?? '',
      offset: (map[_TimezoneContract.offset] as String).timezoneOffset,
      createdAt: DateTime.parse(map[_TimezoneContract.createdAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Timezone.fromJson(String source) =>
      Timezone.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Timezone(id: $id, uuid: $uuid, countryId: $countryId, timezone: $timezone, offset: $offset, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Timezone &&
        other.id == id &&
        other.uuid == uuid &&
        other.countryId == countryId &&
        other.timezone == timezone &&
        other.offset == offset &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        countryId.hashCode ^
        timezone.hashCode ^
        offset.hashCode ^
        createdAt.hashCode;
  }
}

class _TimezoneContract {
  static const id = 'id';
  static const uuid = 'uuid';
  static const countryId = 'country_id';
  static const timezone = 'timezone';
  static const offset = 'offset';
  static const createdAt = 'created_at';
}
