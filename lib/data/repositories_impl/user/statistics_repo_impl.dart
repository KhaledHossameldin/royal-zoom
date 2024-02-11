import '../../../core/base_repo/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../domain/repositories/user/statistics_repo_i.dart';
import '../../models/home_statistics.dart';
import '../../sources/user/home_statistics/statistics_remote_data_source.dart';

class StatisticsRepo extends BaseRepository implements IStatisticsRepo {
  final StatisticsDataSource _sRD;
  StatisticsRepo(this._sRD);
  @override
  Future<Result<HomeStatistics>> getHomeStatistics() async {
    return await _sRD.getHomeStatistics();
  }

  @override
  Future<Result<int>> invoiceStatistics() async {
    return _sRD.invoiceStatistics();
  }
}
