import '../../core/results/result.dart';
import '../entities/new_major_entity.dart';
import '../repositories/consultant/major_repo_i.dart';

class MajorVerificationRequestUseCase
    implements IMajorVerificationRequestsUseCase {
  final IConsultantMajorRepo _repo;
  MajorVerificationRequestUseCase(this._repo);
  @override
  Future<Result<List<NewMajorEntity>>> call() async {
    return await _repo.getMajorVerificationRequest();
  }
}

abstract class IMajorVerificationRequestsUseCase {
  Future<Result<List<NewMajorEntity>>> call();
}
