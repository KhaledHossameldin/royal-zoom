abstract class Invoiceable {
  final int id;
  final String uuid;
  final int userId;
  final bool isPaid;
  final DateTime createdAt;

  Invoiceable({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.isPaid,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Invoicable(id: $id, uuid: $uuid, userId: $userId, isPaid: $isPaid, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Invoiceable &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.isPaid == isPaid &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        userId.hashCode ^
        isPaid.hashCode ^
        createdAt.hashCode;
  }
}

abstract class InvoicableContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final isPaid = 'is_paid';
  final createdAt = 'created_at';
}
