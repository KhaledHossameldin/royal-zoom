import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/consultant/major_repo_i.dart';

class ChangeConsultantMajorStatusUseCase
    implements IChangeConsultantMajorStatusUseCase {
  final IConsultantMajorRepo _repo;
  ChangeConsultantMajorStatusUseCase(this._repo);

  @override
  Future<Result<EmptyEntity>> call({
    required int id,
    required bool isFree,
  }) async {
    return await _repo.changeStatus(id: id, isFree: isFree);
  }
}

abstract class IChangeConsultantMajorStatusUseCase {
  Future<Result<EmptyEntity>> call({
    required int id,
    required bool isFree,
  });
}
