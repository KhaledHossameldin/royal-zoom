import 'dart:convert';

import '../../../utilities/extensions.dart';
import '../../enums/chat_resource_type.dart';
import '../account.dart';
import '../consultants/consultant.dart';

class Chat {
  final int id;
  final String uuid;
  final int resourceId;
  final ChatResourceType resourceType;
  final int senderId;
  final int senderType;
  final int? receiverId;
  final int receiverType;
  final bool isActive;
  final DateTime createdAt;
  final Account sender;
  final Consultant? receiver;

  Chat({
    required this.id,
    required this.uuid,
    required this.resourceId,
    required this.resourceType,
    required this.senderId,
    required this.senderType,
    required this.receiverId,
    required this.receiverType,
    required this.isActive,
    required this.createdAt,
    required this.sender,
    required this.receiver,
  });

  Chat copyWith({
    int? id,
    String? uuid,
    int? resourceId,
    ChatResourceType? resourceType,
    int? senderId,
    int? senderType,
    int? receiverId,
    int? receiverType,
    bool? isActive,
    DateTime? createdAt,
    Account? sender,
    Consultant? receiver,
  }) =>
      Chat(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        resourceId: resourceId ?? this.resourceId,
        resourceType: resourceType ?? this.resourceType,
        senderId: senderId ?? this.senderId,
        senderType: senderType ?? this.senderType,
        receiverId: receiverId ?? this.receiverId,
        receiverType: receiverType ?? this.receiverType,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
      );

  Map<String, dynamic> toMap() {
    final contract = _ChatContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.resourceId: resourceId,
      contract.resourceType: resourceType.toMap(),
      contract.senderId: senderId,
      contract.senderType: senderType,
      contract.receiverId: receiverId,
      contract.receiverType: receiverType,
      contract.isActive: isActive.toInt,
      contract.createdAt: createdAt.toIso8601String(),
      contract.sender: sender.toMap(),
      contract.receiver: receiver?.toMap(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    final contract = _ChatContract();

    return Chat(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      resourceId: map[contract.resourceId]?.toInt() ?? 0,
      resourceType:
          (map[contract.resourceType] as int).chatResourceTypeFromMap(),
      senderId: map[contract.senderId]?.toInt() ?? 0,
      senderType: map[contract.senderType]?.toInt() ?? 0,
      receiverId: map[contract.receiverId]?.toInt(),
      receiverType: map[contract.receiverType]?.toInt() ?? 0,
      isActive: (map[contract.isActive] as int) != 0,
      createdAt: DateTime.parse(map[contract.createdAt]),
      sender: Account.fromMap(map[contract.sender]),
      receiver: map[contract.receiver] != null
          ? Consultant.fromMap(map[contract.receiver])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Chat(id: $id, uuid: $uuid, resourceId: $resourceId, resourceType: $resourceType, senderId: $senderId, senderType: $senderType, receiverId: $receiverId, receiverType: $receiverType, isActive: $isActive, createdAt: $createdAt, sender: $sender, receiver: $receiver)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat &&
        other.id == id &&
        other.uuid == uuid &&
        other.resourceId == resourceId &&
        other.resourceType == resourceType &&
        other.senderId == senderId &&
        other.senderType == senderType &&
        other.receiverId == receiverId &&
        other.receiverType == receiverType &&
        other.isActive == isActive &&
        other.createdAt == createdAt &&
        other.sender == sender &&
        other.receiver == receiver;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      resourceId.hashCode ^
      resourceType.hashCode ^
      senderId.hashCode ^
      senderType.hashCode ^
      receiverId.hashCode ^
      receiverType.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode ^
      sender.hashCode ^
      receiver.hashCode;
}

class _ChatContract {
  final id = 'id';
  final uuid = 'uuid';
  final resourceId = 'resource_id';
  final resourceType = 'resource_type';
  final senderId = 'sender_id';
  final senderType = 'sender_type';
  final receiverId = 'receiver_id';
  final receiverType = 'receiver_type';
  final isActive = 'is_active';
  final createdAt = 'created_at';
  final sender = 'sender';
  final receiver = 'receiver';
}
