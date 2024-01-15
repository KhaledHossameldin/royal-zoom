import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../utilities/extensions.dart';
import '../../enums/consultant_response_type.dart';
import '../../enums/consultation_content_type.dart';
import '../../enums/consultation_status.dart';
import '../../enums/consultation_visibility_status.dart';
import '../account.dart';
import '../consultants/consultant.dart';
import '../major.dart';

class Appointment {
  final int id;
  final String uuid;
  final int majorId;
  final int consultantId;
  final int userId;
  final ConsultationContentType contentType;
  final String content;
  final ConsultantResponseType consultantResponseType;
  final DateTime appointmentDate;
  final DateTime maxTimeToReceiveOffers;
  final num maximumPrice;
  final bool isAcceptingOffersFromAll;
  final bool isHelpRequested;
  final bool hideNameFromConsultants;
  final bool acceptMinimumOfferByDefault;
  final int attendeeNumber;
  final ConsultationStatus status;
  final bool isPaid;
  final bool isUnscheduled;
  final ConsultationVisibilityStatus visibilityStatus;
  final DateTime publishedAt;
  final DateTime createdAt;
  final bool isFavourite;
  final bool isFastConsultation;
  final Major major;
  final Account user;
  final Consultant consultant;
  final List<Consultant> selectedConsultants;
  final String appointmentStatus;

  Appointment({
    required this.id,
    required this.uuid,
    required this.majorId,
    required this.consultantId,
    required this.userId,
    required this.contentType,
    required this.content,
    required this.consultantResponseType,
    required this.appointmentDate,
    required this.maxTimeToReceiveOffers,
    required this.maximumPrice,
    required this.isAcceptingOffersFromAll,
    required this.isHelpRequested,
    required this.hideNameFromConsultants,
    required this.acceptMinimumOfferByDefault,
    required this.attendeeNumber,
    required this.status,
    required this.isPaid,
    required this.isUnscheduled,
    required this.visibilityStatus,
    required this.publishedAt,
    required this.createdAt,
    required this.isFavourite,
    required this.isFastConsultation,
    required this.major,
    required this.user,
    required this.consultant,
    required this.selectedConsultants,
    required this.appointmentStatus,
  });

  Appointment copyWith({
    int? id,
    String? uuid,
    int? majorId,
    int? consultantId,
    int? userId,
    ConsultationContentType? contentType,
    String? content,
    ConsultantResponseType? consultantResponseType,
    DateTime? appointmentDate,
    DateTime? maxTimeToReceiveOffers,
    num? maximumPrice,
    bool? isAcceptingOffersFromAll,
    bool? isHelpRequested,
    bool? hideNameFromConsultants,
    bool? acceptMinimumOfferByDefault,
    int? attendeeNumber,
    ConsultationStatus? status,
    bool? isPaid,
    bool? isUnscheduled,
    ConsultationVisibilityStatus? visibilityStatus,
    DateTime? publishedAt,
    DateTime? createdAt,
    bool? isFavourite,
    bool? isFastConsultation,
    Major? major,
    Account? user,
    Consultant? consultant,
    List<Consultant>? selectedConsultants,
    String? appointmentStatus,
  }) {
    return Appointment(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      majorId: majorId ?? this.majorId,
      consultantId: consultantId ?? this.consultantId,
      userId: userId ?? this.userId,
      contentType: contentType ?? this.contentType,
      content: content ?? this.content,
      consultantResponseType:
          consultantResponseType ?? this.consultantResponseType,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      maxTimeToReceiveOffers:
          maxTimeToReceiveOffers ?? this.maxTimeToReceiveOffers,
      maximumPrice: maximumPrice ?? this.maximumPrice,
      isAcceptingOffersFromAll:
          isAcceptingOffersFromAll ?? this.isAcceptingOffersFromAll,
      isHelpRequested: isHelpRequested ?? this.isHelpRequested,
      hideNameFromConsultants:
          hideNameFromConsultants ?? this.hideNameFromConsultants,
      acceptMinimumOfferByDefault:
          acceptMinimumOfferByDefault ?? this.acceptMinimumOfferByDefault,
      attendeeNumber: attendeeNumber ?? this.attendeeNumber,
      status: status ?? this.status,
      isPaid: isPaid ?? this.isPaid,
      isUnscheduled: isUnscheduled ?? this.isUnscheduled,
      visibilityStatus: visibilityStatus ?? this.visibilityStatus,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      isFavourite: isFavourite ?? this.isFavourite,
      isFastConsultation: isFastConsultation ?? this.isFastConsultation,
      major: major ?? this.major,
      user: user ?? this.user,
      consultant: consultant ?? this.consultant,
      selectedConsultants: selectedConsultants ?? this.selectedConsultants,
      appointmentStatus: appointmentStatus ?? this.appointmentStatus,
    );
  }

