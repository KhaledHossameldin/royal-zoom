import '../../../../../core/data_source/base_remote_data_source.dart';
import '../../../../../core/models/empty_model.dart';
import '../../../../../core/network/endpoints/network.dart';
import '../../../../../core/network/http_method.dart';
import '../../../../../core/results/result.dart';
import '../../../../enums/consultant_response_type.dart';
import '../../../../models/consultations/consultation.dart';
import '../../../../models/consultations/favorite.dart';

class UserConsultationRemoteDataSource {
  Future<Result<List<Consultation>>> getUserConsultations() async {
    return await RemoteDataSource.request(
      converterList: (list) => list!
          .map((conslutation) => Consultation.fromJson(conslutation))
          .toList(),
      method: HttpMethod.GET,
      url: Network.consultations,
    );
  }

  Future<Result<List<FavoriteConsultation>>> getFavoriteConsultations() async {
    return await RemoteDataSource.request(
      converterList: (list) => list!
          .map((consluation) => FavoriteConsultation.fromJson(consluation))
          .toList(),
      method: HttpMethod.GET,
      url: Network.favoriteConsultations,
    );
  }

  Future<Result<EmptyModel>> updateConsultation({
    required id,
    required ConsultantResponseType type,
  }) async {
    return await RemoteDataSource.request(
        converter: (model) => EmptyModel(model),
        method: HttpMethod.PUT,
        url: '${Network.consultations}/$id',
        data: {
          'consultant_response_type': type.toMap(),
        });
  }

  Future<Result<int>> fastConsultation(
      {required Map<String, Object> consultation}) async {
    return await RemoteDataSource.request(
      converter: (model) => model['id'],
      method: HttpMethod.POST,
      url: Network.fastConsultation,
      data: consultation,
    );
  }

  Future<Result<EmptyModel>> addFavoriteConsultation(
      {required int id, int? category}) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.favoriteConsultation(id),
      data: category != null ? {'favourite_category_id': category} : null,
    );
  }

  Future<Result<EmptyModel>> cancelConsulation({required int id}) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.cancelConsultation(id),
    );
  }

  Future<Result<int>> changeAppointmentDate({
    required int id,
    required String date,
  }) async {
    return await RemoteDataSource.request(
      converter: (model) => model['consultation_request_id'],
      method: HttpMethod.POST,
      url: Network.consultationAppointmentRequests,
      data: {
        'consultation_request_id': id.toString(),
        'appointment_date': date,
      },
    );
  }

  Future<Result<EmptyModel>> rejectChangeAppointmentTimeRequest(
      {required int id}) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.rejectChangeTimeRequest(id),
    );
  }

  Future<Result<EmptyModel>> accceptChangeAppointmentTimeRequest(
      {required int id}) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.acceptChangeTimeRequest(id),
    );
  }

  Future<Result<EmptyModel>> addConsultationComment(
      {required int id, required String comment}) async {
    return await RemoteDataSource.request(
        converter: (model) => EmptyModel(model),
        method: HttpMethod.POST,
        url: Network.consultationComments(id),
        data: {'comment': comment});
  }

  Future<Result<EmptyModel>> rateConsultation(
      {required int id, required int rate}) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.rateConsultation,
      data: {
        'resource_type': '1',
        'resource_id': id.toString(),
        'rating_value': rate.toString(),
      },
    );
  }
}
