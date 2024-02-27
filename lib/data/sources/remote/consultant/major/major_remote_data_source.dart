import '../../../../../core/data_source/base_remote_data_source.dart';
import '../../../../../core/models/empty_model.dart';
import '../../../../../core/network/endpoints/network.dart';
import '../../../../../core/network/http_method.dart';
import '../../../../../core/results/result.dart';
import '../../../../../utilities/extensions.dart';
import '../../../../models/consultants/add_new_major_request_body.dart';
import '../../../../models/consultants/consultant_major.dart';
import '../../../../models/consultants/update_consultant_major_body.dart';
import '../../../../models/consultants/verify_major_request_body.dart';

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

  Future<Result<List<ConsultantMajor>>> getMajors() async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((e) => ConsultantMajor.fromMap(e)).toList(),
      method: HttpMethod.GET,
      url: Network.newMajorRequests,
    );
  }

  Future<Result<EmptyModel>> verifyMajor(
      {required VerifyRequestBody body}) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.majorVerificationRequests,
      data: body.toMap(),
    );
  }

  Future<Result<EmptyModel>> changeStatus({
    required int id,
    required bool isFree,
  }) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.PUT,
      url: Network.changeConsultantMajorStatus(id),
      data: {'is_free': isFree.toInt},
    );
  }

  Future<Result<EmptyModel>> update({
    required UpdateConsultantMajorBody body,
  }) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.PUT,
      url: '${Network.newMajorRequests}/${body.majorId}',
      data: body.toMap(),
    );
  }

  Future<Result<EmptyModel>> delete({required int id}) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.DELETE,
      url: '${Network.newMajorRequests}/$id',
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
