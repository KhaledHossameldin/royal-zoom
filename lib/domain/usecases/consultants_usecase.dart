import '../../core/results/result.dart';
import '../../data/models/consultants/consultant.dart';
import '../repositories/general/guest_repo_i.dart';

class ConsultantsUseCase implements IConsultantsUsecase {
  final IGuestRepo _repo;
  ConsultantsUseCase(this._repo);

  @override
  Future<Result<List<Consultant>>> call() async {
    return await _repo.getConsultants();
  }
}

abstract class IConsultantsUsecase {
  Future<Result<List<Consultant>>> call();
}
