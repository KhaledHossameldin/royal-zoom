class Invoiceable {
  num? id;
  String? uuid;
  String? amount;
  num? userId;
  num? isPaid;
  DateTime? createdAt;

  Invoiceable({
    this.id,
    this.uuid,
    this.amount,
    this.userId,
    this.isPaid,
    this.createdAt,
  });

  factory Invoiceable.fromJson(Map<String, dynamic> json) => Invoiceable(
        id: num.tryParse(json['id'].toString()),
        uuid: json['uuid']?.toString(),
        amount: json['amount']?.toString(),
        userId: num.tryParse(json['user_id'].toString()),
        isPaid: num.tryParse(json['is_paid'].toString()),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'].toString()),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (amount != null) 'amount': amount,
        if (userId != null) 'user_id': userId,
        if (isPaid != null) 'is_paid': isPaid,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
      };
}
