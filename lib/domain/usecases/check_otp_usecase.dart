import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/general/auth_repo_i.dart';

class CheckOTPUseCase implements ICheckOTPUseCase {
  final IAuthRepo _repo;
  CheckOTPUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call(
      {required String username, required String code}) async {
    return _repo.checkOTP(username: username, code: code);
  }
}

abstract class ICheckOTPUseCase {
  Future<Result<EmptyEntity>> call({
    required String username,
    required String code,
  });
}
