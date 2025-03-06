import '../../core/results/result.dart';
import '../entities/refund_request_entity.dart';
import '../repositories/consultant/balance_repo_i.dart';

class RefundRequestUseCase implements IRefundRequestUseCase {
  final IBalanceRepo _repo;
  RefundRequestUseCase(this._repo);

  @override
  Future<Result<List<RefundRequestEntity>>> call() async {
    return await _repo.getAllRefundRequests();
  }
}

abstract class IRefundRequestUseCase {
  Future<Result<List<RefundRequestEntity>>> call();
}
