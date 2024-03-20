import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utilities/extensions.dart';
import '../../enums/gender.dart';
import '../../enums/perview_status.dart';
import '../../enums/user_status.dart';
import '../../enums/user_type.dart';
import '../authentication/country.dart';
import '../authentication/nationality.dart';
import '../authentication/settings.dart';
import '../account.dart';
import 'default_major.dart';

class Consultant extends Account {
  final String consultantPreviewName;
  final bool isFavourite;
  final DefaultMajor? major;
  final List<DefaultMajor>? majors;
  final String? username;
  final num? ratingAverage;

  Consultant({
    required super.id,
    required super.uuid,
    required super.image,
    required super.walletBalance,
    required super.gender,
    required super.color,
    required super.previewStatus,
    required super.status,
    required super.type,
    required super.createdAt,
    required this.consultantPreviewName,
    super.countryId,
    super.nationalityId,
    super.cityId,
    super.countryTimeZoneId,
    super.languageId,
    super.currencyId,
    super.firstName,
    super.middleName,
    super.lastName,
    super.previewName,
    super.email,
    super.phone,
    super.lastLoginAt,
    super.emailVerifiedAt,
    super.phoneVerifiedAt,
    super.country,
    super.nationality,
    super.settings,
    this.major,
    this.majors,
    required this.isFavourite,
    this.username,
    required this.ratingAverage,
  });

  Consultant copyWith({
    int? id,
    String? uuid,
    String? image,
    num? walletBalance,
    Gender? gender,
    Color? color,
    PreviewStatus? previewStatus,
    UserStatus? status,
    UserType? type,
    DateTime? createdAt,
    int? countryId,
    int? nationalityId,
    int? cityId,
    int? countryTimeZoneId,
    int? languageId,
    int? currencyId,
    String? firstName,
    String? middleName,
    String? lastName,
    String? previewName,
    String? consultantPreviewName,
    String? email,
    String? phone,
    DateTime? lastLoginAt,
    DateTime? emailVerifiedAt,
    DateTime? phoneVerifiedAt,
    Country? country,
    Nationality? nationality,
    Settings? settings,
    bool? isFavourite,
    DefaultMajor? major,
    List<DefaultMajor>? majors,
    String? username,
    num? ratingAverage,
  }) {
    return Consultant(
      id: id ?? super.id,
      uuid: uuid ?? super.uuid,
      image: image ?? super.image,
      walletBalance: walletBalance ?? super.walletBalance,
      color: color ?? super.color,
      gender: gender ?? super.gender,
      previewStatus: previewStatus ?? super.previewStatus,
      status: status ?? super.status,
      type: type ?? super.type,
      createdAt: createdAt ?? super.createdAt,
      countryId: countryId ?? super.countryId,
      nationalityId: nationalityId ?? super.nationalityId,
      cityId: cityId ?? super.cityId,
      countryTimeZoneId: countryTimeZoneId ?? super.countryTimeZoneId,
      languageId: languageId ?? super.languageId,
      currencyId: currencyId ?? super.currencyId,
      firstName: firstName ?? super.firstName,
      middleName: middleName ?? super.middleName,
      lastName: lastName ?? super.lastName,
      previewName: previewName ?? super.previewName,
      consultantPreviewName:
          consultantPreviewName ?? this.consultantPreviewName,
      email: email ?? super.email,
      phone: phone ?? super.phone,
      lastLoginAt: lastLoginAt ?? super.lastLoginAt,
      emailVerifiedAt: emailVerifiedAt ?? super.emailVerifiedAt,
      phoneVerifiedAt: phoneVerifiedAt ?? super.phoneVerifiedAt,
      country: country ?? super.country,
      nationality: nationality ?? super.nationality,
      settings: settings ?? super.settings,
      isFavourite: isFavourite ?? this.isFavourite,
      major: major ?? this.major,
      majors: majors ?? this.majors,
      username: username ?? this.username,
      ratingAverage: ratingAverage ?? this.ratingAverage,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final contract = ConsultantContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.image: image,
      contract.walletBalance: walletBalance,
      contract.gender: gender.toMap(),
      contract.color: color.value,
      contract.previewStatus: previewStatus.toMap(),
      contract.status: status.toMap(),
      contract.type: type.toMap(),
      contract.createdAt: createdAt.toIso8601String(),
      contract.email: email,
      contract.countryId: countryId,
      contract.nationalityId: nationalityId,
      contract.cityId: cityId,
      contract.countryTimeZoneId: countryTimeZoneId,
      contract.languageId: languageId,
      contract.currencyId: currencyId,
      contract.firstName: firstName,
      contract.middleName: middleName,
      contract.lastName: lastName,
      contract.previewName: previewName,
      contract.consultantPreviewName: consultantPreviewName,
      contract.phone: phone,
      contract.lastLoginAt: lastLoginAt?.toIso8601String(),
      contract.country: country?.toMap(),
      contract.nationality: nationality?.toMap(),
      contract.settings: settings?.toMap(),
      contract.emailVerifiedAt: emailVerifiedAt?.toIso8601String(),
      contract.phoneVerifiedAt: phoneVerifiedAt?.toIso8601String(),
      contract.isFavourite: isFavourite,
      contract.major: major?.toMap(),
      contract.majors: majors?.map((x) => x.toMap()).toList(),
      contract.username: username,
      contract.ratingAverage: ratingAverage.toString(),
    };
  }

