import '../../../../../core/data_source/base_remote_data_source.dart';
import '../../../../../core/models/empty_model.dart';
import '../../../../../core/network/endpoints/network.dart';
import '../../../../../core/network/http_method.dart';
import '../../../../../core/results/result.dart';
import '../../../../models/consultants/add_new_major_request_body.dart';
import '../../../../models/major_verification_request_response/major_verification_request_response.dart';
import '../../../../models/new_major_request_response/new_major_request_response.dart';

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

  Future<Result<List<NewMajorRequestResponse>>> getMajorsRequests() async {
    return await RemoteDataSource.request(
      converterList: (list) => list!
          .map((model) => NewMajorRequestResponse.fromJson(model))
          .toList(),
      method: HttpMethod.GET,
      url: Network.newMajorRequestOrders,
    );
  }

  Future<Result<List<MajorVerificationRequestResponse>>>
      getVerificationMajorRequests() async {
    return await RemoteDataSource.request(
      converterList: (list) => list!
          .map((model) => MajorVerificationRequestResponse.fromJson(model))
          .toList(),
      method: HttpMethod.GET,
      url: Network.majorVerificationRequestOrders,
    );
  }
}
