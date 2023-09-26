import 'dart:convert';

class Research {
  final int id;
  final String uuid;
  final int userId;
  final String name;

  Research({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.name,
  });

  Research copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? name,
  }) {
    return Research(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _ResearchContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.name: name,
    };
  }

  factory Research.fromMap(Map<String, dynamic> map) {
    final contract = _ResearchContract();
    return Research(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Research.fromJson(String source) =>
      Research.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Research(id: $id, uuid: $uuid, userId: $userId, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Research &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ uuid.hashCode ^ userId.hashCode ^ name.hashCode;
  }
}

class _ResearchContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final name = 'name';
}
