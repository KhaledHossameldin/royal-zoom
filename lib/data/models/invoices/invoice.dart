import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../enums/invoice_type.dart';
import '../../enums/payment_method.dart';
import 'invoicable/consultation.dart';
import 'invoicable/invoicable.dart';
import 'invoicable/wallet_charge.dart';
import 'transaction.dart';

class Invoice {
  final int id;
  final String uuid;
  final int userId;
  final String referenceNumber;
  final PaymentMethod paymentMethod;
  final num amount;
  final num discount;
  final num tax;
  final num total;
  final DateTime createdAt;
  final Invoiceable invoiceable;
  final List<Transaction> transactions;
  final String? ndc;
  final DateTime? paidAt;
  final DateTime? refundedAt;
  final DateTime? cancelledAt;

  Invoice({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.referenceNumber,
    required this.paymentMethod,
    required this.amount,
    required this.discount,
    required this.tax,
    required this.total,
    required this.createdAt,
    required this.invoiceable,
    required this.transactions,
    this.ndc,
    this.paidAt,
    this.refundedAt,
    this.cancelledAt,
  });

  DateTime? get lastDate {
    if (cancelledAt != null) {
      return cancelledAt;
    }
    if (refundedAt != null) {
      return refundedAt;
    }
    if (paidAt != null) {
      return paidAt;
    }
    return createdAt;
  }

  Invoice copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? referenceNumber,
    PaymentMethod? paymentMethod,
    num? amount,
    num? discount,
    num? tax,
    num? total,
    DateTime? createdAt,
    Invoiceable? invoiceable,
    List<Transaction>? transactions,
    String? ndc,
    DateTime? paidAt,
    DateTime? refundedAt,
    DateTime? cancelledAt,
  }) {
    return Invoice(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      invoiceable: invoiceable ?? this.invoiceable,
      transactions: transactions ?? this.transactions,
      ndc: ndc ?? this.ndc,
      paidAt: paidAt ?? this.paidAt,
      refundedAt: refundedAt ?? this.refundedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _InvoiceContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.referenceNumber: referenceNumber,
      contract.paymentMethod: paymentMethod.toMap(),
      contract.amount: amount.toString(),
      contract.discount: discount.toString(),
      contract.tax: tax.toString(),
      contract.total: total.toString(),
      contract.createdAt: createdAt.toIso8601String(),
      contract.invoiceable: invoiceable is ConsultationInvoiceable
          ? (invoiceable as ConsultationInvoiceable).toMap()
          : (invoiceable as WalletChargeInvoiceable).toMap(),
      contract.transactions: transactions.map((x) => x.toMap()).toList(),
      contract.ndc: ndc,
      contract.paidAt: paidAt?.toIso8601String(),
      contract.refundedAt: refundedAt?.toIso8601String(),
      contract.cancelledAt: cancelledAt?.toIso8601String(),
    };
  }

  factory Invoice.fromMap(
    Map<String, dynamic> map, {
    required InvoiceType type,
  }) {
    final contract = _InvoiceContract();

    return Invoice(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      referenceNumber: map[contract.referenceNumber] ?? '',
      paymentMethod:
          (map[contract.paymentMethod] as int).paymentMethodFromMap(),
      amount: num.tryParse(map[contract.amount] as String) ?? 0,
      discount: num.tryParse(map[contract.discount] as String) ?? 0,
      tax: num.tryParse(map[contract.tax] as String) ?? 0,
      total: num.tryParse(map[contract.total] as String) ?? 0,
      createdAt: DateTime.parse(map[contract.createdAt]),
      invoiceable: type == InvoiceType.consultation
          ? ConsultationInvoiceable.fromMap(map[contract.invoiceable])
          : WalletChargeInvoiceable.fromMap(map[contract.invoiceable]),
      transactions: List<Transaction>.from(
          map[contract.transactions]?.map((x) => Transaction.fromMap(x))),
      ndc: map[contract.ndc],
      paidAt: map[contract.paidAt] != null
          ? DateTime.parse(map[contract.paidAt])
          : null,
      refundedAt: map[contract.refundedAt] != null
          ? DateTime.parse(map[contract.refundedAt])
          : null,
      cancelledAt: map[contract.cancelledAt] != null
          ? DateTime.parse(map[contract.cancelledAt])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source, {required InvoiceType type}) =>
      Invoice.fromMap(json.decode(source), type: type);

  @override
  String toString() {
    return 'Invoice(id: $id, uuid: $uuid, userId: $userId, referenceNumber: $referenceNumber, paymentMethod: $paymentMethod, amount: $amount, discount: $discount, tax: $tax, total: $total, createdAt: $createdAt, invoiceable: $invoiceable, transactions: $transactions, ndc: $ndc, paidAt: $paidAt, refundedAt: $refundedAt, cancelledAt: $cancelledAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Invoice &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.referenceNumber == referenceNumber &&
        other.paymentMethod == paymentMethod &&
        other.amount == amount &&
        other.discount == discount &&
        other.tax == tax &&
        other.total == total &&
        other.createdAt == createdAt &&
        other.invoiceable == invoiceable &&
        listEquals(other.transactions, transactions) &&
        other.ndc == ndc &&
        other.paidAt == paidAt &&
        other.refundedAt == refundedAt &&
        other.cancelledAt == cancelledAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        userId.hashCode ^
        referenceNumber.hashCode ^
        paymentMethod.hashCode ^
        amount.hashCode ^
        discount.hashCode ^
        tax.hashCode ^
        total.hashCode ^
        createdAt.hashCode ^
        invoiceable.hashCode ^
        transactions.hashCode ^
        ndc.hashCode ^
        paidAt.hashCode ^
        refundedAt.hashCode ^
        cancelledAt.hashCode;
  }
}

class _InvoiceContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final referenceNumber = 'reference_number';
  final ndc = 'ndc';
  final paymentMethod = 'payment_method';
  final amount = 'amount';
  final discount = 'discount';
  final tax = 'tax';
  final total = 'total';
  final paidAt = 'paid_at';
  final refundedAt = 'refunded_at';
  final cancelledAt = 'cancelled_at';
  final createdAt = 'created_at';
  final invoiceable = 'invoiceable';
  final transactions = 'transactions';
}
