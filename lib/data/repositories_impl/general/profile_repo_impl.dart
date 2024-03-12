import '../../../core/base_repo/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../domain/repositories/general/profile_repo_i.dart';
import '../../enums/user_type.dart';
import '../../models/authentication/user_data.dart';
import '../../sources/local/shared_prefs.dart';
import '../../sources/remote/general/profile/profile_remote_data_source.dart';

class ProfileRepo extends BaseRepository implements IProfileRepo {
  final ProfileRemoteDataSource _pRD;
  final SharedPrefs _prefs;
  ProfileRepo(this._pRD, this._prefs);
  @override
  Future<Result<UserData>> getProfile(UserType type) async {
    final result = await _pRD.getProfile(type);
    if (result.hasDataOnly && _prefs.doesUserExist()) {
      _prefs.setUserType(result.data!.type);
      _prefs.setUser(result.data!);
    }
    return result;
  }
}
