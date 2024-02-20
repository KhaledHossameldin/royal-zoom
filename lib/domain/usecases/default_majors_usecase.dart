import '../../core/results/result.dart';
import '../entities/default_major_entity.dart';
import '../repositories/consultant/major_repo_i.dart';

class DefaultMajorsUseCase implements IDefaultMajorsUsecase {
  final IDefaultMajorRepo _repo;
  DefaultMajorsUseCase(this._repo);

  @override
  Future<Result<List<DefaultMajorEntity>>> call() async {
    return await _repo.getMajors();
  }
}

abstract class IDefaultMajorsUsecase {
  Future<Result<List<DefaultMajorEntity>>> call();
}
