import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/general/auth_repo_i.dart';

class LogoutUseCase implements ILogoutUseCase {
  final IAuthRepo _repo;
  LogoutUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call() async {
    return _repo.logout();
  }
}

abstract class ILogoutUseCase {
  Future<Result<EmptyEntity>> call();
}
