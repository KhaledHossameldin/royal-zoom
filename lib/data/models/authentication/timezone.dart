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
  }) =>
      Timezone(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        countryId: countryId ?? this.countryId,
        timezone: timezone ?? this.timezone,
        offset: offset ?? this.offset,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toMap() {
    final contract = _TimezoneContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.countryId: countryId,
      contract.timezone: timezone,
      contract.offset: offset.timezoneOffset,
      contract.createdAt: createdAt.toIso8601String(),
    };
  }

  factory Timezone.fromMap(Map<String, dynamic> map) {
    final contract = _TimezoneContract();

    return Timezone(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      countryId: map[contract.countryId]?.toInt() ?? 0,
      timezone: map[contract.timezone] ?? '',
      offset: (map[contract.offset].toString()).timezoneOffset,
      createdAt: DateTime.parse(map[contract.createdAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Timezone.fromJson(String source) =>
      Timezone.fromMap(json.decode(source));

  @override
  String toString() =>
      'Timezone(id: $id, uuid: $uuid, countryId: $countryId, timezone: $timezone, offset: $offset, createdAt: $createdAt)';

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
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      countryId.hashCode ^
      timezone.hashCode ^
      offset.hashCode ^
      createdAt.hashCode;
}

class _TimezoneContract {
  final id = 'id';
  final uuid = 'uuid';
  final countryId = 'country_id';
  final timezone = 'timezone';
  final offset = 'offset';
  final createdAt = 'created_at';
}
