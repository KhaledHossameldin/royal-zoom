import '../../core/results/result.dart';
import '../entities/consultation_entity.dart';
import '../repositories/general/guest_repo_i.dart';

class ConsultationsUseCase implements IConsultationsUsecase {
  final IGuestRepo _repo;
  ConsultationsUseCase(this._repo);

  @override
  Future<Result<List<ConsultationEntity>>> call() async {
    return await _repo.getConsultations();
  }
}

abstract class IConsultationsUsecase {
  Future<Result<List<ConsultationEntity>>> call();
}
