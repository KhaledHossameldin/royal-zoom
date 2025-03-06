import 'dart:convert';

import 'package:collection/collection.dart';

import 'settings.dart';

class Sender {
  num? id;
  String? uuid;
  num? countryId;
  dynamic nationalityId;
  num? cityId;
  num? languageId;
  num? countryTimeZoneId;
  num? currencyId;
  num? userType;
  String? firstName;
  String? middleName;
  String? lastName;
  String? previewName;
  String? image;
  String? email;
  String? phone;
  String? walletBalance;
  Settings? settings;
  num? gender;
  num? previewStatus;
  String? color;
  dynamic lastLoginAt;
  num? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? consultantPreviewName;
  String? consultantUserName;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  String? withdrawBalance;
  String? username;
  String? whatsappVerifiedAt;
  num? isOld;
  num? isSent;
  num? isReviewer;
  String? usernameVerifiedAt;

  Sender({
    this.id,
    this.uuid,
    this.countryId,
    this.nationalityId,
    this.cityId,
    this.languageId,
    this.countryTimeZoneId,
    this.currencyId,
    this.userType,
    this.firstName,
    this.middleName,
    this.lastName,
    this.previewName,
    this.image,
    this.email,
    this.phone,
    this.walletBalance,
    this.settings,
    this.gender,
    this.previewStatus,
    this.color,
    this.lastLoginAt,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.consultantPreviewName,
    this.consultantUserName,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.withdrawBalance,
    this.username,
    this.whatsappVerifiedAt,
    this.isOld,
    this.isSent,
    this.isReviewer,
    this.usernameVerifiedAt,
  });

  @override
  String toString() {
    return 'Sender(id: $id, uuid: $uuid, countryId: $countryId, nationalityId: $nationalityId, cityId: $cityId, languageId: $languageId, countryTimeZoneId: $countryTimeZoneId, currencyId: $currencyId, userType: $userType, firstName: $firstName, middleName: $middleName, lastName: $lastName, previewName: $previewName, image: $image, email: $email, phone: $phone, walletBalance: $walletBalance, settings: $settings, gender: $gender, previewStatus: $previewStatus, color: $color, lastLoginAt: $lastLoginAt, status: $status, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, consultantPreviewName: $consultantPreviewName, consultantUserName: $consultantUserName, emailVerifiedAt: $emailVerifiedAt, phoneVerifiedAt: $phoneVerifiedAt, withdrawBalance: $withdrawBalance, username: $username, whatsappVerifiedAt: $whatsappVerifiedAt, isOld: $isOld, isSent: $isSent, isReviewer: $isReviewer, usernameVerifiedAt: $usernameVerifiedAt)';
  }

  factory Sender.fromMap(Map<String, dynamic> data) => Sender(
        id: num.tryParse(data['id'].toString()),
        uuid: data['uuid']?.toString(),
        countryId: num.tryParse(data['country_id'].toString()),
        nationalityId: data['nationality_id'],
        cityId: num.tryParse(data['city_id'].toString()),
        languageId: num.tryParse(data['language_id'].toString()),
        countryTimeZoneId:
            num.tryParse(data['country_time_zone_id'].toString()),
        currencyId: num.tryParse(data['currency_id'].toString()),
        userType: num.tryParse(data['user_type'].toString()),
        firstName: data['first_name']?.toString(),
        middleName: data['middle_name']?.toString(),
        lastName: data['last_name']?.toString(),
        previewName: data['preview_name']?.toString(),
        image: data['image'],
        email: data['email']?.toString(),
        phone: data['phone']?.toString(),
        walletBalance: data['wallet_balance']?.toString(),
        settings: data['settings'] == null
            ? null
            : Settings.fromMap(Map<String, dynamic>.from(data['settings'])),
        gender: num.tryParse(data['gender'].toString()),
        previewStatus: num.tryParse(data['preview_status'].toString()),
        color: data['color']?.toString(),
        lastLoginAt: data['last_login_at'],
        status: num.tryParse(data['status'].toString()),
        deletedAt: data['deleted_at'],
        createdAt: data['created_at'] == null
            ? null
            : DateTime.tryParse(data['created_at'].toString()),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.tryParse(data['updated_at'].toString()),
        consultantPreviewName: data['consultant_preview_name']?.toString(),
        consultantUserName: data['consultant_user_name']?.toString(),
        emailVerifiedAt: data['email_verified_at'],
        phoneVerifiedAt: data['phone_verified_at'],
        withdrawBalance: data['withdraw_balance']?.toString(),
        username: data['username']?.toString(),
        whatsappVerifiedAt: data['whatsapp_verified_at']?.toString(),
        isOld: num.tryParse(data['is_old'].toString()),
        isSent: num.tryParse(data['is_sent'].toString()),
        isReviewer: num.tryParse(data['is_reviewer'].toString()),
        usernameVerifiedAt: data['username_verified_at']?.toString(),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (countryId != null) 'country_id': countryId,
        if (nationalityId != null) 'nationality_id': nationalityId,
        if (cityId != null) 'city_id': cityId,
        if (languageId != null) 'language_id': languageId,
        if (countryTimeZoneId != null)
          'country_time_zone_id': countryTimeZoneId,
        if (currencyId != null) 'currency_id': currencyId,
        if (userType != null) 'user_type': userType,
        if (firstName != null) 'first_name': firstName,
        if (middleName != null) 'middle_name': middleName,
        if (lastName != null) 'last_name': lastName,
        if (previewName != null) 'preview_name': previewName,
        if (image != null) 'image': image,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        if (walletBalance != null) 'wallet_balance': walletBalance,
        if (settings != null) 'settings': settings?.toMap(),
        if (gender != null) 'gender': gender,
        if (previewStatus != null) 'preview_status': previewStatus,
        if (color != null) 'color': color,
        if (lastLoginAt != null) 'last_login_at': lastLoginAt,
        if (status != null) 'status': status,
        if (deletedAt != null) 'deleted_at': deletedAt,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (updatedAt != null) 'updated_at': updatedAt?.toIso8601String(),
        if (consultantPreviewName != null)
          'consultant_preview_name': consultantPreviewName,
        if (consultantUserName != null)
          'consultant_user_name': consultantUserName,
        if (emailVerifiedAt != null) 'email_verified_at': emailVerifiedAt,
        if (phoneVerifiedAt != null) 'phone_verified_at': phoneVerifiedAt,
        if (withdrawBalance != null) 'withdraw_balance': withdrawBalance,
        if (username != null) 'username': username,
        if (whatsappVerifiedAt != null)
          'whatsapp_verified_at': whatsappVerifiedAt,
        if (isOld != null) 'is_old': isOld,
        if (isSent != null) 'is_sent': isSent,
        if (isReviewer != null) 'is_reviewer': isReviewer,
        if (usernameVerifiedAt != null)
          'username_verified_at': usernameVerifiedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Sender].
  factory Sender.fromJson(String data) {
    return Sender.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Sender] to a JSON string.
  String toJson() => json.encode(toMap());

