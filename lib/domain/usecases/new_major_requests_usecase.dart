import '../../core/results/result.dart';
import '../entities/new_major_entity.dart';
import '../repositories/consultant/major_repo_i.dart';

class NewMajorRequestUseCase implements INewMajorRequestsUseCase {
  final IConsultantMajorRepo _repo;
  NewMajorRequestUseCase(this._repo);
  @override
  Future<Result<List<NewMajorEntity>>> call() async {
    return await _repo.getMajorsRequests();
  }
}

abstract class INewMajorRequestsUseCase {
  Future<Result<List<NewMajorEntity>>> call();
}
