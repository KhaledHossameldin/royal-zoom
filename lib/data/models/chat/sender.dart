import 'dart:convert';

import 'package:collection/collection.dart';

import 'settings.dart';

class Sender {
  num? id;
  String? uuid;
  num? countryId;
  dynamic nationalityId;
  num? cityId;
  num? countryTimeZoneId;
  num? languageId;
  num? currencyId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? previewName;
  String? consultantPreviewName;
  String? image;
  String? username;
  String? email;
  String? phone;
  String? walletBalance;
  num? gender;
  String? color;
  num? previewStatus;
  dynamic lastLoginAt;
  dynamic usernameVerifiedAt;
  String? emailVerifiedAt;
  dynamic phoneVerifiedAt;
  dynamic whatsappVerifiedAt;
  num? status;
  bool? isFavourite;
  num? userType;
  DateTime? createdAt;
  Settings? settings;
  String? consultantUserName;
  dynamic qrcode;

  Sender({
    this.id,
    this.uuid,
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
    this.consultantPreviewName,
    this.image,
    this.username,
    this.email,
    this.phone,
    this.walletBalance,
    this.gender,
    this.color,
    this.previewStatus,
    this.lastLoginAt,
    this.usernameVerifiedAt,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.whatsappVerifiedAt,
    this.status,
    this.isFavourite,
    this.userType,
    this.createdAt,
    this.settings,
    this.consultantUserName,
    this.qrcode,
  });

  @override
  String toString() {
    return 'Sender(id: $id, uuid: $uuid, countryId: $countryId, nationalityId: $nationalityId, cityId: $cityId, countryTimeZoneId: $countryTimeZoneId, languageId: $languageId, currencyId: $currencyId, firstName: $firstName, middleName: $middleName, lastName: $lastName, previewName: $previewName, consultantPreviewName: $consultantPreviewName, image: $image, username: $username, email: $email, phone: $phone, walletBalance: $walletBalance, gender: $gender, color: $color, previewStatus: $previewStatus, lastLoginAt: $lastLoginAt, usernameVerifiedAt: $usernameVerifiedAt, emailVerifiedAt: $emailVerifiedAt, phoneVerifiedAt: $phoneVerifiedAt, whatsappVerifiedAt: $whatsappVerifiedAt, status: $status, isFavourite: $isFavourite, userType: $userType, createdAt: $createdAt, settings: $settings, consultantUserName: $consultantUserName, qrcode: $qrcode)';
  }

