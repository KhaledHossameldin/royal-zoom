import '../../../utilities/extensions.dart';

class AddNewMajorRequestBody {
  final int majorId;
  final bool isActive;
  final String yearsOfExperience;
  final String price;
  final String terms;
  final bool isNotificationsEnabled;
  final String consultantPreviewName;

  AddNewMajorRequestBody({
    required this.majorId,
    required this.isActive,
    required this.yearsOfExperience,
    required this.price,
    required this.terms,
    required this.isNotificationsEnabled,
    required this.consultantPreviewName,
  });

  Map<String, dynamic> toMap() {
    return {
      'major_id': majorId.toString(),
      'is_active': isActive.toInt.toString(),
      'years_of_experience': yearsOfExperience.toString(),
      'price_per_hour': price.toString(),
      'terms': terms,
      'is_notifications_enabled': isNotificationsEnabled.toInt.toString(),
      'is_free': 0,
      'consultant_preview_name': consultantPreviewName,
    };
  }
}
