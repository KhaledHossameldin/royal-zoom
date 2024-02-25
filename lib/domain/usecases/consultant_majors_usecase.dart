import 'dart:io';

import 'package:logger/logger.dart';

import '../../core/di/di_manager.dart';
import '../../core/models/empty_model.dart';
import '../../core/results/result.dart';
import '../../data/models/consultants/verify_major_request_body.dart';
import '../entities/consultant_major_entity.dart';
import '../repositories/consultant/major_repo_i.dart';
import 'upload_file_usecase.dart';

class ConsultantMajorsUseCase implements IConsultantMajorsUsecase {
  final IConsultantMajorRepo _repo;
  final IUploadFileUseCase _uploadFileUseCase =
      DIManager.findDep<IUploadFileUseCase>();
  ConsultantMajorsUseCase(this._repo);

  @override
  Future<Result<List<ConsultantMajorEntity>>> call() async {
    return await _repo.getMajors();
  }

  @override
  Future<Result<EmptyModel>> verify({
    required VerifyRequestBody body,
  }) async {
    Logger().d(body);
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
    Logger().d(body);
    return await _repo.verify(body: body);
  }
}

abstract class IConsultantMajorsUsecase {
  Future<Result<List<ConsultantMajorEntity>>> call();
  Future<Result<EmptyModel>> verify({
    required VerifyRequestBody body,
  });
}
