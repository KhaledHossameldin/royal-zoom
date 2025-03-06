import '../../core/results/result.dart';
import '../../data/models/withdraw_request_response/with_draw_filter.dart';
import '../entities/withdraw_request_entity.dart';
import '../repositories/consultant/balance_repo_i.dart';

class WithdrawRequestUseCase implements IWithdrawRequestUseCase {
  final IBalanceRepo _repo;
  WithdrawRequestUseCase(this._repo);

  @override
  Future<Result<List<WithdrawRequesEntity>>> call(
      {required WithDrawFilterRequest request}) async {
    return await _repo.getAllWithdrawRequests(request: request);
  }
}

abstract class IWithdrawRequestUseCase {
  Future<Result<List<WithdrawRequesEntity>>> call(
      {required WithDrawFilterRequest request});
}
