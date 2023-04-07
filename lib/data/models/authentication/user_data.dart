import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../utilities/extensions.dart';
import '../../enums/gender.dart';
import '../../enums/perview_status.dart';
import '../../enums/user_status.dart';
import '../../enums/user_type.dart';
import 'city.dart';
import 'country.dart';
import 'currency.dart';
import 'language.dart';
import 'nationality.dart';
import 'settings.dart';
import 'timezone.dart';

class UserData {
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
  City? city;
  Nationality? nationality;
  Language? language;
  Timezone? timezone;
  Currency? currency;
  Settings? settings;

  UserData({
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
    this.city,
    this.nationality,
    this.language,
    this.timezone,
    this.currency,
    this.settings,
  });

  UserData copyWith({
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
    City? city,
    Nationality? nationality,
    Language? language,
    Timezone? timezone,
    Currency? currency,
    Settings? settings,
  }) {
    return UserData(
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
      city: city ?? this.city,
      nationality: nationality ?? this.nationality,
      language: language ?? this.language,
      timezone: timezone ?? this.timezone,
      currency: currency ?? this.currency,
      settings: settings ?? this.settings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _UserDataContract.id: id,
      _UserDataContract.uuid: uuid,
      _UserDataContract.image: image,
      _UserDataContract.walletBalance: walletBalance.toString(),
      _UserDataContract.gender: gender.toMap(),
      _UserDataContract.color: color.hex,
      _UserDataContract.previewStatus: previewStatus.toMap(),
      _UserDataContract.status: status.toMap(),
      _UserDataContract.type: type.toMap(),
      _UserDataContract.createdAt: createdAt.toIso8601String(),
      _UserDataContract.email: email,
      _UserDataContract.countryId: countryId,
      _UserDataContract.nationalityId: nationalityId,
      _UserDataContract.cityId: cityId,
      _UserDataContract.countryTimeZoneId: countryTimeZoneId,
      _UserDataContract.languageId: languageId,
      _UserDataContract.currencyId: currencyId,
      _UserDataContract.firstName: firstName,
      _UserDataContract.middleName: middleName,
      _UserDataContract.lastName: lastName,
      _UserDataContract.previewName: previewName,
      _UserDataContract.phone: phone,
      _UserDataContract.lastLoginAt: lastLoginAt?.toIso8601String(),
      _UserDataContract.country: country?.toMap(),
      _UserDataContract.city: city?.toMap(),
      _UserDataContract.nationality: nationality?.toMap(),
      _UserDataContract.language: language?.toMap(),
      _UserDataContract.timezone: timezone?.toMap(),
      _UserDataContract.currency: currency?.toMap(),
      _UserDataContract.settings: settings?.toMap(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map[_UserDataContract.id]?.toInt() ?? 0,
      uuid: map[_UserDataContract.uuid] ?? '',
      image: map[_UserDataContract.image] ?? '',
      walletBalance: num.tryParse(map[_UserDataContract.walletBalance]) ?? 0,
      gender: (map[_UserDataContract.gender] as int).genderFromMap(),
      color: (map[_UserDataContract.color] as String).color,
      previewStatus:
          (map[_UserDataContract.previewStatus] as int).previewStatusFromMap(),
      status: (map[_UserDataContract.status] as int).userStatusFromMap(),
      type: (map[_UserDataContract.type] as int).userTypeFromMap(),
      createdAt: DateTime.parse(map[_UserDataContract.createdAt]),
      email: map[_UserDataContract.email] ?? '',
      countryId: map[_UserDataContract.countryId]?.toInt(),
      nationalityId: map[_UserDataContract.nationalityId]?.toInt(),
      cityId: map[_UserDataContract.cityId]?.toInt(),
      countryTimeZoneId: map[_UserDataContract.countryTimeZoneId]?.toInt(),
      languageId: map[_UserDataContract.languageId]?.toInt(),
      currencyId: map[_UserDataContract.currencyId]?.toInt(),
      firstName: map[_UserDataContract.firstName],
      middleName: map[_UserDataContract.middleName],
      lastName: map[_UserDataContract.lastName],
      previewName: map[_UserDataContract.previewName],
      phone: map[_UserDataContract.phone],
      lastLoginAt: map[_UserDataContract.lastLoginAt] != null
          ? DateTime.parse(map[_UserDataContract.lastLoginAt])
          : null,
      country: map[_UserDataContract.country] != null
          ? Country.fromMap(map[_UserDataContract.country])
          : null,
      city: map[_UserDataContract.city] != null
          ? City.fromMap(map[_UserDataContract.city])
          : null,
      nationality: map[_UserDataContract.nationality] != null
          ? Nationality.fromMap(map[_UserDataContract.nationality])
          : null,
      language: map[_UserDataContract.language] != null
          ? Language.fromMap(map[_UserDataContract.language])
          : null,
      timezone: map[_UserDataContract.timezone] != null
          ? Timezone.fromMap(map[_UserDataContract.timezone])
          : null,
      currency: map[_UserDataContract.currency] != null
          ? Currency.fromMap(map[_UserDataContract.currency])
          : null,
      settings: map[_UserDataContract.settings] != null
          ? Settings.fromMap(map[_UserDataContract.settings])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(id: $id, uuid: $uuid, image: $image, walletBalance: $walletBalance, gender: $gender, color: $color, previewStatus: $previewStatus, status: $status, type: $type, createdAt: $createdAt, email: $email, countryId: $countryId, nationalityId: $nationalityId, cityId: $cityId, countryTimeZoneId: $countryTimeZoneId, languageId: $languageId, currencyId: $currencyId, firstName: $firstName, middleName: $middleName, lastName: $lastName, previewName: $previewName, phone: $phone, lastLoginAt: $lastLoginAt, country: $country, city: $city, nationality: $nationality, language: $language, timezone: $timezone, currency: $currency, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
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
        other.city == city &&
        other.nationality == nationality &&
        other.language == language &&
        other.timezone == timezone &&
        other.currency == currency &&
        other.settings == settings;
  }

  @override
  int get hashCode {
    return id.hashCode ^
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
        city.hashCode ^
        nationality.hashCode ^
        language.hashCode ^
        timezone.hashCode ^
        currency.hashCode ^
        settings.hashCode;
  }
}

class _UserDataContract {
  static const id = 'id';
  static const uuid = 'uuid';
  static const image = 'image';
  static const walletBalance = 'wallet_balance';
  static const gender = 'gender';
  static const color = 'color';
  static const previewStatus = 'preview_status';
  static const status = 'status';
  static const type = 'user_type';
  static const createdAt = 'created_at';
  static const email = 'email';
  static const countryId = 'country_id';
  static const nationalityId = 'nationality_id';
  static const cityId = 'city_id';
  static const countryTimeZoneId = 'country_time_zone_id';
  static const languageId = 'language_id';
  static const currencyId = 'currency_id';
  static const firstName = 'first_name';
  static const middleName = 'middle_name';
  static const lastName = 'last_name';
  static const previewName = 'preview_name';
  static const phone = 'phone';
  static const lastLoginAt = 'last_login_at';
  static const country = 'country';
  static const city = 'city';
  static const nationality = 'nationality';
  static const language = 'language';
  static const timezone = 'timezone';
  static const currency = 'currency';
  static const settings = 'settings';
}
