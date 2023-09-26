import 'dart:convert';

class ConsultantLanguage {
  final int id;
  final String uuid;
  final int userId;
  final String name;
  final int level;

  ConsultantLanguage({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.name,
    required this.level,
  });

  ConsultantLanguage copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? name,
    int? level,
  }) {
    return ConsultantLanguage(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _ConsultantLanguageContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.name: name,
      contract.level: level,
    };
  }

  factory ConsultantLanguage.fromMap(Map<String, dynamic> map) {
    final contract = _ConsultantLanguageContract();
    return ConsultantLanguage(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
      level: map[contract.level]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsultantLanguage.fromJson(String source) =>
      ConsultantLanguage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConsultantLanguage(id: $id, uuid: $uuid, userId: $userId, name: $name, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConsultantLanguage &&
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

class _ConsultantLanguageContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final name = 'name';
  final level = 'level';
}
