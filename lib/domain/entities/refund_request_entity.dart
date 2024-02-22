import '../../core/models/base_entity.dart';

class RefundRequestEntity extends BaseEntity {
  final num? id;
  final DateTime? createdAt;
  final String? amount;
  final String? transferType;
  final num? status;
  final String? details;
  RefundRequestEntity({
    this.id,
    this.createdAt,
    this.amount,
    this.transferType,
    this.status,
    this.details,
  });

  @override
  List<Object?> get props =>
      [id, createdAt, amount, transferType, status, details];
}
