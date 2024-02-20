import '../../../core/models/empty_model.dart';
import '../../../core/results/result.dart';
import '../../../data/models/consultants/add_new_major_request_body.dart';
import '../../entities/default_major_entity.dart';

abstract class IDefaultMajorRepo {
  Future<Result<List<DefaultMajorEntity>>> getMajors();
  Future<Result<EmptyModel>> addNewMajorRequest({
    required AddNewMajorRequestBody body,
  });
}
