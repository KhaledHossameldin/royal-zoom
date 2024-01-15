import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../utilities/extensions.dart';
import '../../../enums/consultant_response_type.dart';
import '../../../enums/consultation_content_type.dart';
import '../../../enums/consultation_status.dart';
import '../../../enums/consultation_visibility_status.dart';
import '../../consultants/consultant.dart';
import 'invoicable.dart';

class ConsultationInvoiceable extends Invoiceable {
  final int majorId;
  final int consultantId;
  final ConsultationContentType contentType;
  final String content;
  final ConsultantResponseType responseType;
  final bool isAcceptingOffersFromAll;
  final bool isHelpRequested;
  final bool isHideNameFromConsultants;
  final bool isAcceptMinimumOfferByDefault;
  final int attendeeNumber;
  final ConsultationStatus status;
  final bool isUnscheduled;
  final ConsultationVisibilityStatus visibilityStatus;
  final DateTime publishedAt;
  final bool isFavourite;
  final bool isFastConsultation;
  final List<Consultant> selectedConsultants;
  final num? maximumPrice;
  final DateTime? maxTimeToReceiveOffers;
  final DateTime? appointmentDate;

  ConsultationInvoiceable({
    required super.id,
    required super.uuid,
    required super.userId,
    required super.isPaid,
    required super.createdAt,
    required this.majorId,
    required this.consultantId,
    required this.contentType,
    required this.content,
    required this.responseType,
    required this.maxTimeToReceiveOffers,
    required this.isAcceptingOffersFromAll,
    required this.isHelpRequested,
    required this.isHideNameFromConsultants,
    required this.isAcceptMinimumOfferByDefault,
    required this.attendeeNumber,
    required this.status,
    required this.isUnscheduled,
    required this.visibilityStatus,
    required this.publishedAt,
    required this.isFavourite,
    required this.isFastConsultation,
    required this.selectedConsultants,
    this.maximumPrice,
    this.appointmentDate,
  });

  ConsultationInvoiceable copyWith({
    int? id,
    String? uuid,
    int? userId,
    bool? isPaid,
    DateTime? createdAt,
    int? majorId,
    int? consultantId,
    ConsultationContentType? contentType,
    String? content,
    ConsultantResponseType? responseType,
    DateTime? maxTimeToReceiveOffers,
    num? maximumPrice,
    bool? isAcceptingOffersFromAll,
    bool? isHelpRequested,
    bool? isHideNameFromConsultants,
    bool? isAcceptMinimumOfferByDefault,
    int? attendeeNumber,
    ConsultationStatus? status,
    bool? isUnscheduled,
    ConsultationVisibilityStatus? visibilityStatus,
    DateTime? publishedAt,
    bool? isFavourite,
    bool? isFastConsultation,
    List<Consultant>? selectedConsultants,
    DateTime? appointmentDate,
  }) {
    return ConsultationInvoiceable(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt ?? this.createdAt,
      majorId: majorId ?? this.majorId,
      consultantId: consultantId ?? this.consultantId,
      contentType: contentType ?? this.contentType,
      content: content ?? this.content,
      responseType: responseType ?? this.responseType,
      maxTimeToReceiveOffers:
          maxTimeToReceiveOffers ?? this.maxTimeToReceiveOffers,
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
      isUnscheduled: isUnscheduled ?? this.isUnscheduled,
      visibilityStatus: visibilityStatus ?? this.visibilityStatus,
      publishedAt: publishedAt ?? this.publishedAt,
      isFavourite: isFavourite ?? this.isFavourite,
      isFastConsultation: isFastConsultation ?? this.isFastConsultation,
      selectedConsultants: selectedConsultants ?? this.selectedConsultants,
      appointmentDate: appointmentDate ?? this.appointmentDate,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _ConsultationInvoicableContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.isPaid: isPaid.toInt,
      contract.createdAt: createdAt.toIso8601String(),
      contract.id: id,
      contract.uuid: uuid,
      contract.majorId: majorId,
      contract.userId: userId,
      contract.contentType: contentType.toMap(),
      contract.content: content,
      contract.responseType: responseType.toMap(),
      contract.maximumPrice: maximumPrice?.toString(),
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
      contract.consultantId: consultantId,
      contract.appointmentDate: appointmentDate?.toIso8601String(),
      contract.maxTimeToReceiveOffers:
          maxTimeToReceiveOffers?.toIso8601String(),
      contract.selectedConsultants:
          selectedConsultants.map((x) => x.toMap()).toList(),
      contract.appointmentDate: appointmentDate?.toIso8601String(),
    };
  }

