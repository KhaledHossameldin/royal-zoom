import 'dart:convert';

import 'package:just_audio/just_audio.dart';

import '../../../utilities/extensions.dart';
import '../../enums/consultant_response_type.dart';
import '../../enums/consultation_content_type.dart';
import '../../enums/consultation_status.dart';
import '../../enums/consultation_visibility_status.dart';
import '../consultants/consultant.dart';
import '../major.dart';

class Consultation {
  final int id;
  final String uuid;
  final int majorId;
  final int userId;
  final ConsultationContentType contentType;
  final String content;
  final ConsultantResponseType responseType;
  final num maximumPrice;
  final bool isAcceptingOffersFromAll;
  final bool isHelpRequested;
  final bool isHideNameFromConsultants;
  final bool isAcceptMinimumOfferByDefault;
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
  final int? consultantId;
  final DateTime? appointmentDate;
  final DateTime? maxTimeToReceiveOffers;
  final Consultant? consultant;
  final AudioPlayer? audioPlayer;

  Consultation({
    required this.id,
    required this.uuid,
    required this.majorId,
    required this.userId,
    required this.contentType,
    required this.content,
    required this.responseType,
    required this.maximumPrice,
    required this.isAcceptingOffersFromAll,
    required this.isHelpRequested,
    required this.isHideNameFromConsultants,
    required this.isAcceptMinimumOfferByDefault,
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
    this.consultantId,
    this.appointmentDate,
    this.maxTimeToReceiveOffers,
    this.consultant,
    this.audioPlayer,
  });

  Consultation copyWith({
    int? id,
    String? uuid,
    int? majorId,
    int? userId,
    ConsultationContentType? contentType,
    String? content,
    ConsultantResponseType? responseType,
    num? maximumPrice,
    bool? isAcceptingOffersFromAll,
    bool? isHelpRequested,
    bool? isHideNameFromConsultants,
    bool? isAcceptMinimumOfferByDefault,
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
    int? consultantId,
    DateTime? appointmentDate,
    DateTime? maxTimeToReceiveOffers,
    Consultant? consultant,
    AudioPlayer? audioPlayer,
  }) {
    return Consultation(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      majorId: majorId ?? this.majorId,
      userId: userId ?? this.userId,
      contentType: contentType ?? this.contentType,
      content: content ?? this.content,
      responseType: responseType ?? this.responseType,
      maximumPrice: maximumPrice ?? this.maximumPrice,
      isAcceptingOffersFromAll:
          isAcceptingOffersFromAll ?? this.isAcceptingOffersFromAll,
      isHelpRequested: isHelpRequested ?? this.isHelpRequested,
      isHideNameFromConsultants:
          isHideNameFromConsultants ?? this.isHideNameFromConsultants,
      isAcceptMinimumOfferByDefault:
          isAcceptMinimumOfferByDefault ?? this.isAcceptMinimumOfferByDefault,
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
      consultantId: consultantId ?? this.consultantId,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      maxTimeToReceiveOffers:
          maxTimeToReceiveOffers ?? this.maxTimeToReceiveOffers,
      consultant: consultant ?? this.consultant,
      audioPlayer: audioPlayer ?? this.audioPlayer,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _ConsultationContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.majorId: majorId,
      contract.userId: userId,
      contract.contentType: contentType.toMap(),
      contract.content: content,
      contract.responseType: responseType.toMap(),
      contract.maximumPrice: maximumPrice.toString(),
      contract.isAcceptingOffersFromAll: isAcceptingOffersFromAll.toInt,
      contract.isHelpRequested: isHelpRequested.toInt,
      contract.isHideNameFromConsultants: isHideNameFromConsultants.toInt,
      contract.isAcceptMinimumOfferByDefault:
          isAcceptMinimumOfferByDefault.toInt,
      contract.attendeeNumber: attendeeNumber,
      contract.status: status.toMap(),
      contract.isPaid: isPaid.toInt,
      contract.isUnscheduled: isUnscheduled.toInt,
      contract.visibilityStatus: visibilityStatus.toMap(),
      contract.publishedAt: publishedAt.toIso8601String(),
      contract.createdAt: createdAt.toIso8601String(),
      contract.isFavourite: isFavourite,
      contract.isFastConsultation: isFastConsultation.toInt,
      contract.major: major.toMap(),
      contract.consultantId: consultantId,
      contract.appointmentDate: appointmentDate?.toIso8601String(),
      contract.maxTimeToReceiveOffers:
          maxTimeToReceiveOffers?.toIso8601String(),
      contract.consultant: consultant?.toMap(),
    };
  }

