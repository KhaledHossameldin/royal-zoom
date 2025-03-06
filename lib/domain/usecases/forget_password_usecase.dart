import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/general/auth_repo_i.dart';

class ForgetPasswordUseCase implements IForgetPasswordUseCase {
  final IAuthRepo _repo;
  ForgetPasswordUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call({required String username}) async {
    return _repo.forgetPassword(username: username);
  }
}

abstract class IForgetPasswordUseCase {
  Future<Result<EmptyEntity>> call({required String username});
}
