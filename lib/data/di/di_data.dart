import '../../core/di/di_manager.dart';
import '../../domain/repositories/general/auth_repo_i.dart';
import '../repositories_impl/general/auth_repo_impl.dart';
import '../sources/consultant/major/major_remote_data_source.dart';
import '../sources/general/auth/auth_remote_data_source.dart';
import '../sources/general/media/media_remote_data_source.dart';
import '../sources/general/world/world_remote_data_source.dart';
import '../sources/user/home_statistics/statistics_remote_data_source.dart';
import '../sources/user/invoices/invoices_remote_data_source.dart';

void diData() {
  /// --------------- remote data sources --------------
  injectDep(AuthRemoteDataSource());
  injectDep(WorldRemoteDataSource());
  injectDep(MediaRemoteDataSource());
  injectDep(MajorRemoteDataSource());
  injectDep(InvoicesRemoteDataSource());
  injectDep(StatisticsDataSource());

  /// ------------------ repos ---------------------
  injectDep<IAuthRepo>(AuthRepo(DIManager.findDep()));
}
