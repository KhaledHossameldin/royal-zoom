import 'dart:convert';

import '../enums/chat_resource_type.dart';

class Rating {
  final int id;
  final ChatResourceType resourceType;
  final int resourceId;
  final int ratingValue;

  Rating({
    required this.id,
    required this.resourceType,
    required this.resourceId,
    required this.ratingValue,
  });

  Rating copyWith({
    int? id,
    ChatResourceType? resourceType,
    int? resourceId,
    int? ratingValue,
  }) {
    return Rating(
      id: id ?? this.id,
      resourceType: resourceType ?? this.resourceType,
      resourceId: resourceId ?? this.resourceId,
      ratingValue: ratingValue ?? this.ratingValue,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _RatingContract();
    return {
      contract.id: id,
      contract.resourceType: resourceType.toMap(),
      contract.resourceId: resourceId,
      contract.ratingValue: ratingValue,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    final contract = _RatingContract();
    return Rating(
      id: map[contract.id]?.toInt() ?? 0,
      resourceType:
          (map[contract.resourceType] as int).chatResourceTypeFromMap(),
      resourceId: map[contract.resourceId]?.toInt() ?? 0,
      ratingValue: map[contract.ratingValue]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Rating(id: $id, resourceType: $resourceType, resourceId: $resourceId, ratingValue: $ratingValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rating &&
        other.id == id &&
        other.resourceType == resourceType &&
        other.resourceId == resourceId &&
        other.ratingValue == ratingValue;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        resourceType.hashCode ^
        resourceId.hashCode ^
        ratingValue.hashCode;
  }
}

class _RatingContract {
  final id = 'id';
  final resourceType = 'resource_type';
  final resourceId = 'resource_id';
  final ratingValue = 'rating_value';
}
