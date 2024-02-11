import '../../../core/base_repo/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../domain/repositories/general/world_repo_i.dart';
import '../../models/authentication/city.dart';
import '../../models/authentication/country.dart';
import '../../models/authentication/currency.dart';
import '../../models/authentication/language.dart';
import '../../models/authentication/timezone.dart';
import '../../sources/general/world/world_remote_data_source.dart';

class WorldRepo extends BaseRepository implements IWorldRepo {
  final WorldRemoteDataSource _wRD;
  WorldRepo(this._wRD);
  @override
  Future<Result<List<City>>> getCities() async {
    return await _wRD.getCities();
  }

  @override
  Future<Result<List<Country>>> getCountries() async {
    return await _wRD.getCountries();
  }

  @override
  Future<Result<List<Currency>>> getCurrencies() async {
    return await _wRD.getCurrencies();
  }

  @override
  Future<Result<List<Language>>> getLanguages() async {
    return await _wRD.getLanguages();
  }

  @override
  Future<Result<List<Timezone>>> getTimeZones() async {
    return await _wRD.getTimeZones();
  }
}