  Map<String, Object> toMap() {
    final contract = _AppointmentContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.majorId: majorId,
      contract.consultantId: consultantId,
      contract.userId: userId,
      contract.contentType: contentType.toMap(),
      contract.content: content,
      contract.consultantResponseType: consultantResponseType.toMap(),
      contract.appointmentDate: appointmentDate.toIso8601String(),
      contract.maxTimeToReceiveOffers: maxTimeToReceiveOffers.toIso8601String(),
      contract.maximumPrice: maximumPrice,
      contract.isAcceptingOffersFromAll: isAcceptingOffersFromAll.toInt,
      contract.isHelpRequested: isHelpRequested.toInt,
      contract.hideNameFromConsultants: hideNameFromConsultants.toInt,
      contract.acceptMinimumOfferByDefault: acceptMinimumOfferByDefault.toInt,
      contract.attendeeNumber: attendeeNumber,
      contract.status: status.toMap(),
      contract.isPaid: isPaid.toInt,
      contract.isUnscheduled: isUnscheduled.toInt,
      contract.visibilityStatus: visibilityStatus.toMap(),
      contract.publishedAt: publishedAt.toIso8601String(),
      contract.createdAt: createdAt.toIso8601String(),
      contract.isFavourite: isFavourite.toInt,
      contract.isFastConsultation: isFastConsultation,
      contract.major: major.toMap(),
      contract.user: user.toMap(),
      contract.consultant: consultant.toMap(),
      contract.selectedConsultants:
          selectedConsultants.map((x) => x.toMap()).toList(),
      contract.appointmentStatus: appointmentStatus,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    final contract = _AppointmentContract();
    return Appointment(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      majorId: map[contract.majorId]?.toInt() ?? 0,
      consultantId: map[contract.consultantId]?.toInt() ?? 0,
      userId: map[contract.userId]?.toInt() ?? 0,
      contentType:
          (map[contract.contentType] as int).consultationContentTypeFromMap(),
      content: map[contract.content] ?? '',
      consultantResponseType: (map[contract.consultantResponseType] as int)
          .consultantResponseTypeFromMap(),
      appointmentDate: DateTime.parse(map[contract.appointmentDate]),
      maxTimeToReceiveOffers:
          DateTime.parse(map[contract.maxTimeToReceiveOffers]),
      maximumPrice: num.tryParse(map[contract.maximumPrice]) ?? 0.0,
      isAcceptingOffersFromAll:
          (map[contract.isAcceptingOffersFromAll] as int) != 0,
      isHelpRequested: (map[contract.isHelpRequested] as int) != 0,
      hideNameFromConsultants:
          (map[contract.hideNameFromConsultants] as int) != 0,
      acceptMinimumOfferByDefault:
          (map[contract.acceptMinimumOfferByDefault] as int) != 0,
      attendeeNumber: map[contract.attendeeNumber]?.toInt() ?? 0,
      status: (map[contract.status] as int).consultationStatusFromMap(),
      isPaid: (map[contract.isPaid] as int) != 0,
      isUnscheduled: (map[contract.isUnscheduled] as int) != 0,
      visibilityStatus: (map[contract.visibilityStatus] as int)
          .consultationVisibilityFromMap(),
      publishedAt: DateTime.parse(map[contract.publishedAt]),
      createdAt: DateTime.parse(map[contract.createdAt]),
      isFavourite: map[contract.isFavourite] ?? false,
      isFastConsultation: (map[contract.isFastConsultation] as int) != 0,
      major: Major.fromMap(map[contract.major]),
      user: Account.fromMap(map[contract.user]),
      consultant: Consultant.fromMap(map[contract.consultant]),
      selectedConsultants: List<Consultant>.from(
          map[contract.selectedConsultants]?.map((x) => Consultant.fromMap(x))),
      appointmentStatus: map[contract.appointmentStatus] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Appointment(id: $id, uuid: $uuid, majorId: $majorId, consultantId: $consultantId, userId: $userId, contentType: $contentType, content: $content, consultantResponseType: $consultantResponseType, appointmentDate: $appointmentDate, maxTimeToReceiveOffers: $maxTimeToReceiveOffers, maximumPrice: $maximumPrice, isAcceptingOffersFromAll: $isAcceptingOffersFromAll, isHelpRequested: $isHelpRequested, hideNameFromConsultants: $hideNameFromConsultants, acceptMinimumOfferByDefault: $acceptMinimumOfferByDefault, attendeeNumber: $attendeeNumber, status: $status, isPaid: $isPaid, isUnscheduled: $isUnscheduled, visibilityStatus: $visibilityStatus, publishedAt: $publishedAt, createdAt: $createdAt, isFavourite: $isFavourite, isFastConsultation: $isFastConsultation, major: $major, user: $user, consultant: $consultant, selectedConsultants: $selectedConsultants, appointmentStatus: $appointmentStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Appointment &&
        other.id == id &&
        other.uuid == uuid &&
        other.majorId == majorId &&
        other.consultantId == consultantId &&
        other.userId == userId &&
        other.contentType == contentType &&
        other.content == content &&
        other.consultantResponseType == consultantResponseType &&
        other.appointmentDate == appointmentDate &&
        other.maxTimeToReceiveOffers == maxTimeToReceiveOffers &&
        other.maximumPrice == maximumPrice &&
        other.isAcceptingOffersFromAll == isAcceptingOffersFromAll &&
        other.isHelpRequested == isHelpRequested &&
        other.hideNameFromConsultants == hideNameFromConsultants &&
        other.acceptMinimumOfferByDefault == acceptMinimumOfferByDefault &&
        other.attendeeNumber == attendeeNumber &&
        other.status == status &&
        other.isPaid == isPaid &&
        other.isUnscheduled == isUnscheduled &&
        other.visibilityStatus == visibilityStatus &&
        other.publishedAt == publishedAt &&
        other.createdAt == createdAt &&
        other.isFavourite == isFavourite &&
        other.isFastConsultation == isFastConsultation &&
        other.major == major &&
        other.user == user &&
        other.consultant == consultant &&
        listEquals(other.selectedConsultants, selectedConsultants) &&
        other.appointmentStatus == appointmentStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        majorId.hashCode ^
        consultantId.hashCode ^
        userId.hashCode ^
        contentType.hashCode ^
        content.hashCode ^
        consultantResponseType.hashCode ^
        appointmentDate.hashCode ^
        maxTimeToReceiveOffers.hashCode ^
        maximumPrice.hashCode ^
        isAcceptingOffersFromAll.hashCode ^
        isHelpRequested.hashCode ^
        hideNameFromConsultants.hashCode ^
        acceptMinimumOfferByDefault.hashCode ^
        attendeeNumber.hashCode ^
        status.hashCode ^
        isPaid.hashCode ^
        isUnscheduled.hashCode ^
        visibilityStatus.hashCode ^
        publishedAt.hashCode ^
        createdAt.hashCode ^
        isFavourite.hashCode ^
        isFastConsultation.hashCode ^
        major.hashCode ^
        user.hashCode ^
        consultant.hashCode ^
        selectedConsultants.hashCode ^
        appointmentStatus.hashCode;
  }
}

class _AppointmentContract {
  final id = 'id';
  final uuid = 'uuid';
  final majorId = 'major_id';
  final consultantId = 'consultant_id';
  final userId = 'user_id';
  final contentType = 'content_type';
  final content = 'content';
  final consultantResponseType = 'consultant_response_type';
  final appointmentDate = 'appointment_date';
  final maxTimeToReceiveOffers = 'max_time_to_receive_offers';
  final maximumPrice = 'maximum_price';
  final isAcceptingOffersFromAll = 'is_accepting_offers_from_all';
  final isHelpRequested = 'is_help_requested';
  final hideNameFromConsultants = 'hide_name_from_consultants';
  final acceptMinimumOfferByDefault = 'accept_minimum_offer_by_default';
  final attendeeNumber = 'attendee_number';
  final status = 'status';
  final isPaid = 'is_paid';
  final isUnscheduled = 'is_unscheduled';
  final visibilityStatus = 'visibility_status';
  final publishedAt = 'published_at';
  final createdAt = 'created_at';
  final isFavourite = 'is_favourite';
  final isFastConsultation = 'is_fast_consultation';
  final major = 'major';
  final user = 'user';
  final consultant = 'consultant';
  final selectedConsultants = 'selected_consultants';
  final appointmentStatus = 'appointment_status';
}
