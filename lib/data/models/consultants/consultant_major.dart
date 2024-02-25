import 'dart:convert';

import 'package:collection/collection.dart';

import '../../../core/models/base_entity.dart';
import '../../../core/models/base_model.dart';
import '../../../domain/entities/consultant_major_entity.dart';
import '../major.dart';
import 'major_verification_request.dart';

class ConsultantMajor extends BaseModel {
  num? id;
  String? uuid;
  num? userId;
  num? majorId;
  num? isVerified;
  num? isActive;
  num? isFree;
  num? yearsOfExperience;
  String? pricePerHour;
  String? terms;
  num? isNotificationsEnabled;
  num? isDefault;
  num? isAvailableForVerification;
  Major? major;
  MajorVerificationRequest? majorVerificationRequest;

  ConsultantMajor({
    this.id,
    this.uuid,
    this.userId,
    this.majorId,
    this.isVerified,
    this.isActive,
    this.isFree,
    this.yearsOfExperience,
    this.pricePerHour,
    this.terms,
    this.isNotificationsEnabled,
    this.isDefault,
    this.isAvailableForVerification,
    this.major,
    this.majorVerificationRequest,
  });

  @override
  String toString() {
    return 'ConsultantMajor(id: $id, uuid: $uuid, userId: $userId, majorId: $majorId, isVerified: $isVerified, isActive: $isActive, isFree: $isFree, yearsOfExperience: $yearsOfExperience, pricePerHour: $pricePerHour, terms: $terms, isNotificationsEnabled: $isNotificationsEnabled, isDefault: $isDefault, isAvailableForVerification: $isAvailableForVerification, major: $major, majorVerificationRequest: $majorVerificationRequest)';
  }

  factory ConsultantMajor.fromMap(Map<String, dynamic> data) {
    return ConsultantMajor(
      id: num.tryParse(data['id'].toString()),
      uuid: data['uuid']?.toString(),
      userId: num.tryParse(data['user_id'].toString()),
      majorId: num.tryParse(data['major_id'].toString()),
      isVerified: num.tryParse(data['is_verified'].toString()),
      isActive: num.tryParse(data['is_active'].toString()),
      isFree: num.tryParse(data['is_free'].toString()),
      yearsOfExperience: num.tryParse(data['years_of_experience'].toString()),
      pricePerHour: data['price_per_hour']?.toString(),
      terms: data['terms']?.toString(),
      isNotificationsEnabled:
          num.tryParse(data['is_notifications_enabled'].toString()),
      isDefault: num.tryParse(data['is_default'].toString()),
      isAvailableForVerification:
          num.tryParse(data['is_available_for_verification'].toString()),
      major: data['major'] == null
          ? null
          : Major.fromMap(Map<String, dynamic>.from(data['major'])),
      majorVerificationRequest: data['major_verification_request'] == null
          ? null
          : MajorVerificationRequest.fromMap(
              Map<String, dynamic>.from(data['major_verification_request'])),
    );
  }

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (userId != null) 'user_id': userId,
        if (majorId != null) 'major_id': majorId,
        if (isVerified != null) 'is_verified': isVerified,
        if (isActive != null) 'is_active': isActive,
        if (isFree != null) 'is_free': isFree,
        if (yearsOfExperience != null) 'years_of_experience': yearsOfExperience,
        if (pricePerHour != null) 'price_per_hour': pricePerHour,
        if (terms != null) 'terms': terms,
        if (isNotificationsEnabled != null)
          'is_notifications_enabled': isNotificationsEnabled,
        if (isDefault != null) 'is_default': isDefault,
        if (isAvailableForVerification != null)
          'is_available_for_verification': isAvailableForVerification,
        if (major != null) 'major': major?.toMap(),
        if (majorVerificationRequest != null)
          'major_verification_request': majorVerificationRequest?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ConsultantMajor].
  factory ConsultantMajor.fromJson(String data) {
    return ConsultantMajor.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ConsultantMajor] to a JSON string.
  String toJson() => json.encode(toMap());

  ConsultantMajor copyWith({
    num? id,
    String? uuid,
    num? userId,
    num? majorId,
    num? isVerified,
    num? isActive,
    num? isFree,
    num? yearsOfExperience,
    String? pricePerHour,
    String? terms,
    num? isNotificationsEnabled,
    num? isDefault,
    num? isAvailableForVerification,
    Major? major,
    MajorVerificationRequest? majorVerificationRequest,
  }) {
    return ConsultantMajor(
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
      isAvailableForVerification:
          isAvailableForVerification ?? this.isAvailableForVerification,
      major: major ?? this.major,
      majorVerificationRequest:
          majorVerificationRequest ?? this.majorVerificationRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ConsultantMajor) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
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
      isAvailableForVerification.hashCode ^
      major.hashCode ^
      majorVerificationRequest.hashCode;

  @override
  BaseEntity toEntity() {
    return ConsultantMajorEntity(
      id: id,
      uuid: uuid,
      userId: userId,
      majorId: majorId,
      isVerified: isVerified,
      isActive: isActive,
      isFree: isFree,
      yearsOfExperience: yearsOfExperience,
      pricePerHour: pricePerHour,
      terms: terms,
      isNotificationsEnabled: isNotificationsEnabled,
      isDefault: isDefault,
      isAvailableForVerification: isAvailableForVerification,
      major: major,
      majorVerificationRequest: majorVerificationRequest,
    );
  }
}
