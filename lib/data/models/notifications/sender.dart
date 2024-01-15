import 'dart:convert';

import '../../../utilities/extensions.dart';

class NotificationSender {
  final int id;
  final String uuid;
  final int languageId;
  final int nationalityId;
  final int countryTimeZoneId;
  final String name;
  final String email;
  final String phone;
  final DateTime birthDate;
  final bool isActive;
  final DateTime lastLoginAt;
  final DateTime createdAt;
  final String? image;
  final DateTime? deletedAt;
  final DateTime? updatedAt;

  NotificationSender({
    required this.id,
    required this.uuid,
    required this.languageId,
    required this.nationalityId,
    required this.countryTimeZoneId,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.isActive,
    required this.lastLoginAt,
    required this.createdAt,
    this.image,
    this.deletedAt,
    this.updatedAt,
  });

  NotificationSender copyWith({
    int? id,
    String? uuid,
    int? languageId,
    int? nationalityId,
    int? countryTimeZoneId,
    String? name,
    String? email,
    String? phone,
    DateTime? birthDate,
    bool? isActive,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    String? image,
    DateTime? deletedAt,
    DateTime? updatedAt,
  }) {
    return NotificationSender(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      languageId: languageId ?? this.languageId,
      nationalityId: nationalityId ?? this.nationalityId,
      countryTimeZoneId: countryTimeZoneId ?? this.countryTimeZoneId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      isActive: isActive ?? this.isActive,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
      deletedAt: deletedAt ?? this.deletedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _NotificationSender();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.languageId: languageId,
      contract.nationalityId: nationalityId,
      contract.countryTimeZoneId: countryTimeZoneId,
      contract.name: name,
      contract.email: email,
      contract.phone: phone,
      contract.birthDate: birthDate.toIso8601String(),
      contract.isActive: isActive,
      contract.lastLoginAt: lastLoginAt.toIso8601String(),
      contract.createdAt: createdAt.toIso8601String(),
      contract.image: image,
      contract.deletedAt: deletedAt?.toIso8601String(),
      contract.updatedAt: updatedAt?.toIso8601String(),
    };
  }

  factory NotificationSender.fromMap(Map<String, dynamic> map) {
    final contract = _NotificationSender();
    return NotificationSender(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      languageId: map[contract.languageId]?.toInt() ?? 0,
      nationalityId: map[contract.nationalityId]?.toInt() ?? 0,
      countryTimeZoneId: map[contract.countryTimeZoneId]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
      email: map[contract.email] ?? '',
      phone: map[contract.phone] ?? '',
      birthDate: (map[contract.birthDate] as String).date,
      isActive: map[contract.isActive] ?? false,
      lastLoginAt: DateTime.parse(map[contract.lastLoginAt]),
      createdAt: DateTime.parse(map[contract.createdAt]),
      image: map[contract.image],
      deletedAt: map[contract.deletedAt] != null
          ? DateTime.parse(map[contract.deletedAt])
          : null,
      updatedAt: map[contract.updatedAt] != null
          ? DateTime.parse(map[contract.updatedAt])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationSender.fromJson(String source) =>
      NotificationSender.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationSender(id: $id, uuid: $uuid, languageId: $languageId, nationalityId: $nationalityId, countryTimeZoneId: $countryTimeZoneId, name: $name, email: $email, phone: $phone, birthDate: $birthDate, isActive: $isActive, lastLoginAt: $lastLoginAt, createdAt: $createdAt, image: $image, deletedAt: $deletedAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationSender &&
        other.id == id &&
        other.uuid == uuid &&
        other.languageId == languageId &&
        other.nationalityId == nationalityId &&
        other.countryTimeZoneId == countryTimeZoneId &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.birthDate == birthDate &&
        other.isActive == isActive &&
        other.lastLoginAt == lastLoginAt &&
        other.createdAt == createdAt &&
        other.image == image &&
        other.deletedAt == deletedAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        languageId.hashCode ^
        nationalityId.hashCode ^
        countryTimeZoneId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        birthDate.hashCode ^
        isActive.hashCode ^
        lastLoginAt.hashCode ^
        createdAt.hashCode ^
        image.hashCode ^
        deletedAt.hashCode ^
        updatedAt.hashCode;
  }
}

class _NotificationSender {
  final id = 'id';
  final uuid = 'uuid';
  final languageId = 'language_id';
  final nationalityId = 'nationality_id';
  final countryTimeZoneId = 'country_time_zone_id';
  final name = 'name';
  final image = 'image';
  final email = 'email';
  final phone = 'phone';
  final birthDate = 'birth_date';
  final isActive = 'is_active';
  final lastLoginAt = 'last_login_at';
  final deletedAt = 'deleted_at';
  final createdAt = 'created_at';
  final updatedAt = 'updated_at';
}
