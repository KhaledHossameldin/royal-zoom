import '../../../core/models/base_entity.dart';
import '../../../core/models/base_model.dart';
import '../../../domain/entities/new_major_entity.dart';
import '../major.dart';

class NewMajorRequestResponse extends BaseModel {
  num? id;
  String? uuid;
  num? majorId;
  String? name;
  String? description;
  num? status;
  DateTime? createdAt;
  Major? major;

  NewMajorRequestResponse({
    this.id,
    this.uuid,
    this.majorId,
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.major,
  });

  factory NewMajorRequestResponse.fromJson(Map<String, dynamic> json) {
    return NewMajorRequestResponse(
      id: num.tryParse(json['id'].toString()),
      uuid: json['uuid']?.toString(),
      majorId: num.tryParse(json['major_id'].toString()),
      name: json['name']?.toString(),
      description: json['description']?.toString(),
      status: num.tryParse(json['status'].toString()),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at'].toString()),
      major: json['major'] == null
          ? null
          : Major.fromMap(Map<String, dynamic>.from(json['major'])),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (majorId != null) 'major_id': majorId,
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (status != null) 'status': status,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (major != null) 'major': major?.toJson(),
      };

  @override
  BaseEntity toEntity() {
    return NewMajorEntity(
      id: id?.toInt(),
      createdAt: createdAt,
      neededMajor: name,
      parentMajor: major?.name,
      status: status?.toInt(),
    );
  }
}
