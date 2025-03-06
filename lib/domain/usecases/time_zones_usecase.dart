import '../../core/results/result.dart';
import '../../data/models/authentication/timezone.dart';
import '../repositories/general/world_repo_i.dart';

class TimeZonesUseCase implements ITimeZonesUseCase {
  final IWorldRepo _repo;
  TimeZonesUseCase(this._repo);
  @override
  Future<Result<List<Timezone>>> call() async {
    return await _repo.getTimeZones();
  }
}

abstract class ITimeZonesUseCase {
  Future<Result<List<Timezone>>> call();
}
