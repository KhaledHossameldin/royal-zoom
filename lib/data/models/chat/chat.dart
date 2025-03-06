import 'dart:convert';

import 'package:collection/collection.dart';

import 'resource.dart';
import 'sender.dart';

class Chat {
  final int id;
  final String uuid;
  final int resourceId;
  final int resourceType;
  final Resource resource;
  final int senderId;
  final int senderType;
  final int receiverId;
  final int receiverType;
  final int isActive;
  final DateTime createdAt;
  final int unreadMessagesCount;
  final Sender? sender;
  final dynamic receiver;

  Chat({
    required this.id,
    required this.uuid,
    required this.resourceId,
    required this.resourceType,
    required this.resource,
    required this.senderId,
    required this.senderType,
    required this.receiverId,
    required this.receiverType,
    required this.isActive,
    required this.createdAt,
    required this.unreadMessagesCount,
    required this.sender,
    required this.receiver,
  });

  @override
  String toString() {
    return 'Chat(id: $id, uuid: $uuid, resourceId: $resourceId, resourceType: $resourceType, resource: $resource, senderId: $senderId, senderType: $senderType, receiverId: $receiverId, receiverType: $receiverType, isActive: $isActive, createdAt: $createdAt, unreadMessagesCount: $unreadMessagesCount, sender: $sender, receiver: $receiver)';
  }

  factory Chat.fromMap(Map<String, dynamic> data) => Chat(
        id: int.parse(data['id'].toString()),
        uuid: data['uuid'].toString(),
        resourceId: int.parse(data['resource_id'].toString()),
        resourceType: int.parse(data['resource_type'].toString()),
        resource: Resource.fromMap(Map<String, dynamic>.from(data['resource'])),
        senderId: int.parse(data['sender_id'].toString()),
        senderType: int.parse(data['sender_type'].toString()),
        receiverId: data['receiver_id'],
        receiverType: int.parse(data['receiver_type'].toString()),
        isActive: int.parse(data['is_active'].toString()),
        createdAt: DateTime.parse(data['created_at'].toString()),
        unreadMessagesCount:
            int.parse(data['unread_messages_count'].toString()),
        sender: data['sender'] == null
            ? null
            : Sender.fromMap(Map<String, dynamic>.from(data['sender'])),
        receiver: data['receiver'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'uuid': uuid,
        'resource_id': resourceId,
        'resource_type': resourceType,
        'resource': resource.toMap(),
        'sender_id': senderId,
        'sender_type': senderType,
        'receiver_id': receiverId,
        'receiver_type': receiverType,
        'is_active': isActive,
        'created_at': createdAt.toIso8601String(),
        'unread_messages_count': unreadMessagesCount,
        if (sender != null) 'sender': sender?.toMap(),
        if (receiver != null) 'receiver': receiver,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Chat].
  factory Chat.fromJson(String data) {
    return Chat.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Chat] to a JSON string.
  String toJson() => json.encode(toMap());

  Chat copyWith({
    int? id,
    String? uuid,
    int? resourceId,
    int? resourceType,
    Resource? resource,
    int? senderId,
    int? senderType,
    dynamic receiverId,
    int? receiverType,
    int? isActive,
    DateTime? createdAt,
    int? unreadMessagesCount,
    Sender? sender,
    dynamic receiver,
  }) {
    return Chat(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      resourceId: resourceId ?? this.resourceId,
      resourceType: resourceType ?? this.resourceType,
      resource: resource ?? this.resource,
      senderId: senderId ?? this.senderId,
      senderType: senderType ?? this.senderType,
      receiverId: receiverId ?? this.receiverId,
      receiverType: receiverType ?? this.receiverType,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Chat) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      resourceId.hashCode ^
      resourceType.hashCode ^
      resource.hashCode ^
      senderId.hashCode ^
      senderType.hashCode ^
      receiverId.hashCode ^
      receiverType.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode ^
      unreadMessagesCount.hashCode ^
      sender.hashCode ^
      receiver.hashCode;
}
