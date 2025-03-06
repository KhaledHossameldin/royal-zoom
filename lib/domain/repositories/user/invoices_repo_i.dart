import '../../../core/results/result.dart';
import '../../../data/enums/invoice_type.dart';
import '../../../data/enums/payment_method.dart';
import '../../../data/models/invoices/invoicable/filter.dart';
import '../../../data/models/invoices/invoice.dart';
import '../../entities/wallet_payment_intention_entity.dart';

abstract class IInvoiceRepo {
  Future<Result<List<Invoice>>> getInvoices({
    required InvoiceType type,
    required InvoiceFilter filters,
  });
  Future<Result<WalletPaymentIntentionEnitity>> createWalletChargeRequest({
    required PaymentMethod method,
    required num amount,
  });
  Future<Result<Invoice>> getInvoice(
      {required int id, required InvoiceType type});
  Future<Result<bool>> checkInvoiceStatus({required num invoiceId});
}
