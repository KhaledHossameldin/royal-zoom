import '../../../core/models/base_entity.dart';
import '../../../core/models/base_model.dart';
import '../../../domain/entities/new_major_entity.dart';
import '../major.dart';
import '../new_chat/new_chat.dart';
import '../withdraw_request_response/chat.dart';

class MajorVerificationRequestResponse extends BaseModel {
  num? id;
  String? uuid;
  num? majorId;
  num? status;
  DateTime? createdAt;
  Major? major;
  NewChat? chat;

  MajorVerificationRequestResponse({
    this.id,
    this.uuid,
    this.majorId,
    this.status,
    this.createdAt,
    this.major,
    this.chat,
  });

  factory MajorVerificationRequestResponse.fromJson(Map<String, dynamic> json) {
    return MajorVerificationRequestResponse(
      id: num.tryParse(json['id'].toString()),
      uuid: json['uuid']?.toString(),
      majorId: num.tryParse(json['major_id'].toString()),
      status: num.tryParse(json['status'].toString()),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at'].toString()),
      major: json['major'] == null
          ? null
          : Major.fromMap(Map<String, dynamic>.from(json['major'])),
      chat: json['chat'] == null ? null : NewChat.fromJson(json['chat']),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (majorId != null) 'major_id': majorId,
        if (status != null) 'status': status,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (major != null) 'major': major?.toJson(),
        if (chat != null) 'chat': chat?.toJson(),
      };

  @override
  BaseEntity toEntity() {
    return NewMajorEntity(
      createdAt: createdAt,
      id: id?.toInt(),
      neededMajor: major?.name,
      parentMajor: major?.parent?.name,
      status: status?.toInt(),
      chat: chat,
    );
  }
}
