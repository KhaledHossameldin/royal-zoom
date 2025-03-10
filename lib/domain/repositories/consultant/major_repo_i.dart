import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../data/models/consultants/add_new_major_request_body.dart';
import '../../../data/models/consultants/update_consultant_major_body.dart';
import '../../../data/models/consultants/verify_major_request_body.dart';
import '../../entities/consultant_major_entity.dart';
import '../../entities/new_major_entity.dart';

abstract class IConsultantMajorRepo {
  Future<Result<List<ConsultantMajorEntity>>> getMajors();
  Future<Result<EmptyEntity>> addNewMajorRequest({
    required AddNewMajorRequestBody body,
  });
  Future<Result<EmptyEntity>> verifyMajor({
    required VerifyRequestBody body,
  });
  Future<Result<EmptyEntity>> changeMajorStatus({
    required int id,
    required bool isFree,
  });
  Future<Result<EmptyEntity>> updateMajor({
    required UpdateConsultantMajorBody body,
  });
  Future<Result<EmptyEntity>> deleteMajor({required int id});

  Future<Result<List<NewMajorEntity>>> getMajorsRequests();
  Future<Result<List<NewMajorEntity>>> getMajorVerificationRequest();
}
