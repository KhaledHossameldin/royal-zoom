import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/network/endpoints/network.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../enums/user_type.dart';
import '../../../models/authentication/user_data.dart';
import '../../../models/consultant_user/consultant_user.dart';

class ProfileRemoteDataSource {
  Future<Result<UserData>> getProfile(UserType type) async {
    return await RemoteDataSource.request(
      converter: (model) => type == UserType.normal
          ? UserData.fromJson(model)
          : ConsultantUserData.fromJson(model),
      method: HttpMethod.GET,
      url: type == UserType.normal
          ? Network.showProfile
          : Network.showConsultantProfile,
    );
  }
}
