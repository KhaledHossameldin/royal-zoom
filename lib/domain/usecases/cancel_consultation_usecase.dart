import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/user/user_consultations_repo_i.dart';

class CancelConsultationUseCase implements ICancelConsultationUseCase {
  final IUserConsultationRepo _repo;
  CancelConsultationUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call({required int id}) async {
    return await _repo.cancelConsulation(id: id);
  }
}

abstract class ICancelConsultationUseCase {
  Future<Result<EmptyEntity>> call({required int id});
}
