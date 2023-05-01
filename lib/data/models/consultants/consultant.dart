import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../utilities/extensions.dart';
import '../../enums/gender.dart';
import '../../enums/perview_status.dart';
import '../../enums/user_status.dart';
import '../../enums/user_type.dart';
import '../authentication/country.dart';
import '../authentication/nationality.dart';
import '../authentication/settings.dart';

class Consultant {
  int id;
  String uuid;
  String image;
  num walletBalance;
  Gender gender;
  Color color;
  PreviewStatus previewStatus;
  UserStatus status;
  UserType type;
  DateTime createdAt;
  String? email;
  int? countryId;
  int? nationalityId;
  int? cityId;
  int? countryTimeZoneId;
  int? languageId;
  int? currencyId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? previewName;
  String? phone;
  DateTime? lastLoginAt;
  Country? country;
  Nationality? nationality;
  Settings? settings;

  Consultant({
    required this.id,
    required this.uuid,
    required this.image,
    required this.walletBalance,
    required this.gender,
    required this.color,
    required this.previewStatus,
    required this.status,
    required this.type,
    required this.createdAt,
    this.email,
    this.countryId,
    this.nationalityId,
    this.cityId,
    this.countryTimeZoneId,
    this.languageId,
    this.currencyId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.previewName,
    this.phone,
    this.lastLoginAt,
    this.country,
    this.nationality,
    this.settings,
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
    String? email,
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
    String? phone,
    DateTime? lastLoginAt,
    Country? country,
    Nationality? nationality,
    Settings? settings,
  }) =>
      Consultant(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        image: image ?? this.image,
        walletBalance: walletBalance ?? this.walletBalance,
        gender: gender ?? this.gender,
        color: color ?? this.color,
        previewStatus: previewStatus ?? this.previewStatus,
        status: status ?? this.status,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        email: email ?? this.email,
        countryId: countryId ?? this.countryId,
        nationalityId: nationalityId ?? this.nationalityId,
        cityId: cityId ?? this.cityId,
        countryTimeZoneId: countryTimeZoneId ?? this.countryTimeZoneId,
        languageId: languageId ?? this.languageId,
        currencyId: currencyId ?? this.currencyId,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        previewName: previewName ?? this.previewName,
        phone: phone ?? this.phone,
        lastLoginAt: lastLoginAt ?? this.lastLoginAt,
        country: country ?? this.country,
        nationality: nationality ?? this.nationality,
        settings: settings ?? this.settings,
      );

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
      contract.phone: phone,
      contract.lastLoginAt: lastLoginAt?.toIso8601String(),
      contract.country: country?.toMap(),
      contract.nationality: nationality?.toMap(),
      contract.settings: settings?.toMap(),
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
      color: (map[contract.color] as String).color,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Consultant.fromJson(String source) =>
      Consultant.fromMap(json.decode(source));

  @override
  String toString() =>
      'Consultant(id: $id, uuid: $uuid, image: $image, walletBalance: $walletBalance, gender: $gender, color: $color, previewStatus: $previewStatus, status: $status, type: $type, createdAt: $createdAt, email: $email, countryId: $countryId, nationalityId: $nationalityId, cityId: $cityId, countryTimeZoneId: $countryTimeZoneId, languageId: $languageId, currencyId: $currencyId, firstName: $firstName, middleName: $middleName, lastName: $lastName, previewName: $previewName, phone: $phone, lastLoginAt: $lastLoginAt, country: $country, nationality: $nationality, settings: $settings)';

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
        other.email == email &&
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
        other.phone == phone &&
        other.lastLoginAt == lastLoginAt &&
        other.country == country &&
        other.nationality == nationality &&
        other.settings == settings;
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
      email.hashCode ^
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
      phone.hashCode ^
      lastLoginAt.hashCode ^
      country.hashCode ^
      nationality.hashCode ^
      settings.hashCode;
}

class ConsultantContract {
  final id = 'id';
  final uuid = 'uuid';
  final image = 'image';
  final walletBalance = 'wallet_balance';
  final gender = 'gender';
  final color = 'color';
  final previewStatus = 'preview_status';
  final status = 'status';
  final type = 'user_type';
  final createdAt = 'created_at';
  final email = 'email';
  final countryId = 'country_id';
  final nationalityId = 'nationality_id';
  final cityId = 'city_id';
  final countryTimeZoneId = 'country_time_zone_id';
  final languageId = 'language_id';
  final currencyId = 'currency_id';
  final firstName = 'first_name';
  final middleName = 'middle_name';
  final lastName = 'last_name';
  final previewName = 'preview_name';
  final phone = 'phone';
  final lastLoginAt = 'last_login_at';
  final country = 'country';
  final nationality = 'nationality';
  final settings = 'settings';
}
