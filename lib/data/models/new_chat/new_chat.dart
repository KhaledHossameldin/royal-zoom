import 'receiver.dart';
import 'resource.dart';
import 'sender.dart';

class NewChat {
  num? id;
  String? uuid;
  num? resourceId;
  num? resourceType;
  Resource? resource;
  num? senderId;
  num? senderType;
  num? receiverId;
  num? receiverType;
  num? isActive;
  DateTime? createdAt;
  num? unreadMessagesCount;
  Sender? sender;
  Receiver? receiver;

  NewChat({
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
    this.unreadMessagesCount,
    this.sender,
    this.receiver,
  });

  factory NewChat.fromJson(Map<String, dynamic> json) => NewChat(
        id: num.tryParse(json['id'].toString()),
        uuid: json['uuid']?.toString(),
        resourceId: num.tryParse(json['resource_id'].toString()),
        resourceType: num.tryParse(json['resource_type'].toString()),
        resource: json['resource'] == null
            ? null
            : Resource.fromJson(Map<String, dynamic>.from(json['resource'])),
        senderId: num.tryParse(json['sender_id'].toString()),
        senderType: num.tryParse(json['sender_type'].toString()),
        receiverId: num.tryParse(json['receiver_id'].toString()),
        receiverType: num.tryParse(json['receiver_type'].toString()),
        isActive: num.tryParse(json['is_active'].toString()),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'].toString()),
        unreadMessagesCount:
            num.tryParse(json['unread_messages_count'].toString()),
        sender: json['sender'] == null
            ? null
            : Sender.fromJson(Map<String, dynamic>.from(json['sender'])),
        receiver: json['receiver'] == null
            ? null
            : Receiver.fromJson(Map<String, dynamic>.from(json['receiver'])),
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
        if (unreadMessagesCount != null)
          'unread_messages_count': unreadMessagesCount,
        if (sender != null) 'sender': sender?.toJson(),
        if (receiver != null) 'receiver': receiver?.toJson(),
      };
}
