import '../../../core/base_repo/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../domain/entities/consultation_entity.dart';
import '../../../domain/entities/major_entity.dart';
import '../../../domain/repositories/general/guest_repo_i.dart';
import '../../models/consultants/consultant.dart';
import '../../sources/general/guest/guest_remote_data_source.dart';

class GuestRepo extends BaseRepository implements IGuestRepo {
  final GuestRemoteDataSource _gRD;
  GuestRepo(this._gRD);

  @override
  Future<Result<List<Consultant>>> getConsultants() async {
    return await _gRD.getConsultants();
  }

  @override
  Future<Result<List<ConsultationEntity>>> getConsultations() async {
    final result = await _gRD.getConsultations();
    return mapModelsToEntities(result);
  }

  @override
  Future<Result<List<MajorEntity>>> getMajors() async {
    final result = await _gRD.getMajors();
    return mapModelsToEntities(result);
  }
}
