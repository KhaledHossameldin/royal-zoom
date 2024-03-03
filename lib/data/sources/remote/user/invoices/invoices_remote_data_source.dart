import '../../../../../core/data_source/base_remote_data_source.dart';
import '../../../../../core/network/endpoints/network.dart';
import '../../../../../core/network/http_method.dart';
import '../../../../../core/results/result.dart';
import '../../../../enums/invoice_type.dart';
import '../../../../enums/payment_method.dart';
import '../../../../models/invoices/invoicable/filter.dart';
import '../../../../models/invoices/invoice.dart';
import '../../../../models/wallet_payment_intention/wallet_payment_intention.dart';

class InvoicesRemoteDataSource {
  Future<Result<List<Invoice>>> getInvoices({
    required InvoiceType type,
    required InvoiceFilter filters,
  }) async {
    return await RemoteDataSource.request(
      converterList: (list) => list!
          .map((invoice) => Invoice.fromJson(invoice, type: type))
          .toList(),
      method: HttpMethod.GET,
      url: Network.invoices,
      queryParameters: filters.toMap(),
    );
  }

  Future<Result<WalletPaymentIntention>> createWalletChargeRequest({
    required PaymentMethod method,
    required num amount,
  }) async {
    return await RemoteDataSource.request(
        converter: (model) => WalletPaymentIntention.fromJson(model),
        method: HttpMethod.POST,
        url: Network.walletChargeRequest,
        data: {
          'amount': amount,
          'payment_method': method.toMap(),
        });
  }

  Future<Result<Invoice>> getInvoice(
      {required int id, required InvoiceType type}) async {
    return await RemoteDataSource.request(
      converter: (model) => Invoice.fromMap(model, type: type),
      method: HttpMethod.GET,
      url: Network.getUserInvoice(id),
    );
  }

  Future<Result<bool>> checkInvoiceStatus({required num invoiceId}) async {
    return await RemoteDataSource.request(
      converter: (model) => model['paid_at'] != null,
      method: HttpMethod.GET,
      url: Network.getInvoiceStatus(invoiceId.toInt()),
    );
  }
}
