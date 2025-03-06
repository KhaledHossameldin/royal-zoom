import '../../core/results/result.dart';
import '../repositories/user/user_consultations_repo_i.dart';

class ChangeAppointmentDateUseCase implements IChangeAppointmentDateUseCase {
  final IUserConsultationRepo _repo;
  ChangeAppointmentDateUseCase(this._repo);
  @override
  Future<Result<int>> call({required int id, required String date}) async {
    return await _repo.changeAppointmentDate(id: id, date: date);
  }
}

abstract class IChangeAppointmentDateUseCase {
  Future<Result<int>> call({required int id, required String date});
}
