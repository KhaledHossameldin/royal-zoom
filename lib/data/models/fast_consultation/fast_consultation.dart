import 'approved_request.dart';
import 'consultant.dart';
import 'invoice.dart';
import 'request.dart';
import 'user.dart';

class FastConsultation {
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
  num? maximumPrice;
  bool? isAcceptingOffersFromAll;
  dynamic isHelpRequested;
  num? hideNameFromConsultants;
  dynamic acceptMinimumOfferByDefault;
  num? attendeeNumber;
  num? status;
  bool? isPaid;
  num? isUnscheduled;
  dynamic visibilityStatus;
  DateTime? publishedAt;
  DateTime? createdAt;
  bool? isFavourite;
  bool? isFastConsultation;
  dynamic address;
  List<dynamic>? attachments;
  User? user;
  Consultant? consultant;
  List<Request>? requests;
  List<ApprovedRequest>? approvedRequests;
  Invoice? invoice;
  List<dynamic>? selectedConsultants;
  dynamic comments;
  String? appointmentStatus;
  dynamic userIdCancellation;
  dynamic cancellationStatus;
  dynamic cancellationReason;

  FastConsultation({
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
    this.address,
    this.attachments,
    this.user,
    this.consultant,
    this.requests,
    this.approvedRequests,
    this.invoice,
    this.selectedConsultants,
    this.comments,
    this.appointmentStatus,
    this.userIdCancellation,
    this.cancellationStatus,
    this.cancellationReason,
  });

  factory FastConsultation.fromJson(Map<String, dynamic> json) {
    return FastConsultation(
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
      maximumPrice: num.tryParse(json['maximum_price'].toString()),
      isAcceptingOffersFromAll:
          json['is_accepting_offers_from_all']?.toString().contains('true'),
      isHelpRequested: json['is_help_requested'],
      hideNameFromConsultants:
          num.tryParse(json['hide_name_from_consultants'].toString()),
      acceptMinimumOfferByDefault: json['accept_minimum_offer_by_default'],
      attendeeNumber: num.tryParse(json['attendee_number'].toString()),
      status: num.tryParse(json['status'].toString()),
      isPaid: json['is_paid']?.toString().contains('true'),
      isUnscheduled: num.tryParse(json['is_unscheduled'].toString()),
      visibilityStatus: json['visibility_status'],
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.tryParse(json['published_at'].toString()),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at'].toString()),
      isFavourite: json['is_favourite']?.toString().contains('true'),
      isFastConsultation:
          json['is_fast_consultation']?.toString().contains('true'),
      address: json['address'],
      attachments: List<dynamic>.from(json['attachments'] ?? []),
      user: json['user'] == null
          ? null
          : User.fromJson(Map<String, dynamic>.from(json['user'])),
      consultant: json['consultant'] == null
          ? null
          : Consultant.fromJson(Map<String, dynamic>.from(json['consultant'])),
      requests: (json['requests'] as List<dynamic>?)
          ?.map((e) => Request.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      approvedRequests: (json['approved_requests'] as List<dynamic>?)
          ?.map((e) => ApprovedRequest.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      invoice: json['invoice'] == null
          ? null
          : Invoice.fromJson(Map<String, dynamic>.from(json['invoice'])),
      selectedConsultants:
          List<dynamic>.from(json['selected_consultants'] ?? []),
      comments: json['comments'],
      appointmentStatus: json['appointment_status']?.toString(),
      userIdCancellation: json['user_id_cancellation'],
      cancellationStatus: json['cancellation_status'],
      cancellationReason: json['cancellation_reason'],
    );
  }

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
        if (publishedAt != null) 'published_at': publishedAt?.toIso8601String(),
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (isFavourite != null) 'is_favourite': isFavourite,
        if (isFastConsultation != null)
          'is_fast_consultation': isFastConsultation,
        if (address != null) 'address': address,
        if (attachments != null) 'attachments': attachments,
        if (user != null) 'user': user?.toJson(),
        if (consultant != null) 'consultant': consultant?.toJson(),
        if (requests != null)
          'requests': requests?.map((e) => e.toJson()).toList(),
        if (approvedRequests != null)
          'approved_requests':
              approvedRequests?.map((e) => e.toJson()).toList(),
        if (invoice != null) 'invoice': invoice?.toJson(),
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
