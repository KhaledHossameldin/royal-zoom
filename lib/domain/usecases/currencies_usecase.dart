import '../../core/results/result.dart';
import '../../data/models/authentication/currency.dart';
import '../repositories/general/world_repo_i.dart';

class CurrenciesUseCase implements ICurrenciesUseCase {
  final IWorldRepo _repo;
  CurrenciesUseCase(this._repo);
  @override
  Future<Result<List<Currency>>> call() async {
    return await _repo.getCurrencies();
  }
}

abstract class ICurrenciesUseCase {
  Future<Result<List<Currency>>> call();
}
