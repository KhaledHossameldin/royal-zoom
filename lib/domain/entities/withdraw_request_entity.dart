import '../../core/models/base_entity.dart';
import '../../core/utils/date_utils/date_utils.dart';
import '../../data/enums/new_major_status.dart';
import '../../data/models/meta.dart';
import '../../data/models/withdraw_request_response/chat.dart';

class WithdrawRequesEntity extends BaseEntity {
  final num? id;
  final DateTime? createdAt;
  final String? amount;
  final num? transferType;
  final num? status;
  final Chat? chat;
  final Meta? meta;
  WithdrawRequesEntity({
    this.id,
    this.createdAt,
    this.amount,
    this.transferType,
    this.status,
    this.chat,
    this.meta,
  });

  String getStatus() {
    return status?.toInt().newMajorStatusFromMap().name ?? '';
  }

  String getCreatedAtTime() {
    return DateUtil.dateWithTime(createdAt!);
  }

  @override
  List<Object?> get props => [];
}
