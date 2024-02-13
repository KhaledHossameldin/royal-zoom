import 'package:dio/dio.dart';

import '../../data/sources/local/shared_prefs.dart';
import '../di/di_manager.dart';
import 'endpoints/network.dart';

abstract class NetworkModule {
  static Dio provideDio() {
    final dio = Dio();

    dio
      ..options.baseUrl = 'https://${Network.domain}/'
      ..options.connectTimeout =
          const Duration(seconds: Network.connectionTimeout)
      ..options.headers.putIfAbsent('Content-Type', () => 'application/json')
      ..options.headers.putIfAbsent('Accept', () => 'application/json')
      ..options.headers.putIfAbsent('Authorization',
          () async => await DIManager.findDep<SharedPrefs>().getToken())
      ..options.receiveTimeout =
          const Duration(seconds: Network.receiveTimeout);
    dio.interceptors.clear();

    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        error: true,
        responseHeader: true,
      ),
    ]);

    return dio;
  }
}
