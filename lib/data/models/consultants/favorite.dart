import 'dart:convert';

import '../favorite_category.dart';
import 'consultant.dart';

class FavoriteConsultant {
  final int id;
  final int consultantId;
  final int? favoriteCategoryId;
  Consultant consultant;
  final FavoriteCategory? favoriteCategory;

  FavoriteConsultant({
    required this.id,
    required this.consultantId,
    this.favoriteCategoryId,
    required this.consultant,
    this.favoriteCategory,
  });

  FavoriteConsultant copyWith({
    int? id,
    int? consultantId,
    int? favoriteCategoryId,
    Consultant? consultant,
    FavoriteCategory? favoriteCategory,
  }) {
    return FavoriteConsultant(
      id: id ?? this.id,
      consultantId: consultantId ?? this.consultantId,
      favoriteCategoryId: favoriteCategoryId ?? this.favoriteCategoryId,
      consultant: consultant ?? this.consultant,
      favoriteCategory: favoriteCategory ?? this.favoriteCategory,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _FavoriteConsultantContract();
    return {
      contract.id: id,
      contract.consultantId: consultantId,
      contract.favoriteCategoryId: favoriteCategoryId,
      contract.consultant: consultant.toMap(),
      contract.favouriteCategory: favoriteCategory?.toMap(),
    };
  }

  factory FavoriteConsultant.fromMap(Map<String, dynamic> map) {
    final contract = _FavoriteConsultantContract();
    return FavoriteConsultant(
      id: map[contract.id]?.toInt() ?? 0,
      consultantId: map[contract.consultantId]?.toInt() ?? 0,
      favoriteCategoryId: map[contract.favoriteCategoryId]?.toInt(),
      consultant: Consultant.fromMap(map[contract.consultant]),
      favoriteCategory: map[contract.favouriteCategory] != null
          ? FavoriteCategory.fromMap(map[contract.favouriteCategory])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteConsultant.fromJson(String source) =>
      FavoriteConsultant.fromMap(json.decode(source));

  @override
  String toString() =>
      'FavoriteConsultant(id: $id, consultantId: $consultantId, favoriteCategoryId: $favoriteCategoryId, consultant: $consultant, favoriteCategory: $favoriteCategory)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteConsultant &&
        other.id == id &&
        other.consultantId == consultantId &&
        other.favoriteCategoryId == favoriteCategoryId &&
        other.consultant == consultant &&
        other.favoriteCategory == favoriteCategory;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      consultantId.hashCode ^
      favoriteCategoryId.hashCode ^
      consultant.hashCode ^
      favoriteCategory.hashCode;
}

class _FavoriteConsultantContract {
  final id = 'id';
  final consultantId = 'consultant_id';
  final favoriteCategoryId = 'favourite_category_id	';
  final consultant = 'consultant';
  final favouriteCategory = 'favouriteCategory';
}
