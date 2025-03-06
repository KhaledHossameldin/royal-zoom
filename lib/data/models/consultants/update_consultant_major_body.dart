import '../../../utilities/extensions.dart';

class UpdateConsultantMajorBody {
  final int majorId;
  final int userId;
  final bool isActive;
  final String yearsOfExperience;
  final String pricePerHour;
  final String terms;
  final bool isNotificationsEnabled;

  UpdateConsultantMajorBody({
    required this.majorId,
    required this.userId,
    required this.isActive,
    required this.yearsOfExperience,
    required this.pricePerHour,
    required this.terms,
    required this.isNotificationsEnabled,
  });

  Map<String, dynamic> toMap() {
    return {
      'major_id': majorId,
      'user_id': userId,
      'is_active': isActive.toInt,
      'years_of_experience': yearsOfExperience,
      'price_per_hour': pricePerHour,
      'terms': terms,
      'is_notifications_enabled': isNotificationsEnabled.toInt,
    };
  }
}
