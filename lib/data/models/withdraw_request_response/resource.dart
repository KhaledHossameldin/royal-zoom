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
  dynamic reason;
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

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        id: num.tryParse(json['id'].toString()),
        uuid: json['uuid']?.toString(),
        amount: json['amount']?.toString(),
        userId: num.tryParse(json['user_id'].toString()),
        transferType: num.tryParse(json['transfer_type'].toString()),
        status: num.tryParse(json['status'].toString()),
        transferReference: json['transfer_reference'],
        transferAttachment: json['transfer_attachment']?.toString(),
        transferDate: json['transfer_date'],
        comment: json['comment']?.toString(),
        reason: json['reason'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'].toString()),
      );

  Map<String, dynamic> toJson() => {
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
}
