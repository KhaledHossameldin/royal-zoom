import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/general/auth_repo_i.dart';

class ResendOTPUseCase implements IResendOTPUseCase {
  final IAuthRepo _repo;
  ResendOTPUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call({required String username}) async {
    return _repo.resendOTP(username: username);
  }
}

abstract class IResendOTPUseCase {
  Future<Result<EmptyEntity>> call({required String username});
}
