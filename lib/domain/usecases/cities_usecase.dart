import '../../core/results/result.dart';
import '../../data/models/authentication/city.dart';
import '../repositories/general/world_repo_i.dart';

class CitiesUseCase implements ICitiesUseCase {
  final IWorldRepo _repo;
  CitiesUseCase(this._repo);
  @override
  Future<Result<List<City>>> call() async {
    return await _repo.getCities();
  }
}

abstract class ICitiesUseCase {
  Future<Result<List<City>>> call();
}
