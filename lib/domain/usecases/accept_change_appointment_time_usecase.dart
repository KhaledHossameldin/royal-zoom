import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/user/user_consultations_repo_i.dart';

class AcceptChangeAppointmentTimeRequestUseCase
    implements IAcceptChangeAppointmentTimeRequestUseCase {
  final IUserConsultationRepo _repo;
  AcceptChangeAppointmentTimeRequestUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call({required int id}) async {
    return await _repo.accceptChangeAppointmentTimeRequest(id: id);
  }
}

abstract class IAcceptChangeAppointmentTimeRequestUseCase {
  Future<Result<EmptyEntity>> call({required int id});
}
