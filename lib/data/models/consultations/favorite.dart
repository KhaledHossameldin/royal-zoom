import 'dart:convert';

import 'consultation.dart';

class FavoriteConsultation {
  final int id;
  final int consultationId;
  final int? favoriteCategoryId;
  Consultation consultation;
  // TODO: favoriteCategory

  FavoriteConsultation({
    required this.id,
    required this.consultationId,
    this.favoriteCategoryId,
    required this.consultation,
  });

  FavoriteConsultation copyWith({
    int? id,
    int? consultationId,
    int? favoriteCategoryId,
    Consultation? consultation,
  }) {
    return FavoriteConsultation(
      id: id ?? this.id,
      consultationId: consultationId ?? this.consultationId,
      favoriteCategoryId: favoriteCategoryId ?? this.favoriteCategoryId,
      consultation: consultation ?? this.consultation,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _FavoriteConsultationContract();
    return {
      contract.id: id,
      contract.consultationId: consultationId,
      contract.favoriteCategoryId: favoriteCategoryId,
      contract.consultation: consultation.toMap(),
    };
  }

  factory FavoriteConsultation.fromMap(Map<String, dynamic> map) {
    final contract = _FavoriteConsultationContract();
    return FavoriteConsultation(
      id: map[contract.id]?.toInt() ?? 0,
      consultationId: map[contract.consultationId]?.toInt() ?? 0,
      favoriteCategoryId: map[contract.favoriteCategoryId]?.toInt(),
      consultation: Consultation.fromMap(map[contract.consultation]),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteConsultation.fromJson(String source) =>
      FavoriteConsultation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavoriteConsultation(id: $id, consultationId: $consultationId, favoriteCategoryId: $favoriteCategoryId, consultation: $consultation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteConsultation &&
        other.id == id &&
        other.consultationId == consultationId &&
        other.favoriteCategoryId == favoriteCategoryId &&
        other.consultation == consultation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        consultationId.hashCode ^
        favoriteCategoryId.hashCode ^
        consultation.hashCode;
  }
}

class _FavoriteConsultationContract {
  final id = 'id';
  final consultationId = 'consultation_id';
  final favoriteCategoryId = 'favourite_category_id	';
  final consultation = 'consultation';
  final favouriteCategory = 'favouriteCategory';
}
