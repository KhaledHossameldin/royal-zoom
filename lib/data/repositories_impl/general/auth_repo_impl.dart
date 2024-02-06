import '../../../core/base_repo/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../domain/repositories/general/auth_repo_i.dart';
import '../../sources/general/auth/auth_remote_data_source.dart';

class AuthRepo extends BaseRepository implements IAuthRepo {
  AuthRepo(this._aRD);
  final AuthRemoteDataSource _aRD;
  @override
  Future<Result<EmptyEntity>> register(
      {required String username,
      required String password,
      required String confirm}) async {
    final result = await _aRD.register(
        username: username, password: password, confirm: confirm);
    return mapModelToEntity(result);
  }
}
