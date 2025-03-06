import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../../data/models/consultants/update_consultant_major_body.dart';
import '../repositories/consultant/major_repo_i.dart';

class UpdateConsultantMajorUseCase implements IUpdateConsultantMajorUseCase {
  final IConsultantMajorRepo _repo;
  UpdateConsultantMajorUseCase(this._repo);

  @override
  Future<Result<EmptyEntity>> call({
    required UpdateConsultantMajorBody body,
  }) async {
    return await _repo.updateMajor(body: body);
  }
}

abstract class IUpdateConsultantMajorUseCase {
  Future<Result<EmptyEntity>> call({
    required UpdateConsultantMajorBody body,
  });
}
