import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utilities/extensions.dart';
import '../../enums/gender.dart';
import '../../enums/perview_status.dart';
import '../../enums/user_status.dart';
import '../../enums/user_type.dart';
import '../authentication/city.dart';
import '../authentication/country.dart';
import '../authentication/currency.dart';
import '../authentication/language.dart';
import '../authentication/nationality.dart';
import '../authentication/settings.dart';
import '../authentication/timezone.dart';
import '../consultations/consultation.dart';
import '../rating.dart';
import 'activity.dart';
import 'bank_account.dart';
import 'certificate.dart';
import 'consultant.dart';
import 'course.dart';
import 'default_major.dart';
import 'experience.dart';
import 'language.dart';
import 'patent.dart';
import 'project.dart';
import 'qualification.dart';
import 'research.dart';
import 'skill.dart';
import 'video.dart';
import 'volunteering.dart';

class ConsultantDetails extends Consultant {
  final BankAccount? bankAccount;
  final num ratingAverage;
  final List<Skill> skills;
  final List<Certificate> certificates;
  final List<Activity> activities;
  final List<Course> courses;
  final List<Experience> experiences;
  final List<ConsultantLanguage> languages;
  final List<Patent> patents;
  final List<Project> projects;
  final List<Volunteering> volunteering;
  final List<Research> researches;
  final List<Qualification> qualifications;
  final List<Consultation> consultations;
  final List<Rating> ratings;
  final Video? video;
  final City? city;
  final Language? language;
  final Timezone? timezone;
  final Currency? currency;

  ConsultantDetails({
    required super.isFavourite,
    required this.ratings,
    required this.video,
    required this.skills,
    required this.certificates,
    required this.activities,
    required this.courses,
    required this.experiences,
    required this.languages,
    required this.patents,
    required this.projects,
    required this.volunteering,
    required this.researches,
    required this.qualifications,
    required this.consultations,
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
    required super.consultantPreviewName,
    required this.ratingAverage,
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
    super.major,
    super.majors,
    this.bankAccount,
    this.city,
    this.language,
    this.timezone,
    this.currency,
  });

  @override
  ConsultantDetails copyWith({
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
    BankAccount? bankAccount,
    List<Rating>? ratings,
    Video? video,
    List<Skill>? skills,
    List<Certificate>? certificates,
    List<Activity>? activities,
    List<Course>? courses,
    List<Experience>? experiences,
    List<ConsultantLanguage>? languages,
    List<Patent>? patents,
    List<Project>? projects,
    List<Volunteering>? volunteering,
    List<Research>? researches,
    List<Qualification>? qualifications,
    List<Consultation>? consultations,
    City? city,
    Language? language,
    Timezone? timezone,
    Currency? currency,
    num? ratingAverage,
  }) {
    return ConsultantDetails(
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
      country: country ?? this.country,
      nationality: nationality ?? super.nationality,
      settings: settings ?? super.settings,
      isFavourite: isFavourite ?? this.isFavourite,
      major: major ?? this.major,
      majors: majors ?? this.majors,
      bankAccount: bankAccount ?? this.bankAccount,
      ratings: ratings ?? this.ratings,
      video: video ?? this.video,
      skills: skills ?? this.skills,
      certificates: certificates ?? this.certificates,
      activities: activities ?? this.activities,
      courses: courses ?? this.courses,
      experiences: experiences ?? this.experiences,
      languages: languages ?? this.languages,
      patents: patents ?? this.patents,
      projects: projects ?? this.projects,
      volunteering: volunteering ?? this.volunteering,
      researches: researches ?? this.researches,
      qualifications: qualifications ?? this.qualifications,
      consultations: consultations ?? this.consultations,
      city: city ?? this.city,
      language: language ?? this.language,
      timezone: timezone ?? this.timezone,
      currency: currency ?? this.currency,
      ratingAverage: ratingAverage ?? this.ratingAverage,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final contract = _ConsultatnDetails();
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
      contract.bankAccount: bankAccount?.toMap(),
      contract.ratings: ratings.map((x) => x.toMap()).toList(),
      contract.video: video?.toMap(),
      contract.skills: skills.map((x) => x.toMap()).toList(),
      contract.certificates: certificates.map((x) => x.toMap()).toList(),
      contract.activities: activities.map((x) => x.toMap()).toList(),
      contract.courses: courses.map((x) => x.toMap()).toList(),
      contract.experiences: experiences.map((x) => x.toMap()).toList(),
      contract.languages: languages.map((x) => x.toMap()).toList(),
      contract.patents: patents.map((x) => x.toMap()).toList(),
      contract.projects: projects.map((x) => x.toMap()).toList(),
      contract.volunteering: volunteering.map((x) => x.toMap()).toList(),
      contract.researches: researches.map((x) => x.toMap()).toList(),
      contract.qualifications: qualifications.map((x) => x.toMap()).toList(),
      contract.consultations: consultations.map((x) => x.toMap()).toList(),
      contract.city: city?.toMap(),
      contract.language: language?.toMap(),
      contract.timezone: timezone?.toMap(),
      contract.currency: currency?.toMap(),
      contract.ratingAverage: ratingAverage.toString(),
    };
  }

