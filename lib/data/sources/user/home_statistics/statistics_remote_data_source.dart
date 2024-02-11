import 'dart:math';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/network/endpoints/network.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../models/home_statistics.dart';

class StatisticsDataSource {
  Future<Result<HomeStatistics>> getHomeStatistics() async {
    return await RemoteDataSource.request(
      converter: (model) => HomeStatistics.fromJson(model),
      method: HttpMethod.GET,
      url: Network.homeStatistics,
    );
  }

  Future<Result<int>> invoiceStatistics() async {
    return await RemoteDataSource.request(
      converter: (model) {
        final totalPaidInvoices =
            double.parse(model['total_paid_invoices'].toString());
        final totalInvoices = double.parse(model['total_invoices'].toString());
        return (totalPaidInvoices / max(totalInvoices, 1) * 100).round();
      },
      method: HttpMethod.GET,
      url: Network.statistics,
    );
  }
}
