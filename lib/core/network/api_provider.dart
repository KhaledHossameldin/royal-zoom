import 'dart:io';

import 'package:dio/dio.dart';
import 'http_method.dart';

import '../../../core/di/di_manager.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/errors/cancel_error.dart';
import '../../../core/errors/custom_error.dart';
import '../../../core/errors/net_error.dart';
import '../../../core/errors/not_found_error.dart';
import '../../../core/errors/time_out_error.dart';
import '../../../core/errors/unauthorized_error.dart';
import '../../../core/errors/unexpected_error.dart';

import '../../../core/results/result.dart';

class ApiProvider {
  static Future<Result<T>> download<T>({
    required String url,
    ProgressCallback? onProgress,
  }) async {
    try {
      final dio = DIManager.findDep<Dio>();
      Response<T> response = await dio.get<T>(url,
          onReceiveProgress: onProgress,
          options: Options(
            headers: {HttpHeaders.acceptEncodingHeader: "*"},
            responseType: ResponseType.bytes,
          ));

      return Result(data: response.data);
    } on DioException catch (e) {
      return Result(error: _handleDioException(e));
    }
  }

  static Future<Result<T>> sendObjectRequest<T>({
    T Function(dynamic)? converter,
    T Function(List<dynamic>)? converterList,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool saveToken = false,
    FormData? formData,
    bool getAllResponse = false,
  }) async {
    try {
      late Response response;
      final dio = DIManager.findDep<Dio>();

      switch (method) {
        case HttpMethod.GET:
          response = await dio.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case HttpMethod.POST:
          response = await dio.post(
            url,
            data: data ?? formData,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case HttpMethod.PUT:
          response = await dio.put(
            url,
            data: data ?? formData,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case HttpMethod.DELETE:
          response = await dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
      }
      if (converterList != null) {
        return Result(data: converterList(response.data['data']));
      }
      if (getAllResponse) {
        return Result(data: converter!(response.data));
      }

      return Result(data: converter!(response.data['data']));
    }

    // Handling errors
    on DioException catch (e) {
      return Result(error: _handleDioException(e));
    }

    // Couldn't reach out the server
    on SocketException catch (_) {
      return Result(error: CustomError(message: 'Socket Error'));
    } catch (e) {
      return Result(error: CustomError(message: e.toString()));
    }
  }

  static BaseError _handleDioException(DioException error) {
    if (error.type == DioExceptionType.unknown ||
        error.type == DioExceptionType.badResponse) {
      if (error is SocketException) return NetError();
      if (error.type == DioExceptionType.badResponse) {
        switch (error.response!.statusCode) {
          case 401:
            return UnauthorizedError(
                message: error.response!.data['message'], code: 401);
          case 400:
          case 404:
            return NotFoundError(message: error.response!.data['message']);
          case 403:
          case 409:
          case 500:
            return NetError();
          default:
            return CustomError(message: error.response!.data['message']);
        }
      }
      return NetError();
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return TimeOutError();
    } else if (error.type == DioExceptionType.cancel) {
      return CancelError();
    } else {
      return UnExpectedError();
    }
  }
}
