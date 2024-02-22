import '../../../core/base_repo/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../domain/entities/refund_request_entity.dart';
import '../../../domain/entities/withdraw_request_entity.dart';
import '../../../domain/repositories/consultant/balance_repo_i.dart';
import '../../models/withdraw_request_response/with_draw_filter.dart';
import '../../sources/remote/consultant/balance/balance_remote_data_source.dart';

class BalanceRepo extends BaseRepository implements IBalanceRepo {
  final BalanceRemoteDataSource _bRD;
  BalanceRepo(this._bRD);
  @override
  Future<Result<List<RefundRequestEntity>>> getAllRefundRequests() async {
    final result = await _bRD.getAllRefundRequests();
    return mapModelsToEntities(result);
  }

  @override
  Future<Result<List<WithdrawRequesEntity>>> getAllWithdrawRequests(
      {required WithDrawFilterRequest request}) async {
    final result = await _bRD.getAllWithdrawRequests(request: request);
    return mapModelsToEntities(result, meta: result.meta);
  }
}
