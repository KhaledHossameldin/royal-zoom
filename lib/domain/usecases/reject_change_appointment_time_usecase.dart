import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/user/user_consultations_repo_i.dart';

class RejectChangeAppointmentTimeRequestUseCase
    implements IRejectChangeAppointmentTimeRequestUseCase {
  final IUserConsultationRepo _repo;
  RejectChangeAppointmentTimeRequestUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call({required int id}) async {
    return await _repo.rejectChangeAppointmentTimeRequest(id: id);
  }
}

abstract class IRejectChangeAppointmentTimeRequestUseCase {
  Future<Result<EmptyEntity>> call({required int id});
}
