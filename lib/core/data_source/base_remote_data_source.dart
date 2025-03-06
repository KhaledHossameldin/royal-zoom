import 'package:dio/dio.dart';

import '../../../core/results/result.dart';
import '../../data/sources/local/shared_prefs.dart';
import '../di/di_manager.dart';
import '../network/api_provider.dart';
import '../network/http_method.dart';

abstract class RemoteDataSource {
  static Future<Result<MODEL>> request<MODEL>({
    MODEL Function(dynamic)? converter,
    MODEL Function(List<dynamic>?)? converterList,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
    FormData? formData,
    bool getAllResponse = false,
  }) async {
    headers ??= {};

    headers['Authorization'] = DIManager.findDep<SharedPrefs>().getToken();

    return await ApiProvider.sendObjectRequest<MODEL>(
      converter: converter,
      converterList: converterList,
      method: method,
      getAllResponse: getAllResponse,
      url: url,
      data: data,
      headers: headers,
      queryParameters: queryParameters,
      formData: formData,
    );
  }
}
