import '../../../core/results/result.dart';
import '../../../data/models/withdraw_request_response/with_draw_filter.dart';
import '../../entities/refund_request_entity.dart';
import '../../entities/withdraw_request_entity.dart';

abstract class IBalanceRepo {
  Future<Result<List<RefundRequestEntity>>> getAllRefundRequests();
  Future<Result<List<WithdrawRequesEntity>>> getAllWithdrawRequests(
      {required WithDrawFilterRequest request});
}
