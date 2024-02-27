import 'dart:convert';

import 'package:collection/collection.dart';

class MajorVerificationRequest {
  num? id;
  String? uuid;
  num? majorId;
  num? status;
  DateTime? createdAt;

  MajorVerificationRequest({
    this.id,
    this.uuid,
    this.majorId,
    this.status,
    this.createdAt,
  });

  @override
  String toString() {
    return 'MajorVerificationRequest(id: $id, uuid: $uuid, majorId: $majorId, status: $status, createdAt: $createdAt)';
  }

  factory MajorVerificationRequest.fromMap(Map<String, dynamic> data) {
    return MajorVerificationRequest(
      id: num.tryParse(data['id'].toString()),
      uuid: data['uuid']?.toString(),
      majorId: num.tryParse(data['major_id'].toString()),
      status: num.tryParse(data['status'].toString()),
      createdAt: data['created_at'] == null
          ? null
          : DateTime.tryParse(data['created_at'].toString()),
    );
  }

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (majorId != null) 'major_id': majorId,
        if (status != null) 'status': status,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MajorVerificationRequest].
  factory MajorVerificationRequest.fromJson(String data) {
    return MajorVerificationRequest.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MajorVerificationRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  MajorVerificationRequest copyWith({
    num? id,
    String? uuid,
    num? majorId,
    num? status,
    DateTime? createdAt,
  }) {
    return MajorVerificationRequest(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      majorId: majorId ?? this.majorId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MajorVerificationRequest) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      majorId.hashCode ^
      status.hashCode ^
      createdAt.hashCode;
}
