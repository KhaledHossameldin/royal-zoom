import 'dart:convert';

import 'package:collection/collection.dart';

import 'sender.dart';

class UserNotification {
  num? id;
  String? uuid;
  num? notifiableId;
  num? notifiableType;
  String? title;
  String? content;
  List<int>? notificationChannel;
  num? transmissionChannel;
  num? referenceId;
  num? referenceType;
  Sender? sender;
  num? sendTo;
  num? status;
  dynamic readAt;
  DateTime? createdAt;
  List<dynamic>? file;

  UserNotification({
    this.id,
    this.uuid,
    this.notifiableId,
    this.notifiableType,
    this.title,
    this.content,
    this.notificationChannel,
    this.transmissionChannel,
    this.referenceId,
    this.referenceType,
    this.sender,
    this.sendTo,
    this.status,
    this.readAt,
    this.createdAt,
    this.file,
  });

  @override
  String toString() {
    return 'UserNotification(id: $id, uuid: $uuid, notifiableId: $notifiableId, notifiableType: $notifiableType, title: $title, content: $content, notificationChannel: $notificationChannel, transmissionChannel: $transmissionChannel, referenceId: $referenceId, referenceType: $referenceType, sender: $sender, sendTo: $sendTo, status: $status, readAt: $readAt, createdAt: $createdAt, file: $file)';
  }

  factory UserNotification.fromMap(Map<String, dynamic> data) {
    return UserNotification(
      id: num.tryParse(data['id'].toString()),
      uuid: data['uuid']?.toString(),
      notifiableId: num.tryParse(data['notifiable_id'].toString()),
      notifiableType: num.tryParse(data['notifiable_type'].toString()),
      title: data['title']?.toString(),
      content: data['content']?.toString(),
      notificationChannel: List<int>.from(data['notification_channel'] ?? []),
      transmissionChannel:
          num.tryParse(data['transmission_channel'].toString()),
      referenceId: num.tryParse(data['reference_id'].toString()),
      referenceType: num.tryParse(data['reference_type'].toString()),
      sender: data['sender'] == null
          ? null
          : Sender.fromMap(Map<String, dynamic>.from(data['sender'])),
      sendTo: num.tryParse(data['send_to'].toString()),
      status: num.tryParse(data['status'].toString()),
      readAt: data['read_at'],
      createdAt: data['created_at'] == null
          ? null
          : DateTime.tryParse(data['created_at'].toString()),
      file: List<dynamic>.from(data['file'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (notifiableId != null) 'notifiable_id': notifiableId,
        if (notifiableType != null) 'notifiable_type': notifiableType,
        if (title != null) 'title': title,
        if (content != null) 'content': content,
        if (notificationChannel != null)
          'notification_channel': notificationChannel,
        if (transmissionChannel != null)
          'transmission_channel': transmissionChannel,
        if (referenceId != null) 'reference_id': referenceId,
        if (referenceType != null) 'reference_type': referenceType,
        if (sender != null) 'sender': sender?.toMap(),
        if (sendTo != null) 'send_to': sendTo,
        if (status != null) 'status': status,
        if (readAt != null) 'read_at': readAt,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (file != null) 'file': file,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserNotification].
  factory UserNotification.fromJson(String data) {
    return UserNotification.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserNotification] to a JSON string.
  String toJson() => json.encode(toMap());

  UserNotification copyWith({
    num? id,
    String? uuid,
    num? notifiableId,
    num? notifiableType,
    String? title,
    String? content,
    List<int>? notificationChannel,
    num? transmissionChannel,
    num? referenceId,
    num? referenceType,
    Sender? sender,
    num? sendTo,
    num? status,
    dynamic readAt,
    DateTime? createdAt,
    List<dynamic>? file,
  }) {
    return UserNotification(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      notifiableId: notifiableId ?? this.notifiableId,
      notifiableType: notifiableType ?? this.notifiableType,
      title: title ?? this.title,
      content: content ?? this.content,
      notificationChannel: notificationChannel ?? this.notificationChannel,
      transmissionChannel: transmissionChannel ?? this.transmissionChannel,
      referenceId: referenceId ?? this.referenceId,
      referenceType: referenceType ?? this.referenceType,
      sender: sender ?? this.sender,
      sendTo: sendTo ?? this.sendTo,
      status: status ?? this.status,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      file: file ?? this.file,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserNotification) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      notifiableId.hashCode ^
      notifiableType.hashCode ^
      title.hashCode ^
      content.hashCode ^
      notificationChannel.hashCode ^
      transmissionChannel.hashCode ^
      referenceId.hashCode ^
      referenceType.hashCode ^
      sender.hashCode ^
      sendTo.hashCode ^
      status.hashCode ^
      readAt.hashCode ^
      createdAt.hashCode ^
      file.hashCode;
}
