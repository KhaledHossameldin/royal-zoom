import 'dart:io';

import '../../core/results/result.dart';
import '../repositories/general/media_repo_i.dart';

class UploadFileUseCase implements IUploadFileUseCase {
  final IMediaRepo _repo;
  UploadFileUseCase(this._repo);
  @override
  Future<Result<String>> call(File file) async {
    return await _repo.uploadImage(file);
  }
}

abstract class IUploadFileUseCase {
  Future<Result<String>> call(File file);
}
