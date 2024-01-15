import 'dart:convert';

class Project {
  final int id;
  final String uuid;
  final int userId;
  final String name;
  final String organization;
  final num duration;

  Project({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.name,
    required this.organization,
    required this.duration,
  });

  Project copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? name,
    String? organization,
    num? duration,
  }) {
    return Project(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      organization: organization ?? this.organization,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _ProjectContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.name: name,
      contract.organization: organization,
      contract.duration: duration,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    final contract = _ProjectContract();
    return Project(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
      organization: map[contract.organization] ?? '',
      duration: map[contract.duration] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Project(id: $id, uuid: $uuid, userId: $userId, name: $name, organization: $organization, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.name == name &&
        other.organization == organization &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        organization.hashCode ^
        duration.hashCode;
  }
}

class _ProjectContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final name = 'name';
  final organization = 'organization';
  final duration = 'duration';
}
