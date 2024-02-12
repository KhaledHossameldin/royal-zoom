import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../../data/enums/consultant_response_type.dart';
import '../repositories/user/user_consultations_repo_i.dart';

class UpdateConsultationUseCase implements IUpdateConsultationUseCase {
  final IUserConsultationRepo _repo;
  UpdateConsultationUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call(
      {required id, required ConsultantResponseType type}) async {
    return await _repo.updateConsultation(id: id, type: type);
  }
}

abstract class IUpdateConsultationUseCase {
  Future<Result<EmptyEntity>> call({
    required id,
    required ConsultantResponseType type,
  });
}
