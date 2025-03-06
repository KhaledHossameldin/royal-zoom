import '../../core/results/result.dart';
import '../entities/major_entity.dart';
import '../repositories/general/guest_repo_i.dart';

class MajorsUseCase implements IMajorsUsecase {
  final IGuestRepo _repo;
  MajorsUseCase(this._repo);

  @override
  Future<Result<List<MajorEntity>>> call() async {
    return await _repo.getMajors();
  }
}

abstract class IMajorsUsecase {
  Future<Result<List<MajorEntity>>> call();
}