  factory Sender.fromMap(Map<String, dynamic> data) => Sender(
        id: num.tryParse(data['id'].toString()),
        uuid: data['uuid']?.toString(),
        countryId: num.tryParse(data['country_id'].toString()),
        nationalityId: data['nationality_id'],
        cityId: num.tryParse(data['city_id'].toString()),
        countryTimeZoneId:
            num.tryParse(data['country_time_zone_id'].toString()),
        languageId: num.tryParse(data['language_id'].toString()),
        currencyId: num.tryParse(data['currency_id'].toString()),
        firstName: data['first_name']?.toString(),
        middleName: data['middle_name']?.toString(),
        lastName: data['last_name']?.toString(),
        previewName: data['preview_name']?.toString(),
        consultantPreviewName: data['consultant_preview_name']?.toString(),
        image: data['image']?.toString(),
        username: data['username']?.toString(),
        email: data['email']?.toString(),
        phone: data['phone']?.toString(),
        walletBalance: data['wallet_balance']?.toString(),
        gender: num.tryParse(data['gender'].toString()),
        color: data['color']?.toString(),
        previewStatus: num.tryParse(data['preview_status'].toString()),
        lastLoginAt: data['last_login_at'],
        usernameVerifiedAt: data['username_verified_at'],
        emailVerifiedAt: data['email_verified_at']?.toString(),
        phoneVerifiedAt: data['phone_verified_at'],
        whatsappVerifiedAt: data['whatsapp_verified_at'],
        status: num.tryParse(data['status'].toString()),
        isFavourite: data['is_favourite']?.toString().contains('true'),
        userType: num.tryParse(data['user_type'].toString()),
        createdAt: data['created_at'] == null
            ? null
            : DateTime.tryParse(data['created_at'].toString()),
        settings: data['settings'] == null
            ? null
            : Settings.fromMap(Map<String, dynamic>.from(data['settings'])),
        consultantUserName: data['consultant_user_name']?.toString(),
        qrcode: data['qrcode'],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (countryId != null) 'country_id': countryId,
        if (nationalityId != null) 'nationality_id': nationalityId,
        if (cityId != null) 'city_id': cityId,
        if (countryTimeZoneId != null)
          'country_time_zone_id': countryTimeZoneId,
        if (languageId != null) 'language_id': languageId,
        if (currencyId != null) 'currency_id': currencyId,
        if (firstName != null) 'first_name': firstName,
        if (middleName != null) 'middle_name': middleName,
        if (lastName != null) 'last_name': lastName,
        if (previewName != null) 'preview_name': previewName,
        if (consultantPreviewName != null)
          'consultant_preview_name': consultantPreviewName,
        if (image != null) 'image': image,
        if (username != null) 'username': username,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        if (walletBalance != null) 'wallet_balance': walletBalance,
        if (gender != null) 'gender': gender,
        if (color != null) 'color': color,
        if (previewStatus != null) 'preview_status': previewStatus,
        if (lastLoginAt != null) 'last_login_at': lastLoginAt,
        if (usernameVerifiedAt != null)
          'username_verified_at': usernameVerifiedAt,
        if (emailVerifiedAt != null) 'email_verified_at': emailVerifiedAt,
        if (phoneVerifiedAt != null) 'phone_verified_at': phoneVerifiedAt,
        if (whatsappVerifiedAt != null)
          'whatsapp_verified_at': whatsappVerifiedAt,
        if (status != null) 'status': status,
        if (isFavourite != null) 'is_favourite': isFavourite,
        if (userType != null) 'user_type': userType,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (settings != null) 'settings': settings?.toMap(),
        if (consultantUserName != null)
          'consultant_user_name': consultantUserName,
        if (qrcode != null) 'qrcode': qrcode,
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
    num? countryTimeZoneId,
    num? languageId,
    num? currencyId,
    String? firstName,
    String? middleName,
    String? lastName,
    String? previewName,
    String? consultantPreviewName,
    String? image,
    String? username,
    String? email,
    String? phone,
    String? walletBalance,
    num? gender,
    String? color,
    num? previewStatus,
    dynamic lastLoginAt,
    dynamic usernameVerifiedAt,
    String? emailVerifiedAt,
    dynamic phoneVerifiedAt,
    dynamic whatsappVerifiedAt,
    num? status,
    bool? isFavourite,
    num? userType,
    DateTime? createdAt,
    Settings? settings,
    String? consultantUserName,
    dynamic qrcode,
  }) {
    return Sender(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
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
      consultantPreviewName:
          consultantPreviewName ?? this.consultantPreviewName,
      image: image ?? this.image,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      walletBalance: walletBalance ?? this.walletBalance,
      gender: gender ?? this.gender,
      color: color ?? this.color,
      previewStatus: previewStatus ?? this.previewStatus,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      usernameVerifiedAt: usernameVerifiedAt ?? this.usernameVerifiedAt,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      whatsappVerifiedAt: whatsappVerifiedAt ?? this.whatsappVerifiedAt,
      status: status ?? this.status,
      isFavourite: isFavourite ?? this.isFavourite,
      userType: userType ?? this.userType,
      createdAt: createdAt ?? this.createdAt,
      settings: settings ?? this.settings,
      consultantUserName: consultantUserName ?? this.consultantUserName,
      qrcode: qrcode ?? this.qrcode,
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
      countryTimeZoneId.hashCode ^
      languageId.hashCode ^
      currencyId.hashCode ^
      firstName.hashCode ^
      middleName.hashCode ^
      lastName.hashCode ^
      previewName.hashCode ^
      consultantPreviewName.hashCode ^
      image.hashCode ^
      username.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      walletBalance.hashCode ^
      gender.hashCode ^
      color.hashCode ^
      previewStatus.hashCode ^
      lastLoginAt.hashCode ^
      usernameVerifiedAt.hashCode ^
      emailVerifiedAt.hashCode ^
      phoneVerifiedAt.hashCode ^
      whatsappVerifiedAt.hashCode ^
      status.hashCode ^
      isFavourite.hashCode ^
      userType.hashCode ^
      createdAt.hashCode ^
      settings.hashCode ^
      consultantUserName.hashCode ^
      qrcode.hashCode;
}
