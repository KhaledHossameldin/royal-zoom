import '../../../core/models/base_entity.dart';
import '../../../core/models/base_model.dart';
import '../../../domain/entities/wallet_payment_intention_entity.dart';
import 'invoiceable.dart';

class WalletPaymentIntention extends BaseModel {
  num? id;
  String? uuid;
  num? userId;
  String? referenceNumber;
  String? ndc;
  num? paymentMethod;
  num? amount;
  num? discount;
  num? tax;
  num? total;
  dynamic paidAt;
  dynamic cancelledAt;
  DateTime? createdAt;
  Invoiceable? invoiceable;
  List<dynamic>? transactions;

  WalletPaymentIntention({
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
    this.cancelledAt,
    this.createdAt,
    this.invoiceable,
    this.transactions,
  });

  factory WalletPaymentIntention.fromJson(Map<String, dynamic> json) {
    return WalletPaymentIntention(
      id: num.tryParse(json['id'].toString()),
      uuid: json['uuid']?.toString(),
      userId: num.tryParse(json['user_id'].toString()),
      referenceNumber: json['reference_number']?.toString(),
      ndc: json['ndc']?.toString(),
      paymentMethod: num.tryParse(json['payment_method'].toString()),
      amount: num.tryParse(json['amount'].toString()),
      discount: num.tryParse(json['discount'].toString()),
      tax: num.tryParse(json['tax'].toString()),
      total: num.tryParse(json['total'].toString()),
      paidAt: json['paid_at'],
      cancelledAt: json['cancelled_at'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at'].toString()),
      invoiceable: json['invoiceable'] == null
          ? null
          : Invoiceable.fromJson(
              Map<String, dynamic>.from(json['invoiceable'])),
      transactions: List<dynamic>.from(json['transactions'] ?? []),
    );
  }

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
        if (cancelledAt != null) 'cancelled_at': cancelledAt,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (invoiceable != null) 'invoiceable': invoiceable?.toJson(),
        if (transactions != null) 'transactions': transactions,
      };

  @override
  BaseEntity toEntity() {
    return WalletPaymentIntentionEnitity(ndc: ndc!);
  }
}
