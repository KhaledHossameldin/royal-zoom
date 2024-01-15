import 'dart:convert';

class Qualification {
  final int id;
  final String uuid;
  final int userId;
  final String name;
  final String organization;
  final num degree;
  final int year;

  Qualification({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.name,
    required this.organization,
    required this.degree,
    required this.year,
  });

  Qualification copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? name,
    String? organization,
    num? degree,
    int? year,
  }) {
    return Qualification(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      organization: organization ?? this.organization,
      degree: degree ?? this.degree,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _QualificationContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.name: name,
      contract.organization: organization,
      contract.degree: degree,
      contract.year: year,
    };
  }

  factory Qualification.fromMap(Map<String, dynamic> map) {
    final contract = _QualificationContract();
    return Qualification(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
      organization: map[contract.organization] ?? '',
      degree: map[contract.degree] ?? 0,
      year: map[contract.year]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Qualification.fromJson(String source) =>
      Qualification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Qualification(id: $id, uuid: $uuid, userId: $userId, name: $name, organization: $organization, degree: $degree, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Qualification &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.name == name &&
        other.organization == organization &&
        other.degree == degree &&
        other.year == year;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        organization.hashCode ^
        degree.hashCode ^
        year.hashCode;
  }
}

class _QualificationContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final name = 'name';
  final organization = 'organization';
  final degree = 'degree';
  final year = 'year';
}
