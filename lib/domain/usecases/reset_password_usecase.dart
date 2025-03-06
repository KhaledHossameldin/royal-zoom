import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/general/auth_repo_i.dart';

class ResetPasswordUseCase implements IResetPasswordUseCase {
  final IAuthRepo _repo;
  ResetPasswordUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call({
    required String username,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await _repo.resetPassword(
        username: username,
        code: code,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
  }
}

abstract class IResetPasswordUseCase {
  Future<Result<EmptyEntity>> call({
    required String username,
    required String code,
    required String newPassword,
    required String confirmPassword,
  });
}
