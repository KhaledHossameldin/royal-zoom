class Invoice {
  num? id;
  String? uuid;
  num? userId;
  String? referenceNumber;
  dynamic ndc;
  num? paymentMethod;
  String? amount;
  String? discount;
  String? tax;
  String? total;
  String? paidAt;
  dynamic refundedAt;
  dynamic cancelledAt;
  num? isPayrolled;
  DateTime? createdAt;

  Invoice({
    this.id,
    this.uuid,
    this.userId,
    this.referenceNumber,
    this.ndc,
    this.paymentMethod,
    this.amount,
    this.discount,
    this.tax,
    this.total,
    this.paidAt,
    this.refundedAt,
    this.cancelledAt,
    this.isPayrolled,
    this.createdAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: num.tryParse(json['id'].toString()),
        uuid: json['uuid']?.toString(),
        userId: num.tryParse(json['user_id'].toString()),
        referenceNumber: json['reference_number']?.toString(),
        ndc: json['ndc'],
        paymentMethod: num.tryParse(json['payment_method'].toString()),
        amount: json['amount']?.toString(),
        discount: json['discount']?.toString(),
        tax: json['tax']?.toString(),
        total: json['total']?.toString(),
        paidAt: json['paid_at']?.toString(),
        refundedAt: json['refunded_at'],
        cancelledAt: json['cancelled_at'],
        isPayrolled: num.tryParse(json['is_payrolled'].toString()),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'].toString()),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (userId != null) 'user_id': userId,
        if (referenceNumber != null) 'reference_number': referenceNumber,
        if (ndc != null) 'ndc': ndc,
        if (paymentMethod != null) 'payment_method': paymentMethod,
        if (amount != null) 'amount': amount,
        if (discount != null) 'discount': discount,
        if (tax != null) 'tax': tax,
        if (total != null) 'total': total,
        if (paidAt != null) 'paid_at': paidAt,
        if (refundedAt != null) 'refunded_at': refundedAt,
        if (cancelledAt != null) 'cancelled_at': cancelledAt,
        if (isPayrolled != null) 'is_payrolled': isPayrolled,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
      };
}
