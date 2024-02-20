class Refundable {
  num? id;
  String? uuid;
  num? userId;
  num? consultantId;
  dynamic majorId;
  num? contentType;
  String? content;
  num? consultantResponseType;
  dynamic appointmentDate;
  dynamic maxTimeToReceiveOffers;
  dynamic maximumPrice;
  num? isAcceptingOffersFromAll;
  num? isHelpRequested;
  num? hideNameFromConsultants;
  num? acceptMinimumOfferByDefault;
  num? attendeeNumber;
  num? status;
  String? publishedAt;
  num? visibilityStatus;
  num? isPaid;
  num? isUnscheduled;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? isFastConsultation;
  dynamic consultants;
  bool? isFavourite;
  List<dynamic>? favorites;

  Refundable({
    this.id,
    this.uuid,
    this.userId,
    this.consultantId,
    this.majorId,
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
    this.publishedAt,
    this.visibilityStatus,
    this.isPaid,
    this.isUnscheduled,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isFastConsultation,
    this.consultants,
    this.isFavourite,
    this.favorites,
  });

  factory Refundable.fromJson(Map<String, dynamic> json) => Refundable(
        id: num.tryParse(json['id'].toString()),
        uuid: json['uuid']?.toString(),
        userId: num.tryParse(json['user_id'].toString()),
        consultantId: num.tryParse(json['consultant_id'].toString()),
        majorId: json['major_id'],
        contentType: num.tryParse(json['content_type'].toString()),
        content: json['content']?.toString(),
        consultantResponseType:
            num.tryParse(json['consultant_response_type'].toString()),
        appointmentDate: json['appointment_date'],
        maxTimeToReceiveOffers: json['max_time_to_receive_offers'],
        maximumPrice: json['maximum_price'],
        isAcceptingOffersFromAll:
            num.tryParse(json['is_accepting_offers_from_all'].toString()),
        isHelpRequested: num.tryParse(json['is_help_requested'].toString()),
        hideNameFromConsultants:
            num.tryParse(json['hide_name_from_consultants'].toString()),
        acceptMinimumOfferByDefault:
            num.tryParse(json['accept_minimum_offer_by_default'].toString()),
        attendeeNumber: num.tryParse(json['attendee_number'].toString()),
        status: num.tryParse(json['status'].toString()),
        publishedAt: json['published_at']?.toString(),
        visibilityStatus: num.tryParse(json['visibility_status'].toString()),
        isPaid: num.tryParse(json['is_paid'].toString()),
        isUnscheduled: num.tryParse(json['is_unscheduled'].toString()),
        deletedAt: json['deleted_at'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'].toString()),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.tryParse(json['updated_at'].toString()),
        isFastConsultation:
            num.tryParse(json['is_fast_consultation'].toString()),
        consultants: json['consultants'],
        isFavourite: json['is_favourite']?.toString().contains('true'),
        favorites: List<dynamic>.from(json['favorites'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (userId != null) 'user_id': userId,
        if (consultantId != null) 'consultant_id': consultantId,
        if (majorId != null) 'major_id': majorId,
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
        if (publishedAt != null) 'published_at': publishedAt,
        if (visibilityStatus != null) 'visibility_status': visibilityStatus,
        if (isPaid != null) 'is_paid': isPaid,
        if (isUnscheduled != null) 'is_unscheduled': isUnscheduled,
        if (deletedAt != null) 'deleted_at': deletedAt,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (updatedAt != null) 'updated_at': updatedAt?.toIso8601String(),
        if (isFastConsultation != null)
          'is_fast_consultation': isFastConsultation,
        if (consultants != null) 'consultants': consultants,
        if (isFavourite != null) 'is_favourite': isFavourite,
        if (favorites != null) 'favorites': favorites,
      };
}
