import '../../../core/base_repo/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../domain/entities/consultant_major_entity.dart';
import '../../../domain/entities/new_major_entity.dart';
import '../../../domain/repositories/consultant/major_repo_i.dart';
import '../../models/consultants/add_new_major_request_body.dart';
import '../../models/consultants/update_consultant_major_body.dart';
import '../../models/consultants/verify_major_request_body.dart';
import '../../sources/remote/consultant/major/major_remote_data_source.dart';

class ConsultantMajorRepo extends BaseRepository
    implements IConsultantMajorRepo {
  ConsultantMajorRepo(this._mRD);
  final MajorRemoteDataSource _mRD;

  @override
  Future<Result<EmptyEntity>> addNewMajorRequest(
      {required AddNewMajorRequestBody body}) async {
    final result = await _mRD.addNewMajorRequest(body: body);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<List<ConsultantMajorEntity>>> getMajors() async {
    final result = await _mRD.getMajors();
    return mapModelsToEntities(result);
  }

  @override
  Future<Result<EmptyEntity>> verifyMajor(
      {required VerifyRequestBody body}) async {
    final result = await _mRD.verifyMajor(body: body);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> changeMajorStatus({
    required int id,
    required bool isFree,
  }) async {
    final result = await _mRD.changeStatus(id: id, isFree: isFree);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> updateMajor({
    required UpdateConsultantMajorBody body,
  }) async {
    final result = await _mRD.update(body: body);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<EmptyEntity>> deleteMajor({required int id}) async {
    final result = await _mRD.delete(id: id);
    return mapModelToEntity(result);
  }

  @override
  Future<Result<List<NewMajorEntity>>> getMajorVerificationRequest() async {
    final result = await _mRD.getVerificationMajorRequests();
    return mapModelsToEntities(result);
  }

  @override
  Future<Result<List<NewMajorEntity>>> getMajorsRequests() async {
    final result = await _mRD.getMajorsRequests();
    return mapModelsToEntities(result);
  }
}
