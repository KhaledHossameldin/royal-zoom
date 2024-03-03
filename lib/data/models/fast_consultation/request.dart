import 'consultation.dart';

class Request {
  num? id;
  String? uuid;
  num? consultationId;
  num? userId;
  num? status;
  dynamic appointmentDate;
  num? isAcceptingOffersFromAll;
  num? isFree;
  String? price;
  dynamic comment;
  dynamic responseDuration;
  dynamic responseDurationType;
  String? maxTimeToReply;
  Consultation? consultation;

  Request({
    this.id,
    this.uuid,
    this.consultationId,
    this.userId,
    this.status,
    this.appointmentDate,
    this.isAcceptingOffersFromAll,
    this.isFree,
    this.price,
    this.comment,
    this.responseDuration,
    this.responseDurationType,
    this.maxTimeToReply,
    this.consultation,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: num.tryParse(json['id'].toString()),
        uuid: json['uuid']?.toString(),
        consultationId: num.tryParse(json['consultation_id'].toString()),
        userId: num.tryParse(json['user_id'].toString()),
        status: num.tryParse(json['status'].toString()),
        appointmentDate: json['appointment_date'],
        isAcceptingOffersFromAll:
            num.tryParse(json['is_accepting_offers_from_all'].toString()),
        isFree: num.tryParse(json['is_free'].toString()),
        price: json['price']?.toString(),
        comment: json['comment'],
        responseDuration: json['response_duration'],
        responseDurationType: json['response_duration_type'],
        maxTimeToReply: json['max_time_to_reply']?.toString(),
        consultation: json['consultation'] == null
            ? null
            : Consultation.fromJson(
                Map<String, dynamic>.from(json['consultation'])),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (consultationId != null) 'consultation_id': consultationId,
        if (userId != null) 'user_id': userId,
        if (status != null) 'status': status,
        if (appointmentDate != null) 'appointment_date': appointmentDate,
        if (isAcceptingOffersFromAll != null)
          'is_accepting_offers_from_all': isAcceptingOffersFromAll,
        if (isFree != null) 'is_free': isFree,
        if (price != null) 'price': price,
        if (comment != null) 'comment': comment,
        if (responseDuration != null) 'response_duration': responseDuration,
        if (responseDurationType != null)
          'response_duration_type': responseDurationType,
        if (maxTimeToReply != null) 'max_time_to_reply': maxTimeToReply,
        if (consultation != null) 'consultation': consultation?.toJson(),
      };
}
