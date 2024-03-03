import '../../core/results/result.dart';
import '../../data/enums/invoice_type.dart';
import '../../data/models/invoices/invoice.dart';
import '../repositories/user/invoices_repo_i.dart';

class ConsultationInvoiceUseCase implements IConsultationInvoiceUseCase {
  final IInvoiceRepo _repo;
  ConsultationInvoiceUseCase(this._repo);
  @override
  Future<Result<Invoice>> call({required int id}) async {
    return await _repo.getInvoice(id: id, type: InvoiceType.consultation);
  }
}

abstract class IConsultationInvoiceUseCase {
  Future<Result<Invoice>> call({required int id});
}
