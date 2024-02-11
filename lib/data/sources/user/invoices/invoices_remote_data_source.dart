import 'dart:math';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/network/endpoints/network.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../enums/invoice_type.dart';
import '../../../models/invoices/invoicable/filter.dart';
import '../../../models/invoices/invoice.dart';

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

  // Future<Result<int>> changeAppointmentDate() async {
  //   return await RemoteDataSource.request(
  //     converter: (model) {
  //       final totalPaidInvoices =
  //           double.parse(model['total_paid_invoices'].toString());
  //       final totalInvoices = double.parse(model['total_invoices'].toString());
  //       return (totalPaidInvoices / max(totalInvoices, 1) * 100).round();
  //     },
  //     method: HttpMethod.GET,
  //     url: Network.statistics,
  //   );
  // }
}
