import '../../core/results/result.dart';
import '../../core/usecases/format_consultation_usecase.dart';
import '../../data/enums/user_type.dart';
import '../entities/consultation_entity.dart';
import '../repositories/general/guest_repo_i.dart';
import '../repositories/user/user_consultations_repo_i.dart';

class ConsultationsUseCase implements IConsultationsUsecase {
  final IGuestRepo _guestRepo;
  final IUserConsultationRepo _userRepo;
  final IFormatConsultationUsecase _formatter;
  ConsultationsUseCase(this._guestRepo, this._userRepo, this._formatter);

  @override
  Future<Result<List<ConsultationEntity>>> call(UserType type) async {
    if (type == UserType.normal) {
      final data = await _guestRepo.getConsultations();
      if (data.hasDataOnly) {
        final result = data.data!.map((consultation) async {
          return await _formatter(consultation);
        }).toList();
        return Result(data: await Future.wait(result));
      }
      return data;
    }
    final data = await _userRepo.getUserConsultations();
    if (data.hasDataOnly) {
      final result = data.data!.map((consultation) async {
        return await _formatter(consultation);
      }).toList();
      return Result(data: await Future.wait(result));
    }
    return data;
  }
}

abstract class IConsultationsUsecase {
  Future<Result<List<ConsultationEntity>>> call(UserType type);
}
