import 'dart:convert';

import '../major.dart';

class DefaultMajor {
  final int id;
  final String uuid;
  final int userId;
  final int majorId;
  final bool isVerified;
  final bool isActive;
  final bool isFree;
  final int yearsOfExperience;
  final num pricePerHour;
  final String terms;
  final bool isNotificationsEnabled;
  final bool isDefault;
  final Major? major;

  DefaultMajor({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.majorId,
    required this.isVerified,
    required this.isActive,
    required this.isFree,
    required this.yearsOfExperience,
    required this.pricePerHour,
    required this.terms,
    required this.isNotificationsEnabled,
    required this.isDefault,
    this.major,
  });

  DefaultMajor copyWith({
    int? id,
    String? uuid,
    int? userId,
    int? majorId,
    bool? isVerified,
    bool? isActive,
    bool? isFree,
    int? yearsOfExperience,
    num? pricePerHour,
    String? terms,
    bool? isNotificationsEnabled,
    bool? isDefault,
    Major? major,
  }) {
    return DefaultMajor(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      majorId: majorId ?? this.majorId,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      isFree: isFree ?? this.isFree,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      terms: terms ?? this.terms,
      isNotificationsEnabled:
          isNotificationsEnabled ?? this.isNotificationsEnabled,
      isDefault: isDefault ?? this.isDefault,
      major: major ?? this.major,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _DefaultMajorContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.majorId: majorId,
      contract.isVerified: isVerified,
      contract.isActive: isActive,
      contract.isFree: isFree,
      contract.yearsOfExperience: yearsOfExperience,
      contract.pricePerHour: pricePerHour,
      contract.terms: terms,
      contract.isNotificationsEnabled: isNotificationsEnabled,
      contract.isDefault: isDefault,
      contract.major: major?.toMap(),
    };
  }

  factory DefaultMajor.fromMap(Map<String, dynamic> map) {
    final contract = _DefaultMajorContract();
    final major = map[contract.major];
    return DefaultMajor(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      majorId: map[contract.majorId]?.toInt() ?? 0,
      isVerified: map[contract.isVerified] != 0,
      isActive: map[contract.isActive] != 0,
      isFree: map[contract.isFree] != 0,
      yearsOfExperience: map[contract.yearsOfExperience]?.toInt() ?? 0,
      pricePerHour: num.parse(map[contract.pricePerHour]),
      terms: map[contract.terms] ?? '',
      isNotificationsEnabled: map[contract.isNotificationsEnabled] != 0,
      isDefault: map[contract.isDefault] != 0,
      major: major != null ? Major.fromMap(major) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DefaultMajor.fromJson(String source) =>
      DefaultMajor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DefaultMajor(id: $id, uuid: $uuid, userId: $userId, majorId: $majorId, isVerified: $isVerified, isActive: $isActive, isFree: $isFree, yearsOfExperience: $yearsOfExperience, pricePerHour: $pricePerHour, terms: $terms, isNotificationsEnabled: $isNotificationsEnabled, isDefault: $isDefault, major: $major)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DefaultMajor &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.majorId == majorId &&
        other.isVerified == isVerified &&
        other.isActive == isActive &&
        other.isFree == isFree &&
        other.yearsOfExperience == yearsOfExperience &&
        other.pricePerHour == pricePerHour &&
        other.terms == terms &&
        other.isNotificationsEnabled == isNotificationsEnabled &&
        other.isDefault == isDefault &&
        other.major == major;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        userId.hashCode ^
        majorId.hashCode ^
        isVerified.hashCode ^
        isActive.hashCode ^
        isFree.hashCode ^
        yearsOfExperience.hashCode ^
        pricePerHour.hashCode ^
        terms.hashCode ^
        isNotificationsEnabled.hashCode ^
        isDefault.hashCode ^
        major.hashCode;
  }
}

class _DefaultMajorContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final majorId = 'major_id';
  final isVerified = 'is_verified';
  final isActive = 'is_active';
  final isFree = 'is_free';
  final yearsOfExperience = 'years_of_experience';
  final pricePerHour = 'price_per_hour';
  final terms = 'terms';
  final isNotificationsEnabled = 'is_notifications_enabled';
  final isDefault = 'is_default';
  final major = 'major';
}
