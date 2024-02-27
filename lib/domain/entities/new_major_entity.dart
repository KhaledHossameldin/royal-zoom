import '../../core/models/base_entity.dart';
import '../../data/models/new_chat/new_chat.dart';

class NewMajorEntity extends BaseEntity {
  final int? status;
  final int? id;
  final DateTime? createdAt;
  final String? neededMajor;
  final String? parentMajor;
  final NewChat? chat;
  NewMajorEntity({
    this.status,
    this.id,
    this.createdAt,
    this.neededMajor,
    this.parentMajor,
    this.chat,
  });

  @override
  List<Object?> get props => [id, status, createdAt, neededMajor, parentMajor];
}
