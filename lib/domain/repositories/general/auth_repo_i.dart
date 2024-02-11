import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../entities/user_entity.dart';

abstract class IAuthRepo {
  Future<Result<UserEntity>> register({
    required String username,
    required String password,
    required String confirm,
  });

  Future<Result<UserEntity>> login({
    required String username,
    required String password,
  });

  Future<Result<EmptyEntity>> logout();

  Future<Result<UserEntity>> activate({
    required String username,
    required String code,
  });
  Future<Result<EmptyEntity>> resetPassword({
    required String username,
    required String code,
    required String newPassword,
    required String confirmPassword,
  });
  Future<Result<EmptyEntity>> checkOTP({
    required String username,
    required String code,
  });

  Future<Result<EmptyEntity>> forgetPassword({required String username});
  Future<Result<EmptyEntity>> resendOTP({required String username});
}
