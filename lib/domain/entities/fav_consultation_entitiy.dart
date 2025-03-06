import '../../core/models/base_entity.dart';
import '../../data/models/consultations/consultation.dart';
import '../../data/models/favorite_category.dart';

class FavoriteConsultationEntity extends BaseEntity {
  final int id;
  final int consultationId;
  final int? favoriteCategoryId;
  final Consultation consultation;
  final FavoriteCategory? favoriteCategory;

  FavoriteConsultationEntity({
    required this.id,
    required this.consultationId,
    this.favoriteCategoryId,
    required this.consultation,
    this.favoriteCategory,
  });

  @override
  List<Object?> get props => [
        id,
        consultationId,
        favoriteCategoryId,
        consultation,
        favoriteCategory,
      ];
}
