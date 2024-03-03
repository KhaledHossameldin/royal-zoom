import '../../core/results/result.dart';
import '../../data/enums/payment_method.dart';
import '../entities/wallet_payment_intention_entity.dart';
import '../repositories/user/invoices_repo_i.dart';

class CreateWalletChargeRequestUseCase
    extends ICreateWalletChargeRequestUseCase {
  final IInvoiceRepo _repo;
  CreateWalletChargeRequestUseCase(this._repo);
  @override
  Future<Result<WalletPaymentIntentionEnitity>> call(
      {required PaymentMethod method, required num amount}) async {
    return _repo.createWalletChargeRequest(method: method, amount: amount);
  }
}

abstract class ICreateWalletChargeRequestUseCase {
  Future<Result<WalletPaymentIntentionEnitity>> call(
      {required PaymentMethod method, required num amount});
}