  factory Consultant.fromMap(Map<String, dynamic> map) {
    final contract = ConsultantContract();

    return Consultant(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      image: map[contract.image] ?? '',
      walletBalance: num.tryParse(map[contract.walletBalance]) ?? 0,
      gender: (map[contract.gender] as int).genderFromMap(),
      color: (map[contract.color].toString()).color,
      previewStatus:
          (map[contract.previewStatus] as int).previewStatusFromMap(),
      status: (map[contract.status] as int).userStatusFromMap(),
      type: (map[contract.type] as int).userTypeFromMap(),
      createdAt: DateTime.parse(map[contract.createdAt]),
      email: map[contract.email],
      countryId: map[contract.countryId]?.toInt(),
      nationalityId: map[contract.nationalityId]?.toInt(),
      cityId: map[contract.cityId]?.toInt(),
      countryTimeZoneId: map[contract.countryTimeZoneId]?.toInt(),
      languageId: map[contract.languageId]?.toInt(),
      currencyId: map[contract.currencyId]?.toInt(),
      firstName: map[contract.firstName],
      middleName: map[contract.middleName],
      lastName: map[contract.lastName],
      previewName: map[contract.previewName],
      consultantPreviewName: map[contract.consultantPreviewName],
      phone: map[contract.phone],
      lastLoginAt: map[contract.lastLoginAt] != null
          ? DateTime.parse(map[contract.lastLoginAt])
          : null,
      country: map[contract.country] != null
          ? Country.fromMap(map[contract.country])
          : null,
      nationality: map[contract.nationality] != null
          ? Nationality.fromMap(map[contract.nationality])
          : null,
      settings: map[contract.settings] != null
          ? Settings.fromMap(map[contract.settings])
          : null,
      emailVerifiedAt: map[contract.emailVerifiedAt] != null
          ? DateTime.parse(map[contract.emailVerifiedAt])
          : null,
      phoneVerifiedAt: map[contract.phoneVerifiedAt] != null
          ? DateTime.parse(map[contract.phoneVerifiedAt])
          : null,
      isFavourite: map[contract.isFavourite] ?? false,
      major: map[contract.major] != null
          ? DefaultMajor.fromMap(map[contract.major])
          : null,
      majors: map[contract.majors] != null
          ? List<DefaultMajor>.from(
              map[contract.majors]?.map((x) => DefaultMajor.fromMap(x)))
          : null,
      username: map[contract.username],
      ratingAverage: map[contract.ratingAverage] != null
          ? num.tryParse(map[contract.ratingAverage]) ?? 0
          : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Consultant.fromJson(String source) =>
      Consultant.fromMap(json.decode(source));

  @override
  String toString() =>
      'Consultant(id: $id, uuid: $uuid, image: $image, walletBalance: $walletBalance, gender: $gender, color: $color, previewStatus: $previewStatus, status: $status, type: $type, createdAt: $createdAt, countryId: $countryId, nationalityId: $nationalityId, cityId: $cityId, countryTimeZoneId: $countryTimeZoneId, languageId: $languageId, currencyId: $currencyId, firstName: $firstName, middleName: $middleName, lastName: $lastName, previewName: $previewName, consultantPreviewName: $consultantPreviewName, email: $email, phone: $phone, lastLoginAt: $lastLoginAt, emailVerifiedAt: $emailVerifiedAt, phoneVerifiedAt: $phoneVerifiedAt, country: $country, nationality: $nationality, settings: $settings, isFavourite: $isFavourite, major: $major, majors: $majors, username: $username, ratingAverage: $ratingAverage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Consultant &&
        other.id == id &&
        other.uuid == uuid &&
        other.image == image &&
        other.walletBalance == walletBalance &&
        other.gender == gender &&
        other.color == color &&
        other.previewStatus == previewStatus &&
        other.status == status &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.countryId == countryId &&
        other.nationalityId == nationalityId &&
        other.cityId == cityId &&
        other.countryTimeZoneId == countryTimeZoneId &&
        other.languageId == languageId &&
        other.currencyId == currencyId &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.previewName == previewName &&
        other.consultantPreviewName == consultantPreviewName &&
        other.email == email &&
        other.phone == phone &&
        other.lastLoginAt == lastLoginAt &&
        other.emailVerifiedAt == emailVerifiedAt &&
        other.phoneVerifiedAt == phoneVerifiedAt &&
        other.country == country &&
        other.nationality == nationality &&
        other.settings == settings &&
        other.isFavourite == isFavourite &&
        other.major == major &&
        listEquals(other.majors, majors) &&
        other.username == username &&
        other.ratingAverage == ratingAverage;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      image.hashCode ^
      walletBalance.hashCode ^
      gender.hashCode ^
      color.hashCode ^
      previewStatus.hashCode ^
      status.hashCode ^
      type.hashCode ^
      createdAt.hashCode ^
      countryId.hashCode ^
      nationalityId.hashCode ^
      cityId.hashCode ^
      countryTimeZoneId.hashCode ^
      languageId.hashCode ^
      currencyId.hashCode ^
      firstName.hashCode ^
      middleName.hashCode ^
      lastName.hashCode ^
      previewName.hashCode ^
      consultantPreviewName.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      lastLoginAt.hashCode ^
      emailVerifiedAt.hashCode ^
      phoneVerifiedAt.hashCode ^
      country.hashCode ^
      nationality.hashCode ^
      settings.hashCode ^
      isFavourite.hashCode ^
      major.hashCode ^
      majors.hashCode ^
      username.hashCode ^
      ratingAverage.hashCode;
}

class ConsultantContract extends AccountContract {
  final consultantPreviewName = 'consultant_preview_name';
  final isFavourite = 'is_favourite';
  final major = 'default_major';
  final majors = 'majors';
  final username = 'consultant_user_name';
  final ratingAverage = 'rating_average';
}
