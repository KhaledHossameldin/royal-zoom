import 'resource.dart';

class Chat {
  num? id;
  String? uuid;
  num? resourceId;
  num? resourceType;
  Resource? resource;
  num? senderId;
  num? senderType;
  dynamic receiverId;
  num? receiverType;
  num? isActive;
  DateTime? createdAt;

  Chat({
    this.id,
    this.uuid,
    this.resourceId,
    this.resourceType,
    this.resource,
    this.senderId,
    this.senderType,
    this.receiverId,
    this.receiverType,
    this.isActive,
    this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: num.tryParse(json['id'].toString()),
        uuid: json['uuid']?.toString(),
        resourceId: num.tryParse(json['resource_id'].toString()),
        resourceType: num.tryParse(json['resource_type'].toString()),
        resource: json['resource'] == null
            ? null
            : Resource.fromJson(Map<String, dynamic>.from(json['resource'])),
        senderId: num.tryParse(json['sender_id'].toString()),
        senderType: num.tryParse(json['sender_type'].toString()),
        receiverId: json['receiver_id'],
        receiverType: num.tryParse(json['receiver_type'].toString()),
        isActive: num.tryParse(json['is_active'].toString()),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'].toString()),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (resourceId != null) 'resource_id': resourceId,
        if (resourceType != null) 'resource_type': resourceType,
        if (resource != null) 'resource': resource?.toJson(),
        if (senderId != null) 'sender_id': senderId,
        if (senderType != null) 'sender_type': senderType,
        if (receiverId != null) 'receiver_id': receiverId,
        if (receiverType != null) 'receiver_type': receiverType,
        if (isActive != null) 'is_active': isActive,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
      };
}
