import '../../../core/base_repo/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/general/auth_repo_i.dart';
import '../../sources/local/shared_prefs.dart';
import '../../sources/remote/general/auth/auth_remote_data_source.dart';

class AuthRepo extends BaseRepository implements IAuthRepo {
  AuthRepo(this._aRD, this._prefs);
  final AuthRemoteDataSource _aRD;
  final SharedPrefs _prefs;
  @override
  Future<Result<UserEntity>> register(
      {required String username,
      required String password,
      required String confirm}) async {
    final result = await _aRD.register(
        username: username, password: password, confirm: confirm);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<UserEntity>> activate(
      {required String username, required String code}) async {
    final result = await _aRD.activate(username: username, code: code);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> checkOTP(
      {required String username, required String code}) async {
    final result = await _aRD.checkOTP(username: username, code: code);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> forgetPassword({required String username}) async {
    final result = await _aRD.forgetPassword(username: username);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<UserEntity>> login({
    required String username,
    required String password,
    required bool isRemember,
  }) async {
    final result = await _aRD.login(username: username, password: password);
    if (result.hasDataOnly) {
      _prefs.setToken(result.data!.token);
      if (isRemember) {
        _prefs.setUser(result.data!);
        _prefs.setUserData(result.data!.data, result.data!.data.type);
        _prefs.setUserType(result.data!.data.type);
      }
    }
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> logout() async {
    final result = await _aRD.logout();
    _prefs.removeUser();
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> resendOTP({required String username}) async {
    final result = await _aRD.resendOTP(username: username);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> resetPassword(
      {required String username,
      required String code,
      required String newPassword,
      required String confirmPassword}) async {
    final result = await _aRD.resetPassword(
        username: username,
        code: code,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
    return mapModelToEntity(result);
  }
}
