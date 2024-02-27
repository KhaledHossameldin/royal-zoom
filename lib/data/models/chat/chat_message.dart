import 'dart:convert';

import '../../enums/chat_content_type.dart';
import 'sender.dart';

class ChatMessage {
  num? id;
  String? uuid;
  ChatContentType? contentType;
  String? content;
  num? isSeen;
  num? senderId;
  num? senderType;
  DateTime? createdAt;
  Sender? sender;

  ChatMessage({
    this.id,
    this.uuid,
    this.contentType,
    this.content,
    this.isSeen,
    this.senderId,
    this.senderType,
    this.createdAt,
    this.sender,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> data) => ChatMessage(
        id: num.tryParse(data['id'].toString()),
        uuid: data['uuid']?.toString(),
        contentType: int.tryParse(data['content_type'].toString())
            ?.chatContentTypeFromMap(),
        content: data['content']?.toString(),
        isSeen: num.tryParse(data['is_seen'].toString()),
        senderId: num.tryParse(data['sender_id'].toString()),
        senderType: num.tryParse(data['sender_type'].toString()),
        createdAt: data['created_at'] == null
            ? null
            : DateTime.tryParse(data['created_at'].toString()),
        sender: data['sender'] == null
            ? null
            : Sender.fromMap(Map<String, dynamic>.from(data['sender'])),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (contentType != null) 'content_type': contentType,
        if (content != null) 'content': content,
        if (isSeen != null) 'is_seen': isSeen,
        if (senderId != null) 'sender_id': senderId,
        if (senderType != null) 'sender_type': senderType,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (sender != null) 'sender': sender?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChatMessage].
  factory ChatMessage.fromJson(String data) {
    return ChatMessage.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChatMessage] to a JSON string.
  String toJson() => json.encode(toMap());
}
