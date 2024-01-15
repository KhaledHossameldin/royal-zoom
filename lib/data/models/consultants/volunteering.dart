import 'dart:convert';

class Volunteering {
  final int id;
  final String uuid;
  final int userId;
  final String name;

  Volunteering({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.name,
  });

  Volunteering copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? name,
  }) {
    return Volunteering(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _VolunteeringContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.name: name,
    };
  }

  factory Volunteering.fromMap(Map<String, dynamic> map) {
    final contract = _VolunteeringContract();
    return Volunteering(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Volunteering.fromJson(String source) =>
      Volunteering.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Volunteering(id: $id, uuid: $uuid, userId: $userId, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Volunteering &&
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

class _VolunteeringContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final name = 'name';
}
