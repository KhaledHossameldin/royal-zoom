import '../../core/results/result.dart';
import '../entities/user_entity.dart';
import '../repositories/general/auth_repo_i.dart';

class LoginUseCase implements ILoginUseCase {
  final IAuthRepo _repo;
  LoginUseCase(this._repo);
  @override
  Future<Result<UserEntity>> call({
    required String username,
    required String password,
    required bool isRemember,
  }) async {
    return await _repo.login(
        username: username, password: password, isRemember: isRemember);
  }
}

abstract class ILoginUseCase {
  Future<Result<UserEntity>> call({
    required String username,
    required String password,
    required bool isRemember,
  });
}
