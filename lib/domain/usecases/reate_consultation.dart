import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/user/user_consultations_repo_i.dart';

class RateConsultationUseCase implements IRateConsultationUseCase {
  final IUserConsultationRepo _repo;
  RateConsultationUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call({required int id, required int rate}) async {
    return await _repo.rateConsultation(id: id, rate: rate);
  }
}

abstract class IRateConsultationUseCase {
  Future<Result<EmptyEntity>> call({required int id, required int rate});
}
