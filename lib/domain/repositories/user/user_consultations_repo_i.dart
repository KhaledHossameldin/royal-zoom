import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../data/enums/consultant_response_type.dart';
import '../../entities/consultation_entity.dart';
import '../../entities/fav_consultation_entitiy.dart';

abstract class IUserConsultationRepo {
  Future<Result<List<ConsultationEntity>>> getUserConsultations();
  Future<Result<List<FavoriteConsultationEntity>>> getFavoriteConsultations();
  Future<Result<EmptyEntity>> updateConsultation({
    required id,
    required ConsultantResponseType type,
  });
  Future<Result<int>> fastConsultation(
      {required Map<String, Object> consultation});
  Future<Result<EmptyEntity>> addFavoriteConsultation(
      {required int id, int? category});

  Future<Result<EmptyEntity>> cancelConsulation({required int id});
  Future<Result<int>> changeAppointmentDate({
    required int id,
    required String date,
  });
  Future<Result<EmptyEntity>> rejectChangeAppointmentTimeRequest(
      {required int id});
  Future<Result<EmptyEntity>> accceptChangeAppointmentTimeRequest(
      {required int id});
  Future<Result<EmptyEntity>> addConsultationComment(
      {required int id, required String comment});
  Future<Result<EmptyEntity>> rateConsultation(
      {required int id, required int rate});
}
