import '../../../core/models/base_entity.dart';
import '../../../core/models/base_model.dart';
import '../../../domain/entities/refund_request_entity.dart';
import '../authentication/user.dart';
import 'refundable.dart';

class RefundRequestResponse extends BaseModel {
  num? id;
  String? uuid;
  String? amount;
  num? userId;
  num? refundableId;
  String? refundableType;
  num? transferType;
  num? status;
  String? comment;
  DateTime? createdAt;
  User? user;
  Refundable? refundable;

  RefundRequestResponse({
    this.id,
    this.uuid,
    this.amount,
    this.userId,
    this.refundableId,
    this.refundableType,
    this.transferType,
    this.status,
    this.comment,
    this.createdAt,
    this.user,
    this.refundable,
  });

  factory RefundRequestResponse.fromJson(Map<String, dynamic> json) {
    return RefundRequestResponse(
      id: num.tryParse(json['id'].toString()),
      uuid: json['uuid']?.toString(),
      amount: json['amount']?.toString(),
      userId: num.tryParse(json['user_id'].toString()),
      refundableId: num.tryParse(json['refundable_id'].toString()),
      refundableType: json['refundable_type']?.toString(),
      transferType: num.tryParse(json['transfer_type'].toString()),
      status: num.tryParse(json['status'].toString()),
      comment: json['comment']?.toString(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at'].toString()),
      user: json['user'] == null
          ? null
          : User.fromMap(Map<String, dynamic>.from(json['user'])),
      refundable: json['refundable'] == null
          ? null
          : Refundable.fromJson(Map<String, dynamic>.from(json['refundable'])),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (amount != null) 'amount': amount,
        if (userId != null) 'user_id': userId,
        if (refundableId != null) 'refundable_id': refundableId,
        if (refundableType != null) 'refundable_type': refundableType,
        if (transferType != null) 'transfer_type': transferType,
        if (status != null) 'status': status,
        if (comment != null) 'comment': comment,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (user != null) 'user': user?.toJson(),
        if (refundable != null) 'refundable': refundable?.toJson(),
      };

  @override
  BaseEntity toEntity() {
    return RefundRequestEntity(
      id: id,
      amount: amount,
      createdAt: createdAt,
      details: comment,
      status: status,
      transferType: refundableType,
    );
  }
}
