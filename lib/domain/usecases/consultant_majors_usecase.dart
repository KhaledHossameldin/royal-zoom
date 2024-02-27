import '../../core/results/result.dart';
import '../entities/consultant_major_entity.dart';
import '../repositories/consultant/major_repo_i.dart';

class ConsultantMajorsUseCase implements IConsultantMajorsUsecase {
  final IConsultantMajorRepo _repo;
  ConsultantMajorsUseCase(this._repo);

  @override
  Future<Result<List<ConsultantMajorEntity>>> call() async {
    return await _repo.getMajors();
  }
}

abstract class IConsultantMajorsUsecase {
  Future<Result<List<ConsultantMajorEntity>>> call();
}
