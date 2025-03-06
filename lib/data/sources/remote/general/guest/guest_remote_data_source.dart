import '../../../../../core/data_source/base_remote_data_source.dart';
import '../../../../../core/network/endpoints/network.dart';
import '../../../../../core/network/http_method.dart';
import '../../../../../core/results/result.dart';
import '../../../../models/consultants/consultant.dart';
import '../../../../models/consultations/consultation.dart';
import '../../../../models/major.dart';

class GuestRemoteDataSource {
  Future<Result<List<Major>>> getMajors() async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((major) => Major.fromJson(major)).toList(),
      method: HttpMethod.GET,
      url: Network.majors,
    );
  }

  Future<Result<List<Consultant>>> getConsultants() async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((consultant) => Consultant.fromJson(consultant)).toList(),
      method: HttpMethod.GET,
      url: Network.consultants,
    );
  }

  Future<Result<List<Consultation>>> getConsultations() async {
    return await RemoteDataSource.request(
      converterList: (list) => list!
          .map((conslutation) => Consultation.fromJson(conslutation))
          .toList(),
      method: HttpMethod.GET,
      url: Network.guestConsultations,
    );
  }
}
