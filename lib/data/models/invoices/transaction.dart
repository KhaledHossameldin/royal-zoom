import 'dart:convert';

class Transaction {
  final int id;
  final String uuid;
  final int invoiceId;
  final int userId;
  final int paymentMethod;
  final num amount;
  final bool isSuccessful;
  final bool isRefunded;
  final int type;
  final String? failureReason;

  Transaction({
    required this.id,
    required this.uuid,
    required this.invoiceId,
    required this.userId,
    required this.paymentMethod,
    required this.amount,
    required this.isSuccessful,
    required this.isRefunded,
    required this.type,
    this.failureReason,
  });

  Transaction copyWith({
    int? id,
    String? uuid,
    int? invoiceId,
    int? userId,
    int? paymentMethod,
    num? amount,
    bool? isSuccessful,
    bool? isRefunded,
    int? type,
    String? failureReason,
  }) =>
      Transaction(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        invoiceId: invoiceId ?? this.invoiceId,
        userId: userId ?? this.userId,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        amount: amount ?? this.amount,
        isSuccessful: isSuccessful ?? this.isSuccessful,
        isRefunded: isRefunded ?? this.isRefunded,
        type: type ?? this.type,
        failureReason: failureReason ?? this.failureReason,
      );

  Map<String, dynamic> toMap() {
    final contract = _TransactionContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.invoiceId: invoiceId,
      contract.userId: userId,
      contract.paymentMethod: paymentMethod,
      contract.amount: amount,
      contract.isSuccessful: isSuccessful,
      contract.isRefunded: isRefunded,
      contract.type: type,
      contract.failureReason: failureReason,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    final contract = _TransactionContract();

    return Transaction(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      invoiceId: map[contract.invoiceId]?.toInt() ?? 0,
      userId: map[contract.userId]?.toInt() ?? 0,
      paymentMethod: map[contract.paymentMethod]?.toInt() ?? 0,
      amount: num.tryParse(map[contract.amount]) ?? 0,
      isSuccessful: map[contract.isSuccessful] != 0,
      isRefunded: map[contract.isRefunded] != 0,
      type: map[contract.type]?.toInt() ?? 0,
      failureReason: map[contract.failureReason],
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));

  @override
  String toString() =>
      'Transaction(id: $id, uuid: $uuid, invoiceId: $invoiceId, userId: $userId, paymentMethod: $paymentMethod, amount: $amount, isSuccessful: $isSuccessful, isRefunded: $isRefunded, type: $type, failureReason: $failureReason)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction &&
        other.id == id &&
        other.uuid == uuid &&
        other.invoiceId == invoiceId &&
        other.userId == userId &&
        other.paymentMethod == paymentMethod &&
        other.amount == amount &&
        other.isSuccessful == isSuccessful &&
        other.isRefunded == isRefunded &&
        other.type == type &&
        other.failureReason == failureReason;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      invoiceId.hashCode ^
      userId.hashCode ^
      paymentMethod.hashCode ^
      amount.hashCode ^
      isSuccessful.hashCode ^
      isRefunded.hashCode ^
      type.hashCode ^
      failureReason.hashCode;
}

class _TransactionContract {
  final id = 'id';
  final uuid = 'uuid';
  final invoiceId = 'invoice_id';
  final userId = 'user_id';
  final paymentMethod = 'payment_method';
  final amount = 'amount';
  final isSuccessful = 'is_successful';
  final failureReason = 'failure_reason';
  final type = 'type';
  final isRefunded = 'is_refunded';
}