  Sender copyWith({
    num? id,
    String? uuid,
    num? countryId,
    dynamic nationalityId,
    num? cityId,
    num? languageId,
    num? countryTimeZoneId,
    num? currencyId,
    num? userType,
    String? firstName,
    String? middleName,
    String? lastName,
    String? previewName,
    dynamic image,
    String? email,
    String? phone,
    String? walletBalance,
    Settings? settings,
    num? gender,
    num? previewStatus,
    String? color,
    dynamic lastLoginAt,
    num? status,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? consultantPreviewName,
    String? consultantUserName,
    dynamic emailVerifiedAt,
    dynamic phoneVerifiedAt,
    String? withdrawBalance,
    String? username,
    String? whatsappVerifiedAt,
    num? isOld,
    num? isSent,
    num? isReviewer,
    String? usernameVerifiedAt,
  }) {
    return Sender(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      countryId: countryId ?? this.countryId,
      nationalityId: nationalityId ?? this.nationalityId,
      cityId: cityId ?? this.cityId,
      languageId: languageId ?? this.languageId,
      countryTimeZoneId: countryTimeZoneId ?? this.countryTimeZoneId,
      currencyId: currencyId ?? this.currencyId,
      userType: userType ?? this.userType,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      previewName: previewName ?? this.previewName,
      image: image ?? this.image,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      walletBalance: walletBalance ?? this.walletBalance,
      settings: settings ?? this.settings,
      gender: gender ?? this.gender,
      previewStatus: previewStatus ?? this.previewStatus,
      color: color ?? this.color,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      status: status ?? this.status,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      consultantPreviewName:
          consultantPreviewName ?? this.consultantPreviewName,
      consultantUserName: consultantUserName ?? this.consultantUserName,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      withdrawBalance: withdrawBalance ?? this.withdrawBalance,
      username: username ?? this.username,
      whatsappVerifiedAt: whatsappVerifiedAt ?? this.whatsappVerifiedAt,
      isOld: isOld ?? this.isOld,
      isSent: isSent ?? this.isSent,
      isReviewer: isReviewer ?? this.isReviewer,
      usernameVerifiedAt: usernameVerifiedAt ?? this.usernameVerifiedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Sender) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      countryId.hashCode ^
      nationalityId.hashCode ^
      cityId.hashCode ^
      languageId.hashCode ^
      countryTimeZoneId.hashCode ^
      currencyId.hashCode ^
      userType.hashCode ^
      firstName.hashCode ^
      middleName.hashCode ^
      lastName.hashCode ^
      previewName.hashCode ^
      image.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      walletBalance.hashCode ^
      settings.hashCode ^
      gender.hashCode ^
      previewStatus.hashCode ^
      color.hashCode ^
      lastLoginAt.hashCode ^
      status.hashCode ^
      deletedAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      consultantPreviewName.hashCode ^
      consultantUserName.hashCode ^
      emailVerifiedAt.hashCode ^
      phoneVerifiedAt.hashCode ^
      withdrawBalance.hashCode ^
      username.hashCode ^
      whatsappVerifiedAt.hashCode ^
      isOld.hashCode ^
      isSent.hashCode ^
      isReviewer.hashCode ^
      usernameVerifiedAt.hashCode;
}
