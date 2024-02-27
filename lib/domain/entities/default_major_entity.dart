import '../../core/models/base_entity.dart';
import '../../data/models/major.dart';

class DefaultMajorEntity extends BaseEntity {
  final int id;
  final String uuid;
  final int userId;
  final int majorId;
  final bool isVerified;
  final bool isActive;
  final bool isFree;
  final int yearsOfExperience;
  final num pricePerHour;
  final String terms;
  final bool isNotificationsEnabled;
  final bool isDefault;
  final Major? major;

  DefaultMajorEntity({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.majorId,
    required this.isVerified,
    required this.isActive,
    required this.isFree,
    required this.yearsOfExperience,
    required this.pricePerHour,
    required this.terms,
    required this.isNotificationsEnabled,
    required this.isDefault,
    this.major,
  });

  @override
  String toString() {
    return 'id: $id, uuid: $uuid, userId: $userId, majorId: $majorId, isVerified: $isVerified, isActive: $isActive, isFree: $isFree, yearsOfExperience: $yearsOfExperience, pricePerHour: $pricePerHour, terms: $terms, isNotificationsEnabled: $isNotificationsEnabled, isDefault: $isDefault, major: $major';
  }

  @override
  List<Object?> get props => [
        id,
        uuid,
        userId,
        majorId,
        isVerified,
        isActive,
        isFree,
        yearsOfExperience,
        pricePerHour,
        terms,
        isNotificationsEnabled,
        isDefault,
        major
      ];
}
