import 'dart:io';

import '../../core/results/result.dart';
import '../../data/models/consultations/fast.dart';
import '../repositories/user/user_consultations_repo_i.dart';
import 'upload_file_usecase.dart';

class FastConsultationUseCase extends IFastConsultationUseCase {
  final IUserConsultationRepo _repo;
  final IUploadFileUseCase _mediaUsecase;
  FastConsultationUseCase(this._repo, this._mediaUsecase);
  @override
  Future<Result<int>> call(FastConsultation consultation) async {
    final files = await Future.wait(consultation.paths
        .map((path) async => await _mediaUsecase(File(path)))
        .toList());
    if (consultation.isVoice) {
      consultation = consultation.copyWith(content: files[0].data);
      files.removeAt(0);
    }
    final response = await _repo.fastConsultation(
        consultation:
            consultation.toMap(attachments: files.map((e) => e.data!).toList())
                as Map<String, Object>);
    return response;
  }
}

abstract class IFastConsultationUseCase {
  Future<Result<int>> call(FastConsultation consultation);
}
