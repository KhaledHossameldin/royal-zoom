import 'dart:convert';

//         "skills": [
//             {
//                 "id": 1,
//                 "uuid": "9a0141de-68cc-4c00-a9e5-908a653a4969",
//                 "user_id": 3,
//                 "name": "الحاسب الآلي",
//                 "level": 3
//             }
//         ],
class Skill {
  final int id;
  final String uuid;
  final int userId;
  final String name;
  final int level;

  Skill({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.name,
    required this.level,
  });

  Skill copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? name,
    int? level,
  }) {
    return Skill(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _SkillContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.name: name,
      contract.level: level,
    };
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    final contract = _SkillContract();
    return Skill(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
      level: map[contract.level]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Skill.fromJson(String source) => Skill.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Skill(id: $id, uuid: $uuid, userId: $userId, name: $name, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Skill &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.name == name &&
        other.level == level;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        level.hashCode;
  }
}

class _SkillContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final name = 'name';
  final level = 'level';
}
