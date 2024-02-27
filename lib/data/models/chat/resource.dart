import 'dart:convert';

import 'package:collection/collection.dart';

class Resource {
  num? id;
  String? uuid;
  String? amount;
  num? userId;
  num? transferType;
  num? status;
  dynamic transferReference;
  String? transferAttachment;
  dynamic transferDate;
  String? comment;
  String? reason;
  DateTime? createdAt;

  Resource({
    this.id,
    this.uuid,
    this.amount,
    this.userId,
    this.transferType,
    this.status,
    this.transferReference,
    this.transferAttachment,
    this.transferDate,
    this.comment,
    this.reason,
    this.createdAt,
  });

  @override
  String toString() {
    return 'Resource(id: $id, uuid: $uuid, amount: $amount, userId: $userId, transferType: $transferType, status: $status, transferReference: $transferReference, transferAttachment: $transferAttachment, transferDate: $transferDate, comment: $comment, reason: $reason, createdAt: $createdAt)';
  }

  factory Resource.fromMap(Map<String, dynamic> data) => Resource(
        id: num.tryParse(data['id'].toString()),
        uuid: data['uuid']?.toString(),
        amount: data['amount']?.toString(),
        userId: num.tryParse(data['user_id'].toString()),
        transferType: num.tryParse(data['transfer_type'].toString()),
        status: num.tryParse(data['status'].toString()),
        transferReference: data['transfer_reference'],
        transferAttachment: data['transfer_attachment']?.toString(),
        transferDate: data['transfer_date'],
        comment: data['comment']?.toString(),
        reason: data['reason']?.toString(),
        createdAt: data['created_at'] == null
            ? null
            : DateTime.tryParse(data['created_at'].toString()),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (amount != null) 'amount': amount,
        if (userId != null) 'user_id': userId,
        if (transferType != null) 'transfer_type': transferType,
        if (status != null) 'status': status,
        if (transferReference != null) 'transfer_reference': transferReference,
        if (transferAttachment != null)
          'transfer_attachment': transferAttachment,
        if (transferDate != null) 'transfer_date': transferDate,
        if (comment != null) 'comment': comment,
        if (reason != null) 'reason': reason,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Resource].
  factory Resource.fromJson(String data) {
    return Resource.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Resource] to a JSON string.
  String toJson() => json.encode(toMap());

  Resource copyWith({
    num? id,
    String? uuid,
    String? amount,
    num? userId,
    num? transferType,
    num? status,
    dynamic transferReference,
    String? transferAttachment,
    dynamic transferDate,
    String? comment,
    String? reason,
    DateTime? createdAt,
  }) {
    return Resource(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      amount: amount ?? this.amount,
      userId: userId ?? this.userId,
      transferType: transferType ?? this.transferType,
      status: status ?? this.status,
      transferReference: transferReference ?? this.transferReference,
      transferAttachment: transferAttachment ?? this.transferAttachment,
      transferDate: transferDate ?? this.transferDate,
      comment: comment ?? this.comment,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Resource) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      amount.hashCode ^
      userId.hashCode ^
      transferType.hashCode ^
      status.hashCode ^
      transferReference.hashCode ^
      transferAttachment.hashCode ^
      transferDate.hashCode ^
      comment.hashCode ^
      reason.hashCode ^
      createdAt.hashCode;
}
