import '../../../core/results/result.dart';
import '../../../data/enums/user_type.dart';
import '../../../data/models/authentication/user_data.dart';

abstract class IProfileRepo {
  Future<Result<UserData>> getProfile(UserType type);
}
