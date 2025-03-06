import '../../core/results/result.dart';
import '../entities/user_entity.dart';
import '../repositories/general/auth_repo_i.dart';

class RegisterUseCase implements IRegisterUsecase {
  RegisterUseCase(this._authRepo);
  final IAuthRepo _authRepo;

  @override
  Future<Result<UserEntity>> call(
      {required String username,
      required String password,
      required String confirm}) async {
    return await _authRepo.register(
        username: username, password: password, confirm: confirm);
  }
}

abstract class IRegisterUsecase {
  Future<Result<UserEntity>> call({
    required String username,
    required String password,
    required String confirm,
  });
}
