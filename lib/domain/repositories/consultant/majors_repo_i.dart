import '../../../core/results/result.dart';
import '../../entities/new_major_entity.dart';

abstract class IMajorRepo {
  Future<Result<List<NewMajorEntity>>> getMajorsRequests();
  Future<Result<List<NewMajorEntity>>> getMajorVerificationRequest();
}
