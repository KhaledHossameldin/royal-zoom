import '../../../core/base_repo/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../domain/entities/new_major_entity.dart';
import '../../../domain/repositories/consultant/majors_repo_i.dart';
import '../../sources/remote/consultant/major/major_remote_data_source.dart';

class MajorRepo extends BaseRepository implements IMajorRepo {
  final MajorRemoteDataSource _mRD;
  MajorRepo(this._mRD);

  @override
  Future<Result<List<NewMajorEntity>>> getMajorsRequests() async {
    final result = await _mRD.getMajorsRequests();
    return mapModelsToEntities(result);
  }

  @override
  Future<Result<List<NewMajorEntity>>> getMajorVerificationRequest() async {
    final result = await _mRD.getVerificationMajorRequests();
    return mapModelsToEntities(result);
  }
}
