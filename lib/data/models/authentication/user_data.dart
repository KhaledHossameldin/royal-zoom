import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../utilities/extensions.dart';
import '../../enums/gender.dart';
import '../../enums/perview_status.dart';
import '../../enums/user_status.dart';
import '../../enums/user_type.dart';
import '../consultants/consultant.dart';
import 'city.dart';
import 'country.dart';
import 'currency.dart';
import 'language.dart';
import 'nationality.dart';
import 'settings.dart';
import 'timezone.dart';

class UserData extends Consultant {
  City? city;
  Language? language;
  Timezone? timezone;
  Currency? currency;

  UserData({
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
    super.email,
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
    super.phone,
    super.lastLoginAt,
    super.country,
    super.nationality,
    super.settings,
    this.city,
    this.language,
    this.timezone,
    this.currency,
  });

  @override
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
    Nationality? nationality,
    Settings? settings,
    City? city,
    Language? language,
    Timezone? timezone,
    Currency? currency,
    bool? selected,
  }) =>
      UserData(
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
        city: city ?? this.city,
        language: language ?? this.language,
        timezone: timezone ?? this.timezone,
        currency: currency ?? this.currency,
      );

  @override
  Map<String, dynamic> toMap() {
    final contract = _UserDataContract();

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
      contract.city: city?.toMap(),
      contract.language: language?.toMap(),
      contract.timezone: timezone?.toMap(),
      contract.currency: currency?.toMap(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    final contract = _UserDataContract();

    return UserData(
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
      city:
          map[contract.city] != null ? City.fromMap(map[contract.city]) : null,
      language: map[contract.language] != null
          ? Language.fromMap(map[contract.language])
          : null,
      timezone: map[contract.timezone] != null
          ? Timezone.fromMap(map[contract.timezone])
          : null,
      currency: map[contract.currency] != null
          ? Currency.fromMap(map[contract.currency])
          : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserData((id: $id, uuid: $uuid, image: $image, walletBalance: $walletBalance, gender: $gender, color: $color, previewStatus: $previewStatus, status: $status, type: $type, createdAt: $createdAt, email: $email, countryId: $countryId, nationalityId: $nationalityId, cityId: $cityId, countryTimeZoneId: $countryTimeZoneId, languageId: $languageId, currencyId: $currencyId, firstName: $firstName, middleName: $middleName, lastName: $lastName, previewName: $previewName, phone: $phone, lastLoginAt: $lastLoginAt, country: $country, nationality: $nationality, settings: $settings, city: $city, language: $language, timezone: $timezone, currency: $currency)';

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
        other.nationality == nationality &&
        other.settings == settings &&
        other.city == city &&
        other.language == language &&
        other.timezone == timezone &&
        other.currency == currency;
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
      settings.hashCode ^
      city.hashCode ^
      language.hashCode ^
      timezone.hashCode ^
      currency.hashCode;
}

class _UserDataContract extends ConsultantContract {
  final city = 'city';
  final language = 'language';
  final timezone = 'timezone';
  final currency = 'currency';
}
