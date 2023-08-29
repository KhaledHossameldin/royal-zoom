// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

import '../../constants/network.dart';
import '../../localization/app_localizations.dart';
import '../enums/consultation_content_type.dart';
import '../enums/invoice_type.dart';
import '../models/authentication/city.dart';
import '../models/authentication/country.dart';
import '../models/authentication/user.dart';
import '../models/consultants/available_time.dart';
import '../models/consultants/consultant.dart';
import '../models/consultations/consultation.dart';
import '../models/consultations/details.dart';
import '../models/consultations/fast.dart';
import '../models/home_statistics.dart';
import '../models/invoices/invoice.dart';
import '../models/major.dart';
import 'app_exception.dart';
import 'shared_preferences_handler.dart';

class NetworkServices {
  static NetworkServices instance = NetworkServices._();

  NetworkServices._();

  Future<HomeStatistics> homeStatistics(BuildContext context) async {
    final response = await _get(context, Network.homeStatistics);
    return HomeStatistics.fromJson(response);
  }

  Future<List<Consultation>> lastConsultations(BuildContext context) async {
    final response = await _get(context, Network.lastConsultations);
    final jsonMap = json.decode(response);
    final consultations =
        await Future.wait((jsonMap['data'] as List).map((item) async {
      final consultation = Consultation.fromMap(item);
      if (consultation.contentType == ConsultationContentType.voice) {
        final player = AudioPlayer();
        await player.setUrl(consultation.content);
        await player.pause();
        return consultation.copyWith(audioPlayer: player);
      }
      return consultation;
    }).toList());
    return consultations;
  }

  Future<int> statistics(BuildContext context) async {
    final response = await _get(context, Network.statistics);
    final jsonMap = json.decode(response)['data'];
    final totalPaidInvoices =
        double.parse(jsonMap['total_paid_invoices'] as String);
    final totalInvoices = double.parse(jsonMap['total_invoices'] as String);
    return (totalPaidInvoices / totalInvoices * 100).round();
  }

  Future<List<Invoice>> invoices(
    BuildContext context, {
    required InvoiceType type,
    required Map<String, Object> params,
  }) async {
    final response = await _get(context, Network.invoices, params: params);
    return (json.decode(response)['data'] as List)
        .map((item) => Invoice.fromMap(item, type: type))
        .toList();
  }

  Future<int> changeAppointmentDate(
    BuildContext context, {
    required int id,
    required String date,
  }) async {
    final response = await _post(
      context,
      Network.consultationAppointmentRequests,
      {'consultation_request_id': id.toString(), 'appointment_date': date},
    );

    return json.decode(response)['data']['consultation_request_id'];
  }

  Future<ConsultationDetails> showConsultation(
    BuildContext context, {
    required int id,
    required AudioPlayer? player,
  }) async {
    final response = await _get(context, '${Network.consultations}/$id');
    ConsultationDetails consultationDetails =
        ConsultationDetails.fromJson(response);

    return consultationDetails.copyWith(audioPlayer: player);
  }

  Future<Map<String, List<ConsultantAvailableTime>>> consultantTimes(
    BuildContext context, {
    required int id,
  }) async {
    final response = await _get(context, Network.getConsultantimes(id));
    final jsonResponse = json.decode(response);
    if (context.mounted && jsonResponse['data'] is List) {
      throw AppLocalizations.of(context).availableTimesEmpty;
    }
    final Map<String, List<ConsultantAvailableTime>> map = {};
    for (var element
        in (jsonResponse['data'] as Map<String, dynamic>).entries) {
      map.putIfAbsent(
          element.key,
          () => (element.value as List<dynamic>)
              .map((e) => ConsultantAvailableTime.fromMap(e))
              .toList());
    }
    return map;
  }

  Future<Map<String, Object>> consultations(
    BuildContext context, {
    required Map<String, Object> params,
  }) async {
    final response = await _get(context, Network.consultations, params: params);
    final jsonMap = json.decode(response);

    final consultations =
        await Future.wait((jsonMap['data'] as List).map((item) async {
      final consultation = Consultation.fromMap(item);
      if (consultation.contentType == ConsultationContentType.voice) {
        final player = AudioPlayer();
        await player.setUrl(consultation.content);
        await player.pause();
        return consultation.copyWith(audioPlayer: player);
      }
      return consultation;
    }).toList());
    return {
      'consultations': consultations,
      'per_page': jsonMap['meta']['per_page'],
    };
  }

  Future<int> fastConsultation(
    BuildContext context, {
    required FastConsultation consultation,
  }) async {
    final files = await Future.wait(consultation.paths
        .map((e) async => await _upload(context, path: e))
        .toList());
    if (consultation.isVoice) {
      consultation = consultation.copyWith(content: files[0]);
      files.removeAt(0);
    }
    final response = await _post(
      context,
      Network.fastConsultation,
      consultation.toMap(attachments: files) as Map<String, Object>,
    );
    return json.decode(response)['data']['id'];
  }

  Future<List<City>> cities(
    BuildContext context, {
    required int countryId,
  }) async {
    final response = await _get(context, Network.cities, params: {
      'country_id': countryId.toString(),
    });
    return (json.decode(response)['data'] as List)
        .map((item) => City.fromMap(item))
        .toList();
  }

  Future<List<Country>> countries(BuildContext context) async {
    final response = await _get(context, Network.countries);
    return (json.decode(response)['data'] as List)
        .map((item) => Country.fromMap(item))
        .toList();
  }

  Future<List<Major>> majors(BuildContext context) async {
    final response = await _get(context, Network.majors);
    return (json.decode(response)['data'] as List)
        .map((item) => Major.fromMap(item))
        .toList();
  }

  Future<Map<String, Object>> consultants(
    BuildContext context, {
    required Map<String, Object> params,
  }) async {
    final response = await _get(context, Network.consultants, params: params);
    final jsonMap = json.decode(response);
    final consultants = (jsonMap['data'] as List)
        .map((item) => Consultant.fromMap(item))
        .toList();
    return {
      'consultants': consultants,
      'per_page': jsonMap['meta']?['per_page'] ?? '1',
    };
  }

  Future<User> activate(
    BuildContext context, {
    required String username,
    required String code,
  }) async {
    final response = await _post(context, Network.activate, {
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
    await _post(context, Network.register, {
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
    await _post(context, Network.reset, {
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
    await _post(context, Network.resend, {'username': username});
  }

  Future<void> checkOTP(
    BuildContext context, {
    required String username,
    required String code,
  }) async {
    await _post(context, Network.checkOTP, {
      'username': username,
      'code': code,
    });
  }

  Future<void> forgetPassword(
    BuildContext context, {
    required String username,
  }) async {
    await _post(context, Network.forget, {'username': username});
  }

  Future<User> login(
    BuildContext context, {
    required String username,
    required String password,
  }) async {
    final response = await _post(context, Network.login, {
      'username': username,
      'password': password,
    });
    return User.fromJson(response);
  }

  Future<String> _upload(
    BuildContext context, {
    required String path,
  }) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.https(Network.domain, Network.upload))
        ..headers.addAll(await _getHeaders(context))
        ..files.add(await http.MultipartFile.fromPath('file', path));

      final response = await request.send();
      final result = await response.stream.bytesToString();
      return json.decode(result)['path'];
    } catch (e) {
      throw _getExceptionString(context, error: e as Exception);
    }
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
    String url,
    Map<String, Object> body,
  ) async {
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

      case HttpStatus.created:
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
