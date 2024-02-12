import 'package:logger/logger.dart';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/models/empty_model.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../core/network/endpoints/network.dart';
import '../../../models/authentication/user.dart';

class AuthRemoteDataSource {
  Future<Result<EmptyModel>> register({
    required String username,
    required String password,
    required String confirm,
  }) async {
    return await RemoteDataSource.request(
        converter: (model) => EmptyModel(model),
        method: HttpMethod.POST,
        url: Network.register,
        data: {
          'username': username,
          'password': password,
          'password_confirmation': confirm,
        });
  }

  Future<Result<User>> login({
    required String username,
    required String password,
  }) async {
    return RemoteDataSource.request(
      converter: (model) {
        return User.fromMap(model);
      },
      method: HttpMethod.POST,
      url: Network.login,
      data: {
        'username': username,
        'password': password,
      },
      getAllResponse: true,
    );
  }

  Future<Result<EmptyModel>> logout() async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.logout,
    );
  }

  Future<Result<User>> activate({
    required String username,
    required String code,
  }) async {
    return await RemoteDataSource.request(
      converter: (model) => User.fromJson(model),
      method: HttpMethod.POST,
      url: Network.activate,
      data: {
        'username': username,
        'code': code,
      },
    );
  }

  Future<Result<EmptyModel>> resetPassword({
    required String username,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.reset,
      data: {
        'username': username,
        'code': code,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      },
    );
  }

  Future<Result<EmptyModel>> checkOTP({
    required String username,
    required String code,
  }) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.checkOTP,
      data: {
        'username': username,
        'code': code,
      },
    );
  }

  Future<Result<EmptyModel>> forgetPassword({required String username}) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.forget,
      data: {
        'username': username,
      },
    );
  }

  Future<Result<EmptyModel>> resendOTP({required String username}) async {
    return await RemoteDataSource.request(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: Network.resend,
      data: {'username': username},
    );
  }
}
