import '../../core/results/result.dart';
import '../entities/fav_consultation_entitiy.dart';
import '../repositories/user/user_consultations_repo_i.dart';

class FavoriteConsultationUseCase extends IFavoriteConsultationUseCase {
  final IUserConsultationRepo _repo;
  FavoriteConsultationUseCase(this._repo);
  @override
  Future<Result<List<FavoriteConsultationEntity>>> call() async {
    return await _repo.getFavoriteConsultations();
  }
}

abstract class IFavoriteConsultationUseCase {
  Future<Result<List<FavoriteConsultationEntity>>> call();
}
