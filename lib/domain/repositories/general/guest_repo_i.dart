import '../../../core/results/result.dart';
import '../../../data/models/consultants/consultant.dart';
import '../../entities/consultation_entity.dart';
import '../../entities/major_entity.dart';

abstract class IGuestRepo {
  Future<Result<List<MajorEntity>>> getMajors();
  Future<Result<List<Consultant>>> getConsultants();
  Future<Result<List<ConsultationEntity>>> getConsultations();
}
