import '../../core/models/base_entity.dart';
import '../../data/models/consultants/major_verification_request.dart';
import '../../data/models/major.dart';

class ConsultantMajorEntity extends BaseEntity {
  final num? id;
  final String? uuid;
  final num? userId;
  final num? majorId;
  final num? isVerified;
  final num? isActive;
  final num? isFree;
  final num? yearsOfExperience;
  final String? pricePerHour;
  final String? terms;
  final num? isNotificationsEnabled;
  final num? isDefault;
  final num? isAvailableForVerification;
  final Major? major;
  final MajorVerificationRequest? majorVerificationRequest;

  ConsultantMajorEntity({
    this.id,
    this.uuid,
    this.userId,
    this.majorId,
    this.isVerified,
    this.isActive,
    this.isFree,
    this.yearsOfExperience,
    this.pricePerHour,
    this.terms,
    this.isNotificationsEnabled,
    this.isDefault,
    this.isAvailableForVerification,
    this.major,
    this.majorVerificationRequest,
  });

  @override
  String toString() {
    return 'ConsultantMajorEntity(id: $id, uuid: $uuid, userId: $userId, majorId: $majorId, isVerified: $isVerified, isActive: $isActive, isFree: $isFree, yearsOfExperience: $yearsOfExperience, pricePerHour: $pricePerHour, terms: $terms, isNotificationsEnabled: $isNotificationsEnabled, isDefault: $isDefault, isAvailableForVerification: $isAvailableForVerification, major: $major, majorVerificationRequest: $majorVerificationRequest)';
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
        isAvailableForVerification,
        major,
        majorVerificationRequest,
      ];
}