  factory ConsultationInvoiceable.fromMap(Map<String, dynamic> map) {
    final contract = _ConsultationInvoicableContract();

    return ConsultationInvoiceable(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      isPaid: (map[contract.isPaid] as int) != 0,
      createdAt: DateTime.parse(map[contract.createdAt]),
      majorId: map[contract.majorId]?.toInt() ?? 0,
      contentType:
          (map[contract.contentType] as int).consultationContentTypeFromMap(),
      content: map[contract.content] ?? '',
      responseType:
          (map[contract.responseType] as int).consultantResponseTypeFromMap(),
      isAcceptingOffersFromAll:
          (map[contract.isAcceptingOffersFromAll] as int) != 0,
      isHelpRequested: (map[contract.isHelpRequested] as int) != 0,
      isHideNameFromConsultants:
          (map[contract.isHideNameFromConsultants] as int) != 0,
      isAcceptMinimumOfferByDefault:
          (map[contract.isAcceptMinimumOfferByDefault] as int) != 0,
      attendeeNumber: map[contract.attendeeNumber]?.toInt() ?? 0,
      status: (map[contract.status] as int).consultationStatusFromMap(),
      isUnscheduled: (map[contract.isUnscheduled] as int) != 0,
      visibilityStatus: (map[contract.visibilityStatus] as int)
          .consultationVisibilityFromMap(),
      publishedAt: DateTime.parse(map[contract.publishedAt]),
      isFavourite: map[contract.isFavourite] ?? false,
      isFastConsultation: (map[contract.isFastConsultation] as int) != 0,
      consultantId: map[contract.consultantId]?.toInt(),
      maximumPrice: map[contract.maximumPrice] != null
          ? num.tryParse(map[contract.maximumPrice])
          : null,
      appointmentDate: map[contract.appointmentDate] != null
          ? DateTime.parse(map[contract.appointmentDate])
          : null,
      maxTimeToReceiveOffers: map[contract.maxTimeToReceiveOffers] != null
          ? DateTime.parse(map[contract.maxTimeToReceiveOffers])
          : null,
      selectedConsultants: List<Consultant>.from(
          map[contract.selectedConsultants]?.map((x) => Consultant.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsultationInvoiceable.fromJson(String source) =>
      ConsultationInvoiceable.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConsultationInvoicable(id: $id, uuid: $uuid, userId: $userId, isPaid: $isPaid, createdAt: $createdAt, majorId: $majorId, consultantId: $consultantId, contentType: $contentType, content: $content, responseType: $responseType, maxTimeToReceiveOffers: $maxTimeToReceiveOffers, maximumPrice: $maximumPrice, isAcceptingOffersFromAll: $isAcceptingOffersFromAll, isHelpRequested: $isHelpRequested, isHideNameFromConsultants: $isHideNameFromConsultants, isAcceptMinimumOfferByDefault: $isAcceptMinimumOfferByDefault, attendeeNumber: $attendeeNumber, status: $status, isUnscheduled: $isUnscheduled, visibilityStatus: $visibilityStatus, publishedAt: $publishedAt, isFavourite: $isFavourite, isFastConsultation: $isFastConsultation, selectedConsultants: $selectedConsultants, appointmentDate: $appointmentDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConsultationInvoiceable &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.isPaid == isPaid &&
        other.createdAt == createdAt &&
        other.majorId == majorId &&
        other.consultantId == consultantId &&
        other.contentType == contentType &&
        other.content == content &&
        other.responseType == responseType &&
        other.maxTimeToReceiveOffers == maxTimeToReceiveOffers &&
        other.maximumPrice == maximumPrice &&
        other.isAcceptingOffersFromAll == isAcceptingOffersFromAll &&
        other.isHelpRequested == isHelpRequested &&
        other.isHideNameFromConsultants == isHideNameFromConsultants &&
        other.isAcceptMinimumOfferByDefault == isAcceptMinimumOfferByDefault &&
        other.attendeeNumber == attendeeNumber &&
        other.status == status &&
        other.isUnscheduled == isUnscheduled &&
        other.visibilityStatus == visibilityStatus &&
        other.publishedAt == publishedAt &&
        other.isFavourite == isFavourite &&
        other.isFastConsultation == isFastConsultation &&
        listEquals(other.selectedConsultants, selectedConsultants) &&
        other.appointmentDate == appointmentDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        userId.hashCode ^
        isPaid.hashCode ^
        createdAt.hashCode ^
        majorId.hashCode ^
        consultantId.hashCode ^
        contentType.hashCode ^
        content.hashCode ^
        responseType.hashCode ^
        maxTimeToReceiveOffers.hashCode ^
        maximumPrice.hashCode ^
        isAcceptingOffersFromAll.hashCode ^
        isHelpRequested.hashCode ^
        isHideNameFromConsultants.hashCode ^
        isAcceptMinimumOfferByDefault.hashCode ^
        attendeeNumber.hashCode ^
        status.hashCode ^
        isUnscheduled.hashCode ^
        visibilityStatus.hashCode ^
        publishedAt.hashCode ^
        isFavourite.hashCode ^
        isFastConsultation.hashCode ^
        selectedConsultants.hashCode ^
        appointmentDate.hashCode;
  }
}

class _ConsultationInvoicableContract extends InvoicableContract {
  final majorId = 'major_id';
  final consultantId = 'consultant_id';
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
  final isUnscheduled = 'is_unscheduled';
  final visibilityStatus = 'visibility_status';
  final publishedAt = 'published_at';
  final isFavourite = 'is_favourite';
  final isFastConsultation = 'is_fast_consultation';
  final selectedConsultants = 'selected_consultants';
}
