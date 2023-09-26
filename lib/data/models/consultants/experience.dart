import 'dart:convert';

class Experience {
  final int id;
  final String uuid;
  final int userId;
  final String name;
  final String organization;
  final DateTime startDate;
  final DateTime endDate;

  Experience({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.name,
    required this.organization,
    required this.startDate,
    required this.endDate,
  });

  Experience copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? name,
    String? organization,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Experience(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      organization: organization ?? this.organization,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _ExperienceContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.name: name,
      contract.organization: organization,
      contract.startDate: startDate.toIso8601String(),
      contract.endDate: endDate.toIso8601String(),
    };
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    final contract = _ExperienceContract();
    return Experience(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
      organization: map[contract.organization] ?? '',
      startDate: DateTime.parse(map[contract.startDate]),
      endDate: DateTime.parse(map[contract.endDate]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Experience.fromJson(String source) =>
      Experience.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Experience(id: $id, uuid: $uuid, userId: $userId, name: $name, organization: $organization, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Experience &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.name == name &&
        other.organization == organization &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        organization.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}

class _ExperienceContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final name = 'name';
  final organization = 'organization';
  final startDate = 'start_date';
  final endDate = 'end_date';
}
