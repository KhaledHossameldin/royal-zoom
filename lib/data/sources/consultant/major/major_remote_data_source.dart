import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/models/empty_model.dart';
import '../../../../core/network/endpoints/network.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../utilities/extensions.dart';

class MajorRemoteDataSource {
  Future<Result<EmptyModel>> addNewMajorRequest({
    required int majorId,
    required bool isActive,
    required String yearsOfExperience,
    required String price,
    required String terms,
    required bool isNotificationsEnabled,
    required String consultantPreviewName,
  }) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.newMajorRequests,
      data: {
        'major_id': majorId.toString(),
        'is_active': isActive.toInt.toString(),
        'years_of_experience': yearsOfExperience.toString(),
        'price_per_hour': price.toString(),
        'terms': terms,
        'is_notifications_enabled': isNotificationsEnabled.toInt.toString(),
        'is_free': 0,
        'consultant_preview_name': consultantPreviewName,
      },
    );
  }
}