  factory Consultation.fromMap(Map<String, dynamic> map) {
    final contract = _ConsultationContract();

    return Consultation(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      majorId: map[contract.majorId]?.toInt() ?? 0,
      userId: map[contract.userId]?.toInt() ?? 0,
      contentType:
          (map[contract.contentType] as int).consultationContentTypeFromMap(),
      content: map[contract.content] ?? '',
      responseType:
          (map[contract.responseType] as int).consultantResponseTypeFromMap(),
      maximumPrice: num.tryParse(map[contract.maximumPrice]) ?? 0.0,
      isAcceptingOffersFromAll:
          (map[contract.isAcceptingOffersFromAll] as int) != 0,
      isHelpRequested: (map[contract.isHelpRequested] as int) != 0,
      isHideNameFromConsultants:
          (map[contract.isHideNameFromConsultants] as int) != 0,
      isAcceptMinimumOfferByDefault:
          (map[contract.isAcceptMinimumOfferByDefault] as int) != 0,
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
      consultantId: map[contract.consultantId]?.toInt(),
      appointmentDate: map[contract.appointmentDate] != null
          ? DateTime.parse(map[contract.appointmentDate])
          : null,
      maxTimeToReceiveOffers: map[contract.maxTimeToReceiveOffers] != null
          ? DateTime.parse(map[contract.maxTimeToReceiveOffers])
          : null,
      consultant: map[contract.consultant] != null
          ? Consultant.fromMap(map[contract.consultant])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Consultation.fromJson(String source) =>
      Consultation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Consultation(id: $id, uuid: $uuid, majorId: $majorId, userId: $userId, contentType: $contentType, content: $content, responseType: $responseType, maximumPrice: $maximumPrice, isAcceptingOffersFromAll: $isAcceptingOffersFromAll, isHelpRequested: $isHelpRequested, isHideNameFromConsultants: $isHideNameFromConsultants, isAcceptMinimumOfferByDefault: $isAcceptMinimumOfferByDefault, attendeeNumber: $attendeeNumber, status: $status, isPaid: $isPaid, isUnscheduled: $isUnscheduled, visibilityStatus: $visibilityStatus, publishedAt: $publishedAt, createdAt: $createdAt, isFavourite: $isFavourite, isFastConsultation: $isFastConsultation, major: $major, consultantId: $consultantId, appointmentDate: $appointmentDate, maxTimeToReceiveOffers: $maxTimeToReceiveOffers, consultant: $consultant, audioPlayer: $audioPlayer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Consultation &&
        other.id == id &&
        other.uuid == uuid &&
        other.majorId == majorId &&
        other.userId == userId &&
        other.contentType == contentType &&
        other.content == content &&
        other.responseType == responseType &&
        other.maximumPrice == maximumPrice &&
        other.isAcceptingOffersFromAll == isAcceptingOffersFromAll &&
        other.isHelpRequested == isHelpRequested &&
        other.isHideNameFromConsultants == isHideNameFromConsultants &&
        other.isAcceptMinimumOfferByDefault == isAcceptMinimumOfferByDefault &&
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
        other.consultantId == consultantId &&
        other.appointmentDate == appointmentDate &&
        other.maxTimeToReceiveOffers == maxTimeToReceiveOffers &&
        other.consultant == consultant &&
        other.audioPlayer == audioPlayer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        majorId.hashCode ^
        userId.hashCode ^
        contentType.hashCode ^
        content.hashCode ^
        responseType.hashCode ^
        maximumPrice.hashCode ^
        isAcceptingOffersFromAll.hashCode ^
        isHelpRequested.hashCode ^
        isHideNameFromConsultants.hashCode ^
        isAcceptMinimumOfferByDefault.hashCode ^
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
        consultantId.hashCode ^
        appointmentDate.hashCode ^
        maxTimeToReceiveOffers.hashCode ^
        consultant.hashCode ^
        audioPlayer.hashCode;
  }
}

class _ConsultationContract {
  final id = 'id';
  final uuid = 'uuid';
  final majorId = 'major_id';
  final consultantId = 'consultant_id';
  final userId = 'user_id';
  final contentType = 'content_type';
  final content = 'content';
  final responseType = 'consultant_response_type';
  final appointmentDate = 'appointment_date';
  final maxTimeToReceiveOffers = 'max_time_to_receive_offers';
  final maximumPrice = 'maximum_price';
  final isAcceptingOffersFromAll = 'is_accepting_offers_from_all';
  final isHelpRequested = 'is_help_requested';
  final isHideNameFromConsultants = 'hide_name_from_consultants';
  final isAcceptMinimumOfferByDefault = 'accept_minimum_offer_by_default';
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
  final consultant = 'consultant';
}
