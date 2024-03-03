import '../../../core/base_repo/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../domain/entities/consultation_entity.dart';
import '../../../domain/entities/fav_consultation_entitiy.dart';
import '../../../domain/repositories/user/user_consultations_repo_i.dart';
import '../../enums/consultant_response_type.dart';
import '../../models/fast_consultation/fast_consultation.dart';
import '../../sources/remote/user/consultations/user_consultations_remote_data_source.dart';

class UserConsultationRepo extends BaseRepository
    implements IUserConsultationRepo {
  final UserConsultationRemoteDataSource _uRD;
  UserConsultationRepo(this._uRD);
  @override
  Future<Result<EmptyEntity>> accceptChangeAppointmentTimeRequest(
      {required int id}) async {
    final result = await _uRD.accceptChangeAppointmentTimeRequest(id: id);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> addConsultationComment(
      {required int id, required String comment}) async {
    final result = await _uRD.addConsultationComment(id: id, comment: comment);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> addFavoriteConsultation(
      {required int id, int? category}) async {
    final result =
        await _uRD.addFavoriteConsultation(id: id, category: category);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> cancelConsulation({required int id}) async {
    final result = await _uRD.cancelConsulation(id: id);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<int>> changeAppointmentDate(
      {required int id, required String date}) async {
    return await _uRD.changeAppointmentDate(id: id, date: date);
  }

  @override
  Future<Result<FastConsultation>> fastConsultation(
      {required Map<String, Object> consultation}) async {
    return await _uRD.fastConsultation(consultation: consultation);
  }

  @override
  Future<Result<List<FavoriteConsultationEntity>>>
      getFavoriteConsultations() async {
    final result = await _uRD.getFavoriteConsultations();
    return mapModelsToEntities(result);
  }

  @override
  Future<Result<List<ConsultationEntity>>> getUserConsultations() async {
    final result = await _uRD.getUserConsultations();
    return mapModelsToEntities(result);
  }

  @override
  Future<Result<EmptyEntity>> rateConsultation(
      {required int id, required int rate}) async {
    final result = await _uRD.rateConsultation(id: id, rate: rate);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> rejectChangeAppointmentTimeRequest(
      {required int id}) async {
    final result = await _uRD.rejectChangeAppointmentTimeRequest(id: id);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> updateConsultation(
      {required id, required ConsultantResponseType type}) async {
    final result = await _uRD.updateConsultation(id: id, type: type);
    return mapModelToEntity(result);
  }
}
