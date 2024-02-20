import '../../core/models/base_entity.dart';

class NewMajorEntity extends BaseEntity {
  final int? status;
  final int? id;
  final DateTime? createdAt;
  final String? neededMajor;
  final String? parentMajor;
  NewMajorEntity({
    this.status,
    this.id,
    this.createdAt,
    this.neededMajor,
    this.parentMajor,
  });

  @override
  List<Object?> get props => [id, status, createdAt, neededMajor, parentMajor];
}
