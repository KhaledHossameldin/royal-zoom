import '../../../core/base_repo/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../domain/entities/wallet_payment_intention_entity.dart';
import '../../../domain/repositories/user/invoices_repo_i.dart';
import '../../enums/invoice_type.dart';
import '../../enums/payment_method.dart';
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

  @override
  Future<Result<WalletPaymentIntentionEnitity>> createWalletChargeRequest(
      {required PaymentMethod method, required num amount}) async {
    return mapModelToEntity(
        await _iRD.createWalletChargeRequest(method: method, amount: amount));
  }

  @override
  Future<Result<Invoice>> getInvoice(
      {required int id, required InvoiceType type}) async {
    return await _iRD.getInvoice(id: id, type: type);
  }

  @override
  Future<Result<bool>> checkInvoiceStatus({required num invoiceId}) async {
    return await _iRD.checkInvoiceStatus(invoiceId: invoiceId);
  }
}
