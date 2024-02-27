import 'dart:io';

import '../../core/di/di_manager.dart';
import '../../core/models/empty_entity.dart';
import '../../core/results/result.dart';
import '../../data/models/consultants/update_consultant_major_body.dart';
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
  Future<Result<EmptyEntity>> verify({
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

  @override
  Future<Result<EmptyEntity>> changeStatus({
    required int id,
    required bool isFree,
  }) async {
    return await _repo.changeStatus(id: id, isFree: isFree);
  }

  @override
  Future<Result<EmptyEntity>> update({
    required UpdateConsultantMajorBody body,
  }) async {
    return await _repo.update(body: body);
  }
}

abstract class IConsultantMajorsUsecase {
  Future<Result<List<ConsultantMajorEntity>>> call();
  Future<Result<EmptyEntity>> verify({
    required VerifyRequestBody body,
  });
  Future<Result<EmptyEntity>> changeStatus({
    required int id,
    required bool isFree,
  });

  Future<Result<EmptyEntity>> update({
    required UpdateConsultantMajorBody body,
  });
}
