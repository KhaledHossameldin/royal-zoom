import 'package:flutter/material.dart';

import '../enums/gender.dart';
import '../enums/perview_status.dart';
import '../enums/user_status.dart';
import '../enums/user_type.dart';
import 'authentication/country.dart';
import 'authentication/nationality.dart';
import 'authentication/settings.dart';

abstract class Account {
  final int id;
  final String uuid;
  final String image;
  final num walletBalance;
  final Gender gender;
  final Color color;
  final PreviewStatus previewStatus;
  final UserStatus status;
  final UserType type;
  final DateTime createdAt;
  final int? countryId;
  final int? nationalityId;
  final int? cityId;
  final int? countryTimeZoneId;
  final int? languageId;
  final int? currencyId;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? previewName;
  final String? email;
  final String? phone;
  final DateTime? lastLoginAt;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;
  final Country? country;
  final Nationality? nationality;
  final Settings? settings;

  Account({
    required this.id,
    required this.uuid,
    required this.walletBalance,
    required this.gender,
    required this.color,
    required this.previewStatus,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.image,
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
    this.email,
    this.phone,
    this.lastLoginAt,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.country,
    this.nationality,
    this.settings,
  });

  @override
  String toString() {
    return 'Person(id: $id, uuid: $uuid, image: $image, walletBalance: $walletBalance, gender: $gender, color: $color, previewStatus: $previewStatus, status: $status, type: $type, createdAt: $createdAt, countryId: $countryId, nationalityId: $nationalityId, cityId: $cityId, countryTimeZoneId: $countryTimeZoneId, languageId: $languageId, currencyId: $currencyId, firstName: $firstName, middleName: $middleName, lastName: $lastName, previewName: $previewName, email: $email, phone: $phone, lastLoginAt: $lastLoginAt, emailVerifiedAt: $emailVerifiedAt, phoneVerifiedAt: $phoneVerifiedAt, country: $country, nationality: $nationality, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
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
        other.email == email &&
        other.phone == phone &&
        other.lastLoginAt == lastLoginAt &&
        other.emailVerifiedAt == emailVerifiedAt &&
        other.phoneVerifiedAt == phoneVerifiedAt &&
        other.country == country &&
        other.nationality == nationality &&
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
        email.hashCode ^
        phone.hashCode ^
        lastLoginAt.hashCode ^
        emailVerifiedAt.hashCode ^
        phoneVerifiedAt.hashCode ^
        country.hashCode ^
        nationality.hashCode ^
        settings.hashCode;
  }
}

abstract class PersonContract {
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
  final email = 'email';
  final phone = 'phone';
  final lastLoginAt = 'last_login_at';
  final emailVerifiedAt = 'email_verified_at';
  final phoneVerifiedAt = 'phone_verified_at';
  final country = 'country';
  final nationality = 'nationality';
  final settings = 'settings';
}
