import 'settings.dart';

class Consultant {
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
  String? usernameVerifiedAt;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  String? whatsappVerifiedAt;
  num? status;
  bool? isFavourite;
  num? userType;
  DateTime? createdAt;
  Settings? settings;
  String? consultantUserName;
  dynamic qrcode;

  Consultant({
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

  factory Consultant.fromJson(Map<String, dynamic> json) => Consultant(
        id: num.tryParse(json['id'].toString()),
        uuid: json['uuid']?.toString(),
        countryId: num.tryParse(json['country_id'].toString()),
        nationalityId: json['nationality_id'],
        cityId: num.tryParse(json['city_id'].toString()),
        countryTimeZoneId:
            num.tryParse(json['country_time_zone_id'].toString()),
        languageId: num.tryParse(json['language_id'].toString()),
        currencyId: num.tryParse(json['currency_id'].toString()),
        firstName: json['first_name']?.toString(),
        middleName: json['middle_name']?.toString(),
        lastName: json['last_name']?.toString(),
        previewName: json['preview_name']?.toString(),
        consultantPreviewName: json['consultant_preview_name']?.toString(),
        image: json['image']?.toString(),
        username: json['username']?.toString(),
        email: json['email']?.toString(),
        phone: json['phone']?.toString(),
        walletBalance: json['wallet_balance']?.toString(),
        gender: num.tryParse(json['gender'].toString()),
        color: json['color']?.toString(),
        previewStatus: num.tryParse(json['preview_status'].toString()),
        lastLoginAt: json['last_login_at'],
        usernameVerifiedAt: json['username_verified_at']?.toString(),
        emailVerifiedAt: json['email_verified_at'],
        phoneVerifiedAt: json['phone_verified_at'],
        whatsappVerifiedAt: json['whatsapp_verified_at']?.toString(),
        status: num.tryParse(json['status'].toString()),
        isFavourite: json['is_favourite']?.toString().contains('true'),
        userType: num.tryParse(json['user_type'].toString()),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'].toString()),
        settings: json['settings'] == null
            ? null
            : Settings.fromJson(Map<String, dynamic>.from(json['settings'])),
        consultantUserName: json['consultant_user_name']?.toString(),
        qrcode: json['qrcode'],
      );

  Map<String, dynamic> toJson() => {
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
        if (settings != null) 'settings': settings?.toJson(),
        if (consultantUserName != null)
          'consultant_user_name': consultantUserName,
        if (qrcode != null) 'qrcode': qrcode,
      };
}
