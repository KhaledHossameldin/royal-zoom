import 'consultant.dart';
import 'major.dart';
import 'user.dart';

class Consultation {
  num? id;
  String? uuid;
  num? majorId;
  num? consultantId;
  num? userId;
  num? contentType;
  String? content;
  num? consultantResponseType;
  dynamic appointmentDate;
  String? maxTimeToReceiveOffers;
  String? maximumPrice;
  num? isAcceptingOffersFromAll;
  num? isHelpRequested;
  num? hideNameFromConsultants;
  num? acceptMinimumOfferByDefault;
  num? attendeeNumber;
  num? status;
  num? isPaid;
  num? isUnscheduled;
  num? visibilityStatus;
  String? publishedAt;
  DateTime? createdAt;
  bool? isFavourite;
  num? isFastConsultation;
  Major? major;
  User? user;
  Consultant? consultant;
  List<dynamic>? selectedConsultants;
  dynamic comments;
  String? appointmentStatus;
  dynamic userIdCancellation;
  dynamic cancellationStatus;
  dynamic cancellationReason;

  Consultation({
    this.id,
    this.uuid,
    this.majorId,
    this.consultantId,
    this.userId,
    this.contentType,
    this.content,
    this.consultantResponseType,
    this.appointmentDate,
    this.maxTimeToReceiveOffers,
    this.maximumPrice,
    this.isAcceptingOffersFromAll,
    this.isHelpRequested,
    this.hideNameFromConsultants,
    this.acceptMinimumOfferByDefault,
    this.attendeeNumber,
    this.status,
    this.isPaid,
    this.isUnscheduled,
    this.visibilityStatus,
    this.publishedAt,
    this.createdAt,
    this.isFavourite,
    this.isFastConsultation,
    this.major,
    this.user,
    this.consultant,
    this.selectedConsultants,
    this.comments,
    this.appointmentStatus,
    this.userIdCancellation,
    this.cancellationStatus,
    this.cancellationReason,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) => Consultation(
        id: num.tryParse(json['id'].toString()),
        uuid: json['uuid']?.toString(),
        majorId: num.tryParse(json['major_id'].toString()),
        consultantId: num.tryParse(json['consultant_id'].toString()),
        userId: num.tryParse(json['user_id'].toString()),
        contentType: num.tryParse(json['content_type'].toString()),
        content: json['content']?.toString(),
        consultantResponseType:
            num.tryParse(json['consultant_response_type'].toString()),
        appointmentDate: json['appointment_date'],
        maxTimeToReceiveOffers: json['max_time_to_receive_offers']?.toString(),
        maximumPrice: json['maximum_price']?.toString(),
        isAcceptingOffersFromAll:
            num.tryParse(json['is_accepting_offers_from_all'].toString()),
        isHelpRequested: num.tryParse(json['is_help_requested'].toString()),
        hideNameFromConsultants:
            num.tryParse(json['hide_name_from_consultants'].toString()),
        acceptMinimumOfferByDefault:
            num.tryParse(json['accept_minimum_offer_by_default'].toString()),
        attendeeNumber: num.tryParse(json['attendee_number'].toString()),
        status: num.tryParse(json['status'].toString()),
        isPaid: num.tryParse(json['is_paid'].toString()),
        isUnscheduled: num.tryParse(json['is_unscheduled'].toString()),
        visibilityStatus: num.tryParse(json['visibility_status'].toString()),
        publishedAt: json['published_at']?.toString(),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'].toString()),
        isFavourite: json['is_favourite']?.toString().contains('true'),
        isFastConsultation:
            num.tryParse(json['is_fast_consultation'].toString()),
        major: json['major'] == null
            ? null
            : Major.fromJson(Map<String, dynamic>.from(json['major'])),
        user: json['user'] == null
            ? null
            : User.fromJson(Map<String, dynamic>.from(json['user'])),
        consultant: json['consultant'] == null
            ? null
            : Consultant.fromJson(
                Map<String, dynamic>.from(json['consultant'])),
        selectedConsultants:
            List<dynamic>.from(json['selected_consultants'] ?? []),
        comments: json['comments'],
        appointmentStatus: json['appointment_status']?.toString(),
        userIdCancellation: json['user_id_cancellation'],
        cancellationStatus: json['cancellation_status'],
        cancellationReason: json['cancellation_reason'],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (majorId != null) 'major_id': majorId,
        if (consultantId != null) 'consultant_id': consultantId,
        if (userId != null) 'user_id': userId,
        if (contentType != null) 'content_type': contentType,
        if (content != null) 'content': content,
        if (consultantResponseType != null)
          'consultant_response_type': consultantResponseType,
        if (appointmentDate != null) 'appointment_date': appointmentDate,
        if (maxTimeToReceiveOffers != null)
          'max_time_to_receive_offers': maxTimeToReceiveOffers,
        if (maximumPrice != null) 'maximum_price': maximumPrice,
        if (isAcceptingOffersFromAll != null)
          'is_accepting_offers_from_all': isAcceptingOffersFromAll,
        if (isHelpRequested != null) 'is_help_requested': isHelpRequested,
        if (hideNameFromConsultants != null)
          'hide_name_from_consultants': hideNameFromConsultants,
        if (acceptMinimumOfferByDefault != null)
          'accept_minimum_offer_by_default': acceptMinimumOfferByDefault,
        if (attendeeNumber != null) 'attendee_number': attendeeNumber,
        if (status != null) 'status': status,
        if (isPaid != null) 'is_paid': isPaid,
        if (isUnscheduled != null) 'is_unscheduled': isUnscheduled,
        if (visibilityStatus != null) 'visibility_status': visibilityStatus,
        if (publishedAt != null) 'published_at': publishedAt,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (isFavourite != null) 'is_favourite': isFavourite,
        if (isFastConsultation != null)
          'is_fast_consultation': isFastConsultation,
        if (major != null) 'major': major?.toJson(),
        if (user != null) 'user': user?.toJson(),
        if (consultant != null) 'consultant': consultant?.toJson(),
        if (selectedConsultants != null)
          'selected_consultants': selectedConsultants,
        if (comments != null) 'comments': comments,
        if (appointmentStatus != null) 'appointment_status': appointmentStatus,
        if (userIdCancellation != null)
          'user_id_cancellation': userIdCancellation,
        if (cancellationStatus != null)
          'cancellation_status': cancellationStatus,
        if (cancellationReason != null)
          'cancellation_reason': cancellationReason,
      };
}
