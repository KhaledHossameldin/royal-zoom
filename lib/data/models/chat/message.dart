import 'dart:convert';

import 'package:just_audio/just_audio.dart';

import '../../enums/chat_content_type.dart';
import '../account.dart';

class ChatMessage {
  final int id;
  final String uuid;
  final ChatContentType contentType;
  final String content;
  final bool isSeen;
  final int senderId;
  final int senderType;
  final DateTime createdAt;
  final Account? sender;
  final AudioPlayer? player;

  ChatMessage({
    required this.id,
    required this.uuid,
    required this.contentType,
    required this.content,
    required this.isSeen,
    required this.senderId,
    required this.senderType,
    required this.createdAt,
    required this.sender,
    this.player,
  });

  ChatMessage copyWith({
    int? id,
    String? uuid,
    ChatContentType? contentType,
    String? content,
    bool? isSeen,
    int? senderId,
    int? senderType,
    DateTime? createdAt,
    Account? sender,
    AudioPlayer? player,
  }) =>
      ChatMessage(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        contentType: contentType ?? this.contentType,
        content: content ?? this.content,
        isSeen: isSeen ?? this.isSeen,
        senderId: senderId ?? this.senderId,
        senderType: senderType ?? this.senderType,
        createdAt: createdAt ?? this.createdAt,
        sender: sender ?? this.sender,
        player: player ?? this.player,
      );

  Map<String, dynamic> toMap() {
    final contract = _ChatMessageContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.contentType: contentType.toMap(),
      contract.content: content,
      contract.isSeen: isSeen,
      contract.senderId: senderId,
      contract.senderType: senderType,
      contract.createdAt: createdAt.millisecondsSinceEpoch,
      contract.sender: sender?.toMap(),
    };
  }

  factory ChatMessage.fromReceivedMap(Map<String, dynamic> map) {
    final contract = _ChatMessageContract();
    return ChatMessage(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      contentType: (map[contract.contentType] as int).chatContentTypeFromMap(),
      content: map[contract.content] ?? '',
      isSeen: map[contract.isSeen] ?? false,
      senderId: map[contract.senderId]?.toInt() ?? 0,
      senderType: map[contract.senderType]?.toInt() ?? 0,
      createdAt: DateTime.parse(map[contract.createdAt]),
      sender: null,
    );
  }

  factory ChatMessage.fromSentMap(Map<String, dynamic> map) {
    final contract = _ChatMessageContract();
    return ChatMessage(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      contentType:
          (int.parse(map[contract.contentType])).chatContentTypeFromMap(),
      content: map[contract.content] ?? '',
      isSeen: map[contract.isSeen] ?? false,
      senderId: map[contract.senderId]?.toInt() ?? 0,
      senderType: map[contract.senderType]?.toInt() ?? 0,
      createdAt: DateTime.parse(map[contract.createdAt]),
      sender: null,
    );
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    final contract = _ChatMessageContract();

    return ChatMessage(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      contentType: (map[contract.contentType] as int).chatContentTypeFromMap(),
      content: map[contract.content] ?? '',
      isSeen: (map[contract.isSeen] as int) != 0,
      senderId: map[contract.senderId]?.toInt() ?? 0,
      senderType: map[contract.senderType]?.toInt() ?? 0,
      createdAt: DateTime.parse(map[contract.createdAt]),
      sender: Account.fromMap(map[contract.sender]),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChatMessage(id: $id, uuid: $uuid, contentType: $contentType, content: $content, isSeen: $isSeen, senderId: $senderId, senderType: $senderType, createdAt: $createdAt, sender: $sender, player: $player)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatMessage &&
        other.id == id &&
        other.uuid == uuid &&
        other.contentType == contentType &&
        other.content == content &&
        other.isSeen == isSeen &&
        other.senderId == senderId &&
        other.senderType == senderType &&
        other.createdAt == createdAt &&
        other.sender == sender &&
        other.player == player;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      contentType.hashCode ^
      content.hashCode ^
      isSeen.hashCode ^
      senderId.hashCode ^
      senderType.hashCode ^
      createdAt.hashCode ^
      sender.hashCode ^
      player.hashCode;
}

class _ChatMessageContract {
  final id = 'id';
  final uuid = 'uuid';
  final contentType = 'content_type';
  final content = 'content';
  final isSeen = 'is_seen';
  final senderId = 'sender_id';
  final senderType = 'sender_type';
  final createdAt = 'created_at';
  final sender = 'sender';
}
