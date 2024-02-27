import 'dart:io';

import '../../core/di/di_manager.dart';
import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../../data/models/consultants/verify_major_request_body.dart';
import '../repositories/consultant/major_repo_i.dart';
import 'upload_file_usecase.dart';

class VerifyConsultantMajorUseCase extends IVerifyConsultantMajorUseCase {
  final IConsultantMajorRepo _repo;
  final IUploadFileUseCase _uploadFileUseCase =
      DIManager.findDep<IUploadFileUseCase>();

  VerifyConsultantMajorUseCase(this._repo);

  @override
  Future<Result<EmptyEntity>> call({
    required VerifyRequestBody body,
  }) async {
    body = body.copyWith(
      resume: (await _uploadFileUseCase(File(body.resume))).data!,
      identityProof: (await _uploadFileUseCase(File(body.identityProof))).data!,
    );
    if (body.attachments.isNotEmpty) {
      body = body.copyWith(
        attachments: await Future.wait<String>(body.attachments.map((e) async {
          return (await _uploadFileUseCase(File(e))).data!;
        })),
      );
    }
    return await _repo.verify(body: body);
  }
}

abstract class IVerifyConsultantMajorUseCase {
  Future<Result<EmptyEntity>> call({
    required VerifyRequestBody body,
  });
}
