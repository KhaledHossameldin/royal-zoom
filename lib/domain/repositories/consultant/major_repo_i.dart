import '../../../core/models/empty_entity.dart';
import '../../../core/models/empty_model.dart';
import '../../../core/results/result.dart';
import '../../../data/models/consultants/add_new_major_request_body.dart';
import '../../../data/models/consultants/update_consultant_major_body.dart';
import '../../../data/models/consultants/verify_major_request_body.dart';
import '../../entities/consultant_major_entity.dart';

abstract class IConsultantMajorRepo {
  Future<Result<List<ConsultantMajorEntity>>> getMajors();
  Future<Result<EmptyModel>> addNewMajorRequest({
    required AddNewMajorRequestBody body,
  });
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
