import 'dart:convert';

import '../../../../utilities/extensions.dart';
import 'invoicable.dart';

class WalletChargeInvoiceable extends Invoiceable {
  final num amount;

  WalletChargeInvoiceable({
    required super.id,
    required super.uuid,
    required super.userId,
    required super.isPaid,
    required super.createdAt,
    required this.amount,
  });

  WalletChargeInvoiceable copyWith({
    int? id,
    String? uuid,
    int? userId,
    bool? isPaid,
    DateTime? createdAt,
    num? amount,
  }) {
    return WalletChargeInvoiceable(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt ?? this.createdAt,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _WalletChargeInvoicableContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.isPaid: isPaid.toInt,
      contract.createdAt: createdAt.toIso8601String(),
      contract.amount: amount.toString(),
    };
  }

  factory WalletChargeInvoiceable.fromMap(Map<String, dynamic> map) {
    final contract = _WalletChargeInvoicableContract();

    return WalletChargeInvoiceable(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      isPaid: (map[contract.isPaid] as int) != 0,
      createdAt: DateTime.parse(map[contract.createdAt]),
      amount: num.tryParse(map[contract.amount] as String) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletChargeInvoiceable.fromJson(String source) =>
      WalletChargeInvoiceable.fromMap(json.decode(source));

  @override
  String toString() =>
      'WalletChargeInvoicable(id: $id, uuid: $uuid, userId: $userId, isPaid: $isPaid, createdAt: $createdAt, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletChargeInvoiceable &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.isPaid == isPaid &&
        other.createdAt == createdAt &&
        other.amount == amount;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      userId.hashCode ^
      isPaid.hashCode ^
      createdAt.hashCode ^
      amount.hashCode;
}

class _WalletChargeInvoicableContract extends InvoicableContract {
  final amount = 'amount';
}
