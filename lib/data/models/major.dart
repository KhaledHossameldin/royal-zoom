import 'dart:convert';

import '../enums/major_type.dart';

class Major {
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

  Major({
    required this.id,
    required this.uuid,
    this.parentId,
    required this.type,
    required this.name,
    required this.description,
    required this.isActive,
    required this.isVisible,
    required this.createdAt,
    required this.image,
    this.parent,
  });

  Major copyWith({
    int? id,
    String? uuid,
    int? parentId,
    MajorType? type,
    String? name,
    String? description,
    bool? isActive,
    bool? isVisible,
    DateTime? createdAt,
    String? image,
    Major? parent,
  }) =>
      Major(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        parentId: parentId ?? this.parentId,
        type: type ?? this.type,
        name: name ?? this.name,
        description: description ?? this.description,
        isActive: isActive ?? this.isActive,
        isVisible: isVisible ?? this.isVisible,
        createdAt: createdAt ?? this.createdAt,
        image: image ?? this.image,
        parent: parent ?? this.parent,
      );

  Map<String, dynamic> toMap() {
    final contract = _MajorContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.parentId: parentId,
      contract.type: type.toMap(),
      contract.name: name,
      contract.description: description,
      contract.isActive: isActive,
      contract.isVisible: isVisible,
      contract.createdAt: createdAt.toIso8601String(),
      contract.image: image,
      contract.parent: parent?.toMap(),
    };
  }

  factory Major.fromMap(Map<String, dynamic> map) {
    final contract = _MajorContract();

    return Major(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      parentId: map[contract.parentId]?.toInt(),
      type: (map[contract.type] as int).majorTypeFromMap(),
      name: map[contract.name] ?? '',
      description: map[contract.description] ?? '',
      isActive: map[contract.isActive] ?? false,
      isVisible: map[contract.isVisible] ?? false,
      createdAt: DateTime.parse(map[contract.createdAt]),
      image: map[contract.image] ?? '',
      parent: map[contract.parent] != null
          ? Major.fromMap(map[contract.parent])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Major.fromJson(String source) => Major.fromMap(json.decode(source));

  @override
  String toString() =>
      'Major(id: $id, uuid: $uuid, parentId: $parentId, type: $type, name: $name, description: $description, isActive: $isActive, isVisible: $isVisible, createdAt: $createdAt, image: $image, parent: $parent)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Major &&
        other.id == id &&
        other.uuid == uuid &&
        other.parentId == parentId &&
        other.type == type &&
        other.name == name &&
        other.description == description &&
        other.isActive == isActive &&
        other.isVisible == isVisible &&
        other.createdAt == createdAt &&
        other.image == image &&
        other.parent == parent;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      parentId.hashCode ^
      type.hashCode ^
      name.hashCode ^
      description.hashCode ^
      isActive.hashCode ^
      isVisible.hashCode ^
      createdAt.hashCode ^
      image.hashCode ^
      parent.hashCode;
}

class _MajorContract {
  final id = 'id';
  final uuid = 'uuid';
  final parentId = 'parent_id';
  final type = 'type';
  final name = 'name';
  final description = 'description';
  final isActive = 'is_active';
  final isVisible = 'is_visible';
  final createdAt = 'created_at';
  final image = 'image';
  final parent = 'parent';
}
