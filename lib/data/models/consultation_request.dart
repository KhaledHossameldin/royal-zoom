import 'dart:convert';

import '../enums/consultation_request_type.dart';
import 'consultants/consultant.dart';

class ConsultationRequest {
  final int id;
  final String uuid;
  final int consultationId;
  final int userId;
  final ConsultationRequestStatus status;
  final bool isAcceptingOffersFromAll;
  final bool isFree;
  final num price;
  final String comment;
  final int responseDuration;
  final String responseDurationType;
  // last_appointment_request
  final DateTime? appointmentDate;
  final Consultant? consultant;

  ConsultationRequest({
    required this.id,
    required this.uuid,
    required this.consultationId,
    required this.userId,
    required this.status,
    required this.isAcceptingOffersFromAll,
    required this.isFree,
    required this.price,
    required this.comment,
    required this.responseDuration,
    required this.responseDurationType,
    this.appointmentDate,
    this.consultant,
  });

  ConsultationRequest copyWith({
    int? id,
    String? uuid,
    int? consultationId,
    int? userId,
    ConsultationRequestStatus? status,
    bool? isAcceptingOffersFromAll,
    bool? isFree,
    num? price,
    String? comment,
    int? responseDuration,
    String? responseDurationType,
    DateTime? appointmentDate,
    Consultant? consultant,
  }) {
    return ConsultationRequest(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      consultationId: consultationId ?? this.consultationId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      isAcceptingOffersFromAll:
          isAcceptingOffersFromAll ?? this.isAcceptingOffersFromAll,
      isFree: isFree ?? this.isFree,
      price: price ?? this.price,
      comment: comment ?? this.comment,
      responseDuration: responseDuration ?? this.responseDuration,
      responseDurationType: responseDurationType ?? this.responseDurationType,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      consultant: consultant ?? this.consultant,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = AssignedRequestContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.consultationId: consultationId,
      contract.userId: userId,
      contract.status: status.toMap(),
      contract.isAcceptingOffersFromAll: isAcceptingOffersFromAll,
      contract.isFree: isFree,
      contract.price: price,
      contract.comment: comment,
      contract.responseDuration: responseDuration,
      contract.responseDurationType: responseDurationType,
      contract.appointmentDate: appointmentDate?.toIso8601String(),
      contract.consultant: consultant?.toMap(),
    };
  }

  factory ConsultationRequest.fromMap(Map<String, dynamic> map) {
    final contract = AssignedRequestContract();
    return ConsultationRequest(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      consultationId: map[contract.consultationId]?.toInt() ?? 0,
      userId: map[contract.userId]?.toInt() ?? 0,
      status: (map[contract.status] as int).consultationRequestTypeFromMap(),
      isAcceptingOffersFromAll:
          (map[contract.isAcceptingOffersFromAll] as int) != 0,
      isFree: (map[contract.isFree] as int) != 0,
      price: num.tryParse((map[contract.price].toString())) ?? 0.0,
      comment: map[contract.comment] ?? '',
      responseDuration: map[contract.responseDuration]?.toInt() ?? 0,
      responseDurationType: map[contract.responseDurationType] ?? '',
      appointmentDate: map[contract.appointmentDate] != null
          ? DateTime.parse(map[contract.appointmentDate])
          : null,
      consultant: map[contract.consultant] != null
          ? Consultant.fromMap(map[contract.consultant])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsultationRequest.fromJson(String source) =>
      ConsultationRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AssignedRequest(id: $id, uuid: $uuid, consultationId: $consultationId, userId: $userId, status: $status, isAcceptingOffersFromAll: $isAcceptingOffersFromAll, isFree: $isFree, price: $price, comment: $comment, responseDuration: $responseDuration, responseDurationType: $responseDurationType, appointmentDate: $appointmentDate, consultant: $consultant)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConsultationRequest &&
        other.id == id &&
        other.uuid == uuid &&
        other.consultationId == consultationId &&
        other.userId == userId &&
        other.status == status &&
        other.isAcceptingOffersFromAll == isAcceptingOffersFromAll &&
        other.isFree == isFree &&
        other.price == price &&
        other.comment == comment &&
        other.responseDuration == responseDuration &&
        other.responseDurationType == responseDurationType &&
        other.appointmentDate == appointmentDate &&
        other.consultant == consultant;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        consultationId.hashCode ^
        userId.hashCode ^
        status.hashCode ^
        isAcceptingOffersFromAll.hashCode ^
        isFree.hashCode ^
        price.hashCode ^
        comment.hashCode ^
        responseDuration.hashCode ^
        responseDurationType.hashCode ^
        appointmentDate.hashCode ^
        consultant.hashCode;
  }
}

class AssignedRequestContract {
  final String id = 'id';
  final String uuid = 'uuid';
  final String consultationId = 'consultation_id';
  final String userId = 'user_id';
  final String status = 'status';
  final String appointmentDate = 'appointment_date';
  final String isAcceptingOffersFromAll = 'is_accepting_offers_from_all';
  final String isFree = 'is_free';
  final String price = 'price';
  final String comment = 'comment';
  final String responseDuration = 'response_duration';
  final String responseDurationType = 'response_duration_type';
  final String lastAppointmentRequest = 'last_appointment_request';
  final String consultant = 'consultant';
}
