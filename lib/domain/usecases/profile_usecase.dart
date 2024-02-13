import '../../core/results/result.dart';
import '../../data/enums/user_type.dart';
import '../../data/models/authentication/user_data.dart';
import '../repositories/general/profile_repo_i.dart';

class ProfileUseCase implements IProfileUseCase {
  final IProfileRepo _repo;
  ProfileUseCase(this._repo);
  @override
  Future<Result<UserData>> call(UserType type) async {
    return await _repo.getProfile(type);
  }
}

abstract class IProfileUseCase {
  Future<Result<UserData>> call(UserType type);
}
