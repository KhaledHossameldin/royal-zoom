import 'dart:io';

import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../../data/enums/consultant_response_type.dart';
import '../../data/enums/consultation_content_type.dart';
import '../repositories/user/user_consultations_repo_i.dart';
import 'upload_file_usecase.dart';

class UpdateConsultationUseCase implements IUpdateConsultationUseCase {
  final IUserConsultationRepo _repo;
  final IUploadFileUseCase _upload;
  UpdateConsultationUseCase(this._repo, this._upload);
  @override
  Future<Result<EmptyEntity>> call({
    required id,
    required ConsultantResponseType consultantResponseType,
    required ConsultationContentType contentType,
    required String content,
  }) async {
    if (contentType == ConsultationContentType.voice) {
      final result = await _upload(File(content));
      if (result.hasDataOnly) {
        return _repo.updateConsultation(
            id: id,
            consultantResponseType: consultantResponseType,
            contentType: contentType,
            content: result.data!);
      }
      return Result(error: result.error);
    }

    return await _repo.updateConsultation(
        id: id,
        consultantResponseType: consultantResponseType,
        contentType: contentType,
        content: content);
  }
}

abstract class IUpdateConsultationUseCase {
  Future<Result<EmptyEntity>> call({
    required id,
    required ConsultantResponseType consultantResponseType,
    required ConsultationContentType contentType,
    required String content,
  });
}
