import 'dart:convert';

//         "courses": [
//             {
//                 "id": 1,
//                 "uuid": "9a0146aa-348f-467e-8c83-e4d337b84f91",
//                 "user_id": 3,
//                 "name": "ICDL",
//                 "organization": "جامعة القاهرة",
//                 "hours": 60,
//                 "is_student": 1
//             },
//             {
//                 "id": 2,
//                 "uuid": "9a0147d0-cddc-40f9-80b2-3174e3cba156",
//                 "user_id": 3,
//                 "name": "مهارات قيادية",
//                 "organization": "تأهيل",
//                 "hours": 40,
//                 "is_student": 0
//             }
//         ],
class Course {
  final int id;
  final String uuid;
  final int userId;
  final String name;
  final String organization;
  final num hours;
  final bool isStudent;

  Course({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.name,
    required this.organization,
    required this.hours,
    required this.isStudent,
  });

  Course copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? name,
    String? organization,
    num? hours,
    bool? isStudent,
  }) {
    return Course(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      organization: organization ?? this.organization,
      hours: hours ?? this.hours,
      isStudent: isStudent ?? this.isStudent,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _CourseContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.name: name,
      contract.organization: organization,
      contract.hours: hours,
      contract.isStudent: isStudent,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    final contract = _CourseContract();
    return Course(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
      organization: map[contract.organization] ?? '',
      hours: map[contract.hours] ?? 0,
      isStudent: (map[contract.isStudent] as int) != 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course(id: $id, uuid: $uuid, userId: $userId, name: $name, organization: $organization, hours: $hours, isStudent: $isStudent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.name == name &&
        other.organization == organization &&
        other.hours == hours &&
        other.isStudent == isStudent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        organization.hashCode ^
        hours.hashCode ^
        isStudent.hashCode;
  }
}

class _CourseContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final name = 'name';
  final organization = 'organization';
  final hours = 'hours';
  final isStudent = 'is_student';
}
