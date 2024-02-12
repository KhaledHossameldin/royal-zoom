import '../../core/results/result.dart';
import '../../data/models/authentication/language.dart';
import '../repositories/general/world_repo_i.dart';

class LanguagesUseCase implements ILanguagesUseCase {
  final IWorldRepo _repo;
  LanguagesUseCase(this._repo);
  @override
  Future<Result<List<Language>>> call() async {
    return await _repo.getLanguages();
  }
}

abstract class ILanguagesUseCase {
  Future<Result<List<Language>>> call();
}
