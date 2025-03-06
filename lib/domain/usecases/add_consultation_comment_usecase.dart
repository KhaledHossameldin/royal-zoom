import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../repositories/user/user_consultations_repo_i.dart';

class AddConsultationCommentUseCase implements IAddConsultationCommentUseCase {
  final IUserConsultationRepo _repo;
  AddConsultationCommentUseCase(this._repo);
  @override
  Future<Result<EmptyEntity>> call(
      {required int id, required String comment}) async {
    return await _repo.addConsultationComment(id: id, comment: comment);
  }
}

abstract class IAddConsultationCommentUseCase {
  Future<Result<EmptyEntity>> call({required int id, required String comment});
}
