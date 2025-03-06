import '../../../core/results/result.dart';
import '../../../data/models/home_statistics.dart';

abstract class IStatisticsRepo {
  Future<Result<int>> invoiceStatistics();
  Future<Result<HomeStatistics>> getHomeStatistics();
}
