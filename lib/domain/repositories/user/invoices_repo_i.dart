import '../../../core/results/result.dart';
import '../../../data/enums/invoice_type.dart';
import '../../../data/models/invoices/invoicable/filter.dart';
import '../../../data/models/invoices/invoice.dart';

abstract class IInvoiceRepo {
  Future<Result<List<Invoice>>> getInvoices({
    required InvoiceType type,
    required InvoiceFilter filters,
  });
}
