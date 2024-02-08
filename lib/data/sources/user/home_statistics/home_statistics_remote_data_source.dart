import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/network/endpoints/network.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../models/home_statistics.dart';

class HomeStatisticsDataSource {
  Future<Result<HomeStatistics>> homeStatistics() async {
    return await RemoteDataSource.request(
      converter: (model) => HomeStatistics.fromJson(model),
      method: HttpMethod.GET,
      url: Network.homeStatistics,
    );
  }
}
