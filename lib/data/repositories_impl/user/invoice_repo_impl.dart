import '../../../core/base_repo/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../domain/repositories/user/invoices_repo_i.dart';
import '../../enums/invoice_type.dart';
import '../../models/invoices/invoicable/filter.dart';
import '../../models/invoices/invoice.dart';
import '../../sources/remote/user/invoices/invoices_remote_data_source.dart';

class InvoiceRepo extends BaseRepository implements IInvoiceRepo {
  final InvoicesRemoteDataSource _iRD;
  InvoiceRepo(this._iRD);
  @override
  Future<Result<List<Invoice>>> getInvoices(
      {required InvoiceType type, required InvoiceFilter filters}) async {
    return await _iRD.getInvoices(type: type, filters: filters);
  }
}
