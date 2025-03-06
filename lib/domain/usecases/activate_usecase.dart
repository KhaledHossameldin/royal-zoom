import '../../core/results/result.dart';
import '../entities/user_entity.dart';
import '../repositories/general/auth_repo_i.dart';

class ActivateUseCase implements IActivateUseCase {
  final IAuthRepo _repo;
  ActivateUseCase(this._repo);
  @override
  Future<Result<UserEntity>> call(
      {required String username, required String code}) async {
    return _repo.activate(username: username, code: code);
  }
}

abstract class IActivateUseCase {
  Future<Result<UserEntity>> call({
    required String username,
    required String code,
  });
}
