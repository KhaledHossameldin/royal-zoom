import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../../../utilities/extensions.dart';
import '../../enums/consultant_response_type.dart';
import '../../enums/consultation_content_type.dart';
import '../../enums/consultation_status.dart';
import '../../enums/consultation_visibility_status.dart';
import '../account.dart';
import '../consultants/consultant.dart';
import '../consultation_request.dart';
import '../major.dart';
import 'consultation.dart';

class ConsultationDetails extends Consultation {
  //TODO: attachments
  final Account user;
  //TODO: replies
  final List<ConsultationRequest> requests;
  final ConsultationRequest? assignedRequest;
  //TODO: invoice
  //TODO: chat
  final List<Consultant> selectedConsultants;

  ConsultationDetails({
    required super.id,
    required super.uuid,
    required super.majorId,
    required super.userId,
    required super.contentType,
    required super.content,
    required super.responseType,
    required super.maximumPrice,
    required super.isAcceptingOffersFromAll,
    required super.isHelpRequested,
    required super.isHideNameFromConsultants,
    required super.isAcceptMinimumOfferByDefault,
    required super.attendeeNumber,
    required super.status,
    required super.isPaid,
    required super.isUnscheduled,
    required super.visibilityStatus,
    required super.publishedAt,
    required super.createdAt,
    required super.isFavourite,
    required super.isFastConsultation,
    required super.major,
    super.consultantId,
    super.appointmentDate,
    super.maxTimeToReceiveOffers,
    super.address,
    super.consultant,
    super.audioPlayer,
    required this.user,
    required this.requests,
    required this.assignedRequest,
    required this.selectedConsultants,
  });

  @override
  ConsultationDetails copyWith({
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
    String? address,
    Consultant? consultant,
    AudioPlayer? audioPlayer,
    Account? user,
    List<ConsultationRequest>? requests,
    ConsultationRequest? assignedRequest,
    List<Consultant>? selectedConsultants,
  }) {
    return ConsultationDetails(
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
      address: address ?? this.address,
      consultant: consultant ?? this.consultant,
      audioPlayer: audioPlayer ?? this.audioPlayer,
      user: user ?? this.user,
      requests: requests ?? this.requests,
      assignedRequest: assignedRequest ?? this.assignedRequest,
      selectedConsultants: selectedConsultants ?? this.selectedConsultants,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final contract = _ConsultationDetailsContract();
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
      contract.address: address,
      contract.consultant: consultant?.toMap(),
      contract.user: user.toMap(),
      contract.requests: requests.map((x) => x.toMap()).toList(),
      contract.assignedRequest: assignedRequest?.toMap(),
      contract.selectedConsultants:
          selectedConsultants.map((x) => x.toMap()).toList(),
    };
  }

  @override
  factory ConsultationDetails.fromMap(Map<String, dynamic> map) {
    final contract = _ConsultationDetailsContract();
    return ConsultationDetails(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      majorId: map[contract.majorId]?.toInt() ?? 0,
      userId: map[contract.userId]?.toInt() ?? 0,
      contentType:
          (map[contract.contentType] as int).consultationContentTypeFromMap(),
      content: map[contract.content] ?? '',
      responseType:
          (map[contract.responseType] as int).consultantResponseTypeFromMap(),
      maximumPrice: map[contract.maximumPrice] != null
          ? num.tryParse(map[contract.maximumPrice]) ?? 0.0
          : null,
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
      address: map[contract.address],
      appointmentDate: map[contract.appointmentDate] != null
          ? DateTime.parse(map[contract.appointmentDate])
          : null,
      maxTimeToReceiveOffers: map[contract.maxTimeToReceiveOffers] != null
          ? DateTime.parse(map[contract.maxTimeToReceiveOffers])
          : null,
      consultant: map[contract.consultant] != null
          ? Consultant.fromMap(map[contract.consultant])
          : null,
      user: Account.fromMap(map[contract.user]),
      requests: List<ConsultationRequest>.from(
          map[contract.requests]?.map((x) => ConsultationRequest.fromMap(x))),
      assignedRequest: map[contract.assignedRequest] != null
          ? ConsultationRequest.fromMap(map[contract.assignedRequest])
          : null,
      selectedConsultants: List<Consultant>.from(
          map[contract.selectedConsultants]?.map((x) => Consultant.fromMap(x))),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  factory ConsultationDetails.fromJson(String source) =>
      ConsultationDetails.fromMap(json.decode(source)['data']);

  @override
  String toString() {
    return 'ConsultationDetails(id: $id, uuid: $uuid, majorId: $majorId, userId: $userId, contentType: $contentType, content: $content, responseType: $responseType, maximumPrice: $maximumPrice, isAcceptingOffersFromAll: $isAcceptingOffersFromAll, isHelpRequested: $isHelpRequested, isHideNameFromConsultants: $isHideNameFromConsultants, isAcceptMinimumOfferByDefault: $isAcceptMinimumOfferByDefault, attendeeNumber: $attendeeNumber, status: $status, isPaid: $isPaid, isUnscheduled: $isUnscheduled, visibilityStatus: $visibilityStatus, publishedAt: $publishedAt, createdAt: $createdAt, isFavourite: $isFavourite, isFastConsultation: $isFastConsultation, major: $major, consultantId: $consultantId, appointmentDate: $appointmentDate, maxTimeToReceiveOffers: $maxTimeToReceiveOffers, address: $address, consultant: $consultant, audioPlayer: $audioPlayer, user: $user, requests: $requests, assignedRequest: $assignedRequest, selectedConsultants: $selectedConsultants)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConsultationDetails &&
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
        other.address == address &&
        other.audioPlayer == audioPlayer &&
        other.user == user &&
        listEquals(other.requests, requests) &&
        other.assignedRequest == assignedRequest &&
        listEquals(other.selectedConsultants, selectedConsultants);
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
        address.hashCode ^
        audioPlayer.hashCode ^
        user.hashCode ^
        requests.hashCode ^
        assignedRequest.hashCode ^
        selectedConsultants.hashCode;
  }
}

class _ConsultationDetailsContract extends ConsultationContract {
  final user = 'user';
  final requests = 'requests';
  final assignedRequest = 'assigned_request';
  final selectedConsultants = 'selected_consultants';
}
