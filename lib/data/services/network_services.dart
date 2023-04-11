import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/network.dart';
import '../../localization/app_localizations.dart';
import '../models/authentication/user.dart';
import '../models/consultant.dart';
import 'app_exception.dart';
import 'shared_preferences_handler.dart';

class NetworkServices {
  static NetworkServices instance = NetworkServices._();

  NetworkServices._();

  Future<Map<String, Object>> consultants(
    BuildContext context, {
    required int page,
  }) async {
    final response = await _get(context, Network.consultants, params: {
      'page': '$page',
    });
    final jsonMap = json.decode(response);
    final consultants = (jsonMap['data'] as List)
        .map((item) => Consultant.fromMap(item))
        .toList();
    return {
      'consultants': consultants,
      'per_page': jsonMap['meta']['per_page'],
    };
  }

  Future<User> activate(
    BuildContext context, {
    required String username,
    required String code,
  }) async {
    final response = await _post(context, Network.activate, body: {
      'username': username,
      'code': code,
    });
    return User.fromJson(response);
  }

  Future<void> register(
    BuildContext context, {
    required String username,
    required String password,
    required String confirm,
  }) async {
    await _post(context, Network.register, body: {
      'username': username,
      'password': password,
      'password_confirmation': confirm,
    });
  }

  Future<void> reset(
    BuildContext context, {
    required String username,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _post(context, Network.reset, body: {
      'username': username,
      'code': code,
      'password': newPassword,
      'password_confirmation': confirmPassword,
    });
  }

  Future<void> resendOTP(
    BuildContext context, {
    required String username,
  }) async {
    await _post(context, Network.resend, body: {'username': username});
  }

  Future<void> checkOTP(
    BuildContext context, {
    required String username,
    required String code,
  }) async {
    await _post(context, Network.checkOTP, body: {
      'username': username,
      'code': code,
    });
  }

  Future<void> forgetPassword(
    BuildContext context, {
    required String username,
  }) async {
    await _post(context, Network.forget, body: {'username': username});
  }

  Future<User> login(
    BuildContext context, {
    required String username,
    required String password,
  }) async {
    final response = await _post(context, Network.login, body: {
      'username': username,
      'password': password,
    });
    return User.fromJson(response);
  }

  Future<String> _get(
    BuildContext context,
    String url, {
    Map<String, Object>? params,
  }) async {
    try {
      final response = await http
          .get(
            Uri.https(Network.domain, url, params),
            headers: await _getHeaders(context),
          )
          .timeout(const Duration(minutes: 1));
      return _processResponse(response);
    } catch (e) {
      throw _getExceptionString(context, error: e as Exception);
    }
  }

  Future<String> _post(
    BuildContext context,
    String url, {
    Map<String, Object>? body,
  }) async {
    try {
      final response = await http
          .post(
            Uri.https(Network.domain, url),
            headers: await _getHeaders(context),
            body: json.encode(body),
          )
          .timeout(const Duration(minutes: 1));
      return _processResponse(response);
    } catch (e) {
      throw _getExceptionString(context, error: e as Exception);
    }
  }

  Future<Map<String, String>> _getHeaders(BuildContext context) async => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            await SharedPreferencesHandler.instance.getToken(),
        HttpHeaders.acceptLanguageHeader:
            AppLocalizations.of(context).isEnLocale ? 'en' : 'ar',
      };

  String _getExceptionString(BuildContext context, {required Exception error}) {
    final appLocalizations = AppLocalizations.of(context);

    if (error is SocketException) {
      return appLocalizations.noInternetConnection;
    }
    if (error is HttpException) {
      return appLocalizations.httpError;
    }
    if (error is FormatException) {
      return appLocalizations.invalidDataFormat;
    }
    if (error is TimeoutException) {
      return appLocalizations.requestTimeout;
    }
    if (error is AppException) {
      if (error is UnauthorizedException && error.url.endsWith(Network.login)) {
        return '401${error.message}';
      }
      return error.message;
    }
    return appLocalizations.unknownError;
  }

  String _processResponse(http.Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        return response.body;

      case HttpStatus.badRequest:
        throw BadRequestException(
          json.decode(response.body)['message'],
          response.request!.url.toString(),
        );

      case HttpStatus.unauthorized:
        throw UnauthorizedException(
          json.decode(response.body)['message'],
          response.request!.url.toString(),
        );

      case HttpStatus.forbidden:
        throw UnauthorizedException(
          json.decode(response.body)['message'],
          response.request!.url.toString(),
        );

      case HttpStatus.notFound:
        throw NotFoundException(
          json.decode(response.body)['message'],
          response.request!.url.toString(),
        );

      default:
        throw FetchDataException(
          json.decode(response.body)['message'],
          response.request!.url.toString(),
        );
    }
  }
}