  factory ConsultantDetails.fromMap(Map<String, dynamic> map) {
    final contract = _ConsultatnDetails();
    return ConsultantDetails(
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
      ratingAverage: num.tryParse(contract.ratingAverage) ?? 0,
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
      bankAccount: map[contract.bankAccount] != null
          ? BankAccount.fromMap(map[contract.bankAccount])
          : null,
      ratings: List<Rating>.from(
          map[contract.ratings]?.map((x) => Rating.fromMap(x))),
      video: map[contract.video] != null
          ? Video.fromMap(map[contract.video])
          : null,
      skills:
          List<Skill>.from(map[contract.skills]?.map((x) => Skill.fromMap(x))),
      certificates: List<Certificate>.from(
          map[contract.certificates]?.map((x) => Certificate.fromMap(x))),
      activities: List<Activity>.from(
          map[contract.activities]?.map((x) => Activity.fromMap(x))),
      courses: List<Course>.from(
          map[contract.courses]?.map((x) => Course.fromMap(x))),
      experiences: List<Experience>.from(
          map[contract.experiences]?.map((x) => Experience.fromMap(x))),
      languages: List<ConsultantLanguage>.from(
          map[contract.languages]?.map((x) => ConsultantLanguage.fromMap(x))),
      patents: List<Patent>.from(
          map[contract.patents]?.map((x) => Patent.fromMap(x))),
      projects: List<Project>.from(
          map[contract.projects]?.map((x) => Project.fromMap(x))),
      volunteering: List<Volunteering>.from(
          map[contract.volunteering]?.map((x) => Volunteering.fromMap(x))),
      researches: List<Research>.from(
          map[contract.researches]?.map((x) => Research.fromMap(x))),
      qualifications: List<Qualification>.from(
          map[contract.qualifications]?.map((x) => Qualification.fromMap(x))),
      consultations: List<Consultation>.from(
          map[contract.consultations]?.map((x) => Consultation.fromMap(x))),
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

  factory ConsultantDetails.fromJson(String source) =>
      ConsultantDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConsultantDetails(id: $id, uuid: $uuid, image: $image, walletBalance: $walletBalance, gender: $gender, color: $color, previewStatus: $previewStatus, status: $status, type: $type, createdAt: $createdAt, countryId: $countryId, nationalityId: $nationalityId, cityId: $cityId, countryTimeZoneId: $countryTimeZoneId, languageId: $languageId, currencyId: $currencyId, firstName: $firstName, middleName: $middleName, lastName: $lastName, previewName: $previewName, consultantPreviewName: $consultantPreviewName, email: $email, phone: $phone, lastLoginAt: $lastLoginAt, emailVerifiedAt: $emailVerifiedAt, phoneVerifiedAt: $phoneVerifiedAt, country: $country, nationality: $nationality, settings: $settings, isFavourite: $isFavourite, major: $major, majors: $majors, bankAccount: $bankAccount, ratings: $ratings, video: $video, skills: $skills, certificates: $certificates, activities: $activities, courses: $courses, experiences: $experiences, languages: $languages, patents: $patents, projects: $projects, volunteering: $volunteering, researches: $researches, qualifications: $qualifications, consultations: $consultations, city: $city, language: $language, timezone: $timezone, currency: $currency, ratingAverage: $ratingAverage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConsultantDetails &&
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
        other.bankAccount == bankAccount &&
        listEquals(other.ratings, ratings) &&
        other.video == video &&
        listEquals(other.skills, skills) &&
        listEquals(other.certificates, certificates) &&
        listEquals(other.activities, activities) &&
        listEquals(other.courses, courses) &&
        listEquals(other.experiences, experiences) &&
        listEquals(other.languages, languages) &&
        listEquals(other.patents, patents) &&
        listEquals(other.projects, projects) &&
        listEquals(other.volunteering, volunteering) &&
        listEquals(other.researches, researches) &&
        listEquals(other.qualifications, qualifications) &&
        listEquals(other.consultations, consultations) &&
        other.city == city &&
        other.language == language &&
        other.timezone == timezone &&
        other.currency == currency &&
        other.ratingAverage == ratingAverage;
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
        bankAccount.hashCode ^
        ratings.hashCode ^
        video.hashCode ^
        skills.hashCode ^
        certificates.hashCode ^
        activities.hashCode ^
        courses.hashCode ^
        experiences.hashCode ^
        languages.hashCode ^
        patents.hashCode ^
        projects.hashCode ^
        volunteering.hashCode ^
        researches.hashCode ^
        qualifications.hashCode ^
        consultations.hashCode ^
        city.hashCode ^
        language.hashCode ^
        timezone.hashCode ^
        currency.hashCode ^
        ratingAverage.hashCode;
  }
}

class _ConsultatnDetails extends ConsultantContract {
  final city = 'city';
  final language = 'language';
  final timezone = 'timezone';
  final currency = 'currency';
  final bankAccount = 'bank_account';
  final ratings = 'ratings';
  final video = 'video';
  final skills = 'skills';
  final certificates = 'certificates';
  final activities = 'activities';
  final courses = 'courses';
  final experiences = 'experiences';
  final languages = 'languages';
  final patents = 'patents';
  final projects = 'projects';
  final volunteering = 'volunteering';
  final researches = 'researches';
  final qualifications = 'qualifications';
  final consultations = 'public_consultations';
  final ratingAverage = 'rating_average';
}
