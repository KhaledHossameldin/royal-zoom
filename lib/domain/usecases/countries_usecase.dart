import '../../core/results/result.dart';
import '../../data/models/authentication/country.dart';
import '../repositories/general/world_repo_i.dart';

class CountriesUseCase implements ICountriesUseCase {
  final IWorldRepo _repo;
  CountriesUseCase(this._repo);
  @override
  Future<Result<List<Country>>> call() async {
    return await _repo.getCountries();
  }
}

abstract class ICountriesUseCase {
  Future<Result<List<Country>>> call();
}
