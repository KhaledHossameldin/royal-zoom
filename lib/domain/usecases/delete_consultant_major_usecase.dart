import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/consultant/major_repo_i.dart';

class DeleteConsultantMajorUseCase implements IDeleteConsultantMajorUseCase {
  final IConsultantMajorRepo _repo;
  DeleteConsultantMajorUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call({required int id}) async {
    return await _repo.deleteMajor(id: id);
  }
}

abstract class IDeleteConsultantMajorUseCase {
  Future<Result<EmptyEntity>> call({required int id});
}
