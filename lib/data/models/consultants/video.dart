import 'dart:convert';

class Video {
  final int id;
  final String uuid;
  final int userId;
  final bool isUrl;
  final String video;

  Video({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.isUrl,
    required this.video,
  });

  Video copyWith({
    int? id,
    String? uuid,
    int? userId,
    bool? isUrl,
    String? video,
  }) {
    return Video(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      isUrl: isUrl ?? this.isUrl,
      video: video ?? this.video,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _VideoContract();
    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.isUrl: isUrl,
      contract.video: video,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    final contract = _VideoContract();
    return Video(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      isUrl: (map[contract.isUrl] as int) != 0,
      video: map[contract.video] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));

  @override
  String toString() =>
      'Video(id: $id, uuid: $uuid, userId: $userId, isUrl: $isUrl, video: $video)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Video &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.isUrl == isUrl &&
        other.video == video;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      userId.hashCode ^
      isUrl.hashCode ^
      video.hashCode;
}

class _VideoContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final isUrl = 'is_url';
  final video = 'video';
}
