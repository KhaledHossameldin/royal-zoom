import '../../../core/base_repo/base_repository.dart';
import '../../../core/models/empty_model.dart';
import '../../../core/results/result.dart';
import '../../../domain/entities/default_major_entity.dart';
import '../../../domain/repositories/consultant/major_repo_i.dart';
import '../../models/consultants/add_new_major_request_body.dart';
import '../../sources/remote/consultant/major/major_remote_data_source.dart';

class DefaultMajorRepo extends BaseRepository implements IDefaultMajorRepo {
  DefaultMajorRepo(this._mRD);
  final MajorRemoteDataSource _mRD;

  @override
  Future<Result<EmptyModel>> addNewMajorRequest(
      {required AddNewMajorRequestBody body}) async {
    final result = await _mRD.addNewMajorRequest(body: body);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<List<DefaultMajorEntity>>> getMajors() async {
    final result = await _mRD.getMajors();
    return mapModelsToEntities(result);
  }
}
