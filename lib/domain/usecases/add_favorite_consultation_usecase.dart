import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/user/user_consultations_repo_i.dart';

class AddFavoriteConsultationUseCase
    implements IAddFavoriteConsultationUseCase {
  final IUserConsultationRepo _repo;
  AddFavoriteConsultationUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call({required int id, int? category}) async {
    return await _repo.addFavoriteConsultation(id: id, category: category);
  }
}

abstract class IAddFavoriteConsultationUseCase {
  Future<Result<EmptyEntity>> call({required int id, int? category});
}
