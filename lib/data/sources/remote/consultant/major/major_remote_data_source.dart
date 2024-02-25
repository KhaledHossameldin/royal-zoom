import '../../../../../core/data_source/base_remote_data_source.dart';
import '../../../../../core/models/empty_model.dart';
import '../../../../../core/network/endpoints/network.dart';
import '../../../../../core/network/http_method.dart';
import '../../../../../core/results/result.dart';
import '../../../../models/consultants/add_new_major_request_body.dart';
import '../../../../models/consultants/consultant_major.dart';
import '../../../../models/consultants/verify_major_request_body.dart';

class MajorRemoteDataSource {
  Future<Result<EmptyModel>> addNewMajorRequest({
    required AddNewMajorRequestBody body,
  }) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.newMajorRequests,
      data: body.toMap(),
    );
  }

  Future<Result<List<ConsultantMajor>>> getMajors() async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((e) => ConsultantMajor.fromMap(e)).toList(),
      method: HttpMethod.GET,
      url: Network.newMajorRequests,
    );
  }

  Future<Result<EmptyModel>> verify({required VerifyRequestBody body}) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.majorVerificationRequests,
      data: body.toMap(),
    );
  }
}
