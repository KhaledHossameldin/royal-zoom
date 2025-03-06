import '../../core/results/result.dart';
import '../repositories/user/invoices_repo_i.dart';

class CheckInvoiceStatusUseCase implements ICheckInvoiceStatusUseCase {
  final IInvoiceRepo _repo;
  CheckInvoiceStatusUseCase(this._repo);
  @override
  Future<Result<bool>> call({required num invoiceId}) async {
    return await _repo.checkInvoiceStatus(invoiceId: invoiceId);
  }
}

abstract class ICheckInvoiceStatusUseCase {
  Future<Result<bool>> call({required num invoiceId});
}
