import '../../core/models/base_entity.dart';
import '../../data/enums/major_type.dart';
import '../../data/models/major.dart';

class MajorEntity extends BaseEntity {
  final int id;
  final String uuid;
  final int? parentId;
  final MajorType type;
  final String name;
  final String description;
  final bool isActive;
  final bool isVisible;
  final DateTime createdAt;
  final String image;
  final Major? parent;

  MajorEntity({
    required this.id,
    required this.uuid,
    required this.type,
    required this.name,
    required this.description,
    required this.isActive,
    required this.isVisible,
    required this.createdAt,
    required this.image,
    this.parentId,
    this.parent,
  });

  @override
  List<Object?> get props => [
        id,
        uuid,
        parentId,
        type,
        name,
        description,
        isActive,
        isVisible,
        createdAt,
        image,
        parent,
      ];
}
