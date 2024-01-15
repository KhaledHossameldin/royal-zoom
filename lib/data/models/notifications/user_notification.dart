import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../enums/notification_channel.dart';
import '../../enums/notification_send_to.dart';
import '../../enums/notification_status.dart';
import 'sender.dart';

class UserNotification {
  final int id;
  final String uuid;
  final String title;
  final String content;
  final NotificationChannel notificationChannel;
  final NotificationChannel transmissionChannel;
  final NotificationSender sender;
  final NotificationSendTo sendTo;
  final NotificationStatus status;
  final DateTime createdAt;
  final List<String> files;
  final DateTime? readAt;

  UserNotification({
    required this.id,
    required this.uuid,
    required this.title,
    required this.content,
    required this.notificationChannel,
    required this.transmissionChannel,
    required this.sender,
    required this.sendTo,
    required this.status,
    required this.createdAt,
    required this.files,
    this.readAt,
  });

  UserNotification copyWith({
    int? id,
    String? uuid,
    String? title,
    String? content,
    NotificationChannel? notificationChannel,
    NotificationChannel? transmissionChannel,
    NotificationSender? sender,
    NotificationSendTo? sendTo,
    NotificationStatus? status,
    DateTime? createdAt,
    List<String>? files,
    DateTime? readAt,
  }) {
    return UserNotification(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      content: content ?? this.content,
      notificationChannel: notificationChannel ?? this.notificationChannel,
      transmissionChannel: transmissionChannel ?? this.transmissionChannel,
      sender: sender ?? this.sender,
      sendTo: sendTo ?? this.sendTo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      files: files ?? this.files,
      readAt: readAt ?? this.readAt,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _UserNotificationContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.title: title,
      contract.content: content,
      contract.notificationChannel: notificationChannel.toMap(),
      contract.transmissionChannel: transmissionChannel.toMap(),
      contract.sender: sender.toMap(),
      contract.sendTo: sendTo.toMap(),
      contract.status: status.toMap(),
      contract.createdAt: createdAt.toIso8601String(),
      contract.files: files,
      contract.readAt: readAt?.toIso8601String(),
    };
  }

  factory UserNotification.fromMap(Map<String, dynamic> map) {
    final contract = _UserNotificationContract();
    return UserNotification(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      title: map[contract.title] ?? '',
      content: map[contract.content] ?? '',
      notificationChannel: (map[contract.notificationChannel] as int)
          .notificationChannelFromMap(),
      transmissionChannel: (map[contract.transmissionChannel] as int)
          .notificationChannelFromMap(),
      sender: NotificationSender.fromMap(map[contract.sender]),
      sendTo: (map[contract.sendTo] as int).notificationSendToFromMap(),
      status: (map[contract.status] as int).notificationStatusFromMap(),
      createdAt: DateTime.parse(map[contract.createdAt]),
      files: List<String>.from(map[contract.files]),
      readAt: map[contract.readAt] != null
          ? DateTime.parse(map[contract.readAt])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserNotification.fromJson(String source) =>
      UserNotification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserNotification(id: $id, uuid: $uuid, title: $title, content: $content, notificationChannel: $notificationChannel, transmissionChannel: $transmissionChannel, sender: $sender, sendTo: $sendTo, status: $status, createdAt: $createdAt, files: $files, readAt: $readAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserNotification &&
        other.id == id &&
        other.uuid == uuid &&
        other.title == title &&
        other.content == content &&
        other.notificationChannel == notificationChannel &&
        other.transmissionChannel == transmissionChannel &&
        other.sender == sender &&
        other.sendTo == sendTo &&
        other.status == status &&
        other.createdAt == createdAt &&
        listEquals(other.files, files) &&
        other.readAt == readAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        title.hashCode ^
        content.hashCode ^
        notificationChannel.hashCode ^
        transmissionChannel.hashCode ^
        sender.hashCode ^
        sendTo.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        files.hashCode ^
        readAt.hashCode;
  }
}

class _UserNotificationContract {
  final id = 'id';
  final uuid = 'uuid';
  final title = 'title';
  final content = 'content';
  final notificationChannel = 'notification_channel';
  final transmissionChannel = 'transmission_channel';
  final sender = 'sender';
  final sendTo = 'send_to';
  final status = 'status';
  final readAt = 'read_at';
  final createdAt = 'created_at';
  final files = 'file';
}
