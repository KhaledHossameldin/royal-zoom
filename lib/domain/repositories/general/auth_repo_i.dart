import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';

abstract class IAuthRepo {
  Future<Result<EmptyEntity>> register({
    required String username,
    required String password,
    required String confirm,
  });
}
