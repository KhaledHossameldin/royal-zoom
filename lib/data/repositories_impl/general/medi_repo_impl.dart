import 'dart:io';

import '../../../core/base_repo/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../domain/repositories/general/media_repo_i.dart';
import '../../sources/general/media/media_remote_data_source.dart';

class MediaRepo extends BaseRepository implements IMediaRepo {
  final MediaRemoteDataSource _mRD;
  MediaRepo(this._mRD);
  @override
  Future<Result<String>> uploadImage(File image) async {
    return await _mRD.uploadImage(image);
  }
}
