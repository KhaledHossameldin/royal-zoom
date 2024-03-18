// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';

import '../../core/di/di_manager.dart';
import '../../core/network/endpoints/network.dart';
import '../../localization/app_localizations.dart';
import '../../localization/localizor.dart';
import '../../utilities/extensions.dart';
import '../enums/chat_content_type.dart';
import '../enums/chat_resource_type.dart';
import '../enums/consultant_response_type.dart';
import '../enums/consultation_content_type.dart';
import '../enums/invoice_type.dart';
import '../enums/user_type.dart';
import '../models/appointments/appointment.dart';
import '../models/authentication/city.dart';
import '../models/authentication/country.dart';
import '../models/authentication/currency.dart';
import '../models/authentication/language.dart';
import '../models/authentication/timezone.dart';
import '../models/authentication/user.dart';
import '../models/authentication/user_data.dart';
import '../models/chat/chat.dart';
import '../models/chat/chat_message.dart';
import '../models/consultant_user/consultant_user.dart';
import '../models/consultants/available_time.dart';
import '../models/consultants/consultant.dart';
import '../models/consultants/details.dart';
import '../models/consultants/favorite.dart';
import '../models/consultations/consultation.dart';
import '../models/consultations/customized.dart';
import '../models/consultations/details.dart';
import '../models/consultations/fast.dart';
import '../models/consultations/favorite.dart';
import '../models/favorite_category.dart';
import '../models/home_statistics.dart';
import '../models/invoices/invoice.dart';
import '../models/major.dart';
import '../models/user_notification/user_notification.dart';
import '../sources/local/shared_prefs.dart';
import 'app_exception.dart';

class NetworkServices {
  static NetworkServices instance = NetworkServices._();

  NetworkServices._();

  Future<void> verifyMajor(
    BuildContext context, {
    required int majorId,
    required bool acceptPaidConsultations,
    required String resumePath,
    required String identityProofPath,
    required List<String> documents,
  }) async {
    final paths = await Future.wait<String>([
      _upload(context, path: resumePath),
      _upload(context, path: identityProofPath),
    ]);
    final documentsPaths = await Future.wait(
        documents.map((e) async => _upload(context, path: e)));
    final map = {
      'accept_paid_consultations': acceptPaidConsultations,
      'major_id': majorId,
      'documents': [
        {'major_document_id': 1, 'file': paths[0]},
        {'major_document_id': 2, 'file': paths[1]}
      ],
    };
    if (documentsPaths.isNotEmpty) {
      map.putIfAbsent('attachments', () => documentsPaths);
    }
    await _post(context, Network.majorVerificationRequests, body: map);
  }

  Future<UserData> getProfileData(
    BuildContext context, {
    required UserType type,
  }) async {
    final response = await _get(
      context,
      type == UserType.normal
          ? Network.showProfile
          : Network.showConsultantProfile,
    );
    final jsonMap = json.decode(response)['data'];
    return type == UserType.normal
        ? UserData.fromMap(jsonMap)
        : ConsultantUserData.fromMap(jsonMap);
  }

  Future<void> addNewMajorRequest(
    BuildContext context, {
    required int majorId,
    required bool isActive,
    required String yearsOfExperience,
    required String price,
    required String terms,
    required bool isNotificationsEnabled,
    required String? name,
  }) async {
    final map = {
      'major_id': majorId.toString(),
      'is_active': isActive.toInt.toString(),
      'years_of_experience': yearsOfExperience.toString(),
      'price_per_hour': price.toString(),
      'terms': terms,
      'is_notifications_enabled': isNotificationsEnabled.toInt.toString(),
      'is_free': 0,
    };
    if (name != null) {
      map.putIfAbsent('consultant_preview_name', () => name);
    }
    final response = await _post(context, Network.newMajorRequests, body: map);
    dev.log(response);
  }

  Future<void> updateConsultation(
    BuildContext context, {
    required int id,
    required ConsultantResponseType responseType,
  }) async =>
      await _put(context, '${Network.consultations}/$id',
          body: {'consultant_response_type': responseType.toMap()});

  Future<void> addConsultationComment(BuildContext context,
          {required int id, required String comment}) async =>
      await _post(context, Network.consultationComments(id),
          body: {'comment': comment});

  Future<void> rateConsultation(
    BuildContext context, {
    required int id,
    required int rate,
  }) async =>
      _post(
        context,
        Network.rateConsultation,
        body: {
          'resource_type': '1',
          'resource_id': id.toString(),
          'rating_value': rate.toString(),
        },
      );

  Future<void> rejectChangeTimeRequest(
    BuildContext context, {
    required int id,
  }) async =>
      _post(context, Network.rejectChangeTimeRequest(id));

  Future<void> acceptChangeTimeRequest(
    BuildContext context, {
    required int id,
  }) async =>
      _post(context, Network.acceptChangeTimeRequest(id));

  Future<void> cancelConsultation(
    BuildContext context, {
    required int id,
  }) async =>
      await _post(context, Network.cancelConsultation(id));

  Future<List<Appointment>> appointments(
    BuildContext context, {
    Map<String, Object>? params,
  }) async {
    final response = await _get(context, Network.appointments, params: params);
    return (json.decode(response)['data'] as List)
        .map((item) => Appointment.fromMap(item))
        .toList();
  }

  Future<List<FavoriteCategory>> favoriteCategories(
    BuildContext context, {
    required String type,
  }) async {
    final response = await _get(context, Network.favoriteCategories, params: {
      'type': type,
    });
    return (json.decode(response)['data'] as List)
        .map((item) => FavoriteCategory.fromMap(item))
        .toList();
  }

  Future<FavoriteCategory> addFavoriteCategory(
    BuildContext context, {
    required String name,
    required String type,
  }) async {
    final response = await _post(context, Network.favoriteCategories, body: {
      'name': name,
      'type': type,
    });
    return FavoriteCategory.fromMap(json.decode(response)['data']);
  }

  Future<List<FavoriteConsultant>> getFavoriteConsultants(
    BuildContext context,
  ) async {
    final response = await _get(context, Network.favoriteConsultants);
    return (json.decode(response)['data'] as List)
        .map((item) => FavoriteConsultant.fromMap(item))
        .toList();
  }

  Future<List<FavoriteConsultation>> getFavoriteConsultations(
    BuildContext context,
  ) async {
    final response = await _get(context, Network.favoriteConsultations);
    final jsonMap = json.decode(response);
    final consultations =
        await Future.wait((jsonMap['data'] as List).map((item) async {
      final consultation = FavoriteConsultation.fromMap(item);
      if (consultation.consultation.contentType ==
          ConsultationContentType.voice) {
        if (Platform.isIOS &&
            !consultation.consultation.content.toLowerCase().endsWith('.aac') &&
            !consultation.consultation.content
                .toLowerCase()
                .endsWith('.aiff') &&
            !consultation.consultation.content.toLowerCase().endsWith('.caf') &&
            !consultation.consultation.content.toLowerCase().endsWith('.mp3') &&
            !consultation.consultation.content.toLowerCase().endsWith('.mp4') &&
            !consultation.consultation.content.toLowerCase().endsWith('.m4p') &&
            !consultation.consultation.content.toLowerCase().endsWith('.wav')) {
          return consultation;
        }
        final player = AudioPlayer();
        await player.setUrl(consultation.consultation.content);
        await player.pause();
        consultation.consultation =
            consultation.consultation.copyWith(audioPlayer: player);
        return consultation;
      }
      return consultation;
    }).toList());
    return consultations;
  }

  Future<void> favoriteConsultation(
    BuildContext context, {
    required int id,
    int? category,
  }) async =>
      await _post(
        context,
        Network.favoriteConsultation(id),
        body: category != null ? {'favourite_category_id': category} : null,
      );

  Future<void> favoriteConsultant(
    BuildContext context, {
    required int id,
    int? category,
  }) async =>
      await _post(
        context,
        Network.favoriteConsultant(id),
        body: category != null ? {'favourite_category_id': category} : null,
      );

  Future<UserData> updateNotifications(
    BuildContext context, {
    required Map<String, Object> body,
  }) async {
    final response = await _put(
      context,
      Network.updateNotifications,
      body: body,
    );
    return UserData.fromMap(json.decode(response)['data']);
  }

  Future<List<Language>> languages(BuildContext context) async {
    final response = await _get(context, Network.languages);
    return (json.decode(response)['data'] as List)
        .map((timezone) => Language.fromMap(timezone))
        .toList();
  }

  Future<List<Currency>> currencies(BuildContext context) async {
    final response = await _get(context, Network.currencies);
    return (json.decode(response)['data'] as List)
        .map((timezone) => Currency.fromMap(timezone))
        .toList();
  }

  Future<List<Timezone>> timezones(BuildContext context) async {
    final response = await _get(context, Network.timezones);
    return (json.decode(response)['data'] as List)
        .map((timezone) => Timezone.fromMap(timezone))
        .toList();
  }

  Future<UserData> updateSettings(
    BuildContext context, {
    required Map<String, Object> body,
  }) async {
    final response = await _put(context, Network.updateSettings, body: body);
    return UserData.fromMap(json.decode(response)['data']);
  }

  Future<UserData> updateProfile(
    BuildContext context, {
    required Map<String, Object> body,
  }) async {
    if (body['image'] != null) {
      final image = await _upload(context, path: body['image']! as String);
      body['image'] = image;
    }
    final response = await _put(context, Network.updateProfile, body: body);
    return UserData.fromMap(json.decode(response)['data']);
  }

  Future<Map<String, Object>> notifications(BuildContext context,
      {required int page}) async {
    final response = await _get(context, Network.notifications,
        params: {'page': page.toString()});
    final jsonMap = json.decode(response);
    final notifications = (jsonMap['data'] as List)
        .map((item) => UserNotification.fromMap(item))
        .toList();
    return {
      'notifications': notifications,
      'per_page': jsonMap['meta']['per_page'],
    };
  }

  Future<ConsultantDetails> showConsultant(
    BuildContext context, {
    required int id,
  }) async {
    final response = await _get(context, '${Network.consultants}/$id');
    return ConsultantDetails.fromMap(json.decode(response)['data']);
  }

  Future<void> logout(BuildContext context) async =>
      await _post(context, Network.logout);

  Future<Chat> startChat(
    BuildContext context, {
    required int id,
    required ChatResourceType type,
  }) async {
    final response = await _post(context, Network.chats, body: {
      'resource_id': id,
      'resource_type': type.toMap(),
    });
    return Chat.fromMap(json.decode(response)['data']);
  }

  Future<ChatMessage> sendMessage(
    BuildContext context, {
    required int chatId,
    required String content,
    required ChatContentType type,
  }) async {
    String? path;
    if (type == ChatContentType.voice || type == ChatContentType.attachment) {
      path = await _upload(context, path: content);
    }
    await _post(context, Network.chatsMessages, body: {
      'chat_id': chatId.toString(),
      'content': path ?? content,
      'content_type': type.toMap().toString(),
    });
    // final chatMessage = ChatMessage.fromSentMap(json.decode(message)['data']);
    // if (chatMessage.contentType == ChatContentType.voice) {
    //   if (Platform.isIOS &&
    //       !chatMessage.content.toLowerCase().endsWith('.aac') &&
    //       !chatMessage.content.toLowerCase().endsWith('.aiff') &&
    //       !chatMessage.content.toLowerCase().endsWith('.caf') &&
    //       !chatMessage.content.toLowerCase().endsWith('.mp3') &&
    //       !chatMessage.content.toLowerCase().endsWith('.mp4') &&
    //       !chatMessage.content.toLowerCase().endsWith('.m4p') &&
    //       !chatMessage.content.toLowerCase().endsWith('.wav')) {
    //     return chatMessage;
    //   }
    //   final player = AudioPlayer();
    //   await player.setUrl(chatMessage.content);
    //   await player.pause();
    //   return chatMessage.copyWith(player: player);
    // }
    // return chatMessage;
    return Future(() => ChatMessage());
  }

  Future<List<ChatMessage>> chatMessages(
    BuildContext context, {
    required int id,
  }) async {
    final response = await _get(context, Network.getChatMessages(id));
    return await Future.wait(
        (json.decode(response)['data'] as List).map((item) async {
      final chatMessage = ChatMessage.fromMap(item);
      // if (chatMessage.contentType == ChatContentType.voice) {
      //   if (Platform.isIOS &&
      //       !chatMessage.content.toLowerCase().endsWith('.aac') &&
      //       !chatMessage.content.toLowerCase().endsWith('.aiff') &&
      //       !chatMessage.content.toLowerCase().endsWith('.caf') &&
      //       !chatMessage.content.toLowerCase().endsWith('.mp3') &&
      //       !chatMessage.content.toLowerCase().endsWith('.mp4') &&
      //       !chatMessage.content.toLowerCase().endsWith('.m4p') &&
      //       !chatMessage.content.toLowerCase().endsWith('.wav')) {
      //     return chatMessage;
      //   }
      //   final player = AudioPlayer();
      //   await player.setUrl(chatMessage.content);
      //   await player.pause();
      //   return chatMessage.copyWith(player: player);
      // }
      return chatMessage;
    }));
  }

  Future<List<Chat>> chats(BuildContext context) async {
    final response = await _get(context, Network.chats);
    return (json.decode(response)['data'] as List)
        .map((item) => Chat.fromMap(item))
        .toList();
  }

  Future<HomeStatistics> homeStatistics(BuildContext context) async {
    final response = await _get(context, Network.homeStatistics);
    return HomeStatistics.fromMap(json.decode(response)['data']);
  }

  Future<List<Consultation>> lastConsultations(BuildContext context) async {
    final response = await _get(context, Network.lastConsultations);
    final jsonMap = json.decode(response);
    final consultations =
        await Future.wait((jsonMap['data'] as List).map((item) async {
      final consultation = Consultation.fromMap(item);
      if (consultation.contentType == ConsultationContentType.voice) {
        if (Platform.isIOS &&
            !consultation.content.toLowerCase().endsWith('.aac') &&
            !consultation.content.toLowerCase().endsWith('.aiff') &&
            !consultation.content.toLowerCase().endsWith('.caf') &&
            !consultation.content.toLowerCase().endsWith('.mp3') &&
            !consultation.content.toLowerCase().endsWith('.mp4') &&
            !consultation.content.toLowerCase().endsWith('.m4p') &&
            !consultation.content.toLowerCase().endsWith('.wav')) {
          return consultation;
        }
        AudioPlayer player;
        try {
          player = AudioPlayer();
          await player.setUrl(consultation.content);
          await player.pause();
          return consultation.copyWith(audioPlayer: player);
        } catch (e) {
          return consultation;
        }
      }
      return consultation;
    }).toList());
    return consultations;
  }

  Future<int> statistics(BuildContext context) async {
    final response = await _get(context, Network.statistics);
    final jsonMap = json.decode(response)['data'];
    final totalPaidInvoices =
        double.parse(jsonMap['total_paid_invoices'].toString());
    final totalInvoices = double.parse(jsonMap['total_invoices'].toString());
    return (totalPaidInvoices / max(totalInvoices, 1) * 100).round();
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
      body: {
        'consultation_request_id': id.toString(),
        'appointment_date': date,
      },
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
    Logger().d(response);
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

  Future<List<Consultation>> allConsultations(BuildContext context) async {
    final response = await _get(context, Network.consultations);
    return await Future.wait(
        (json.decode(response)['data'] as List).map((item) async {
      final consultation = Consultation.fromMap(item);
      if (consultation.contentType == ConsultationContentType.voice) {
        if (Platform.isIOS &&
            !consultation.content.toLowerCase().endsWith('.aac') &&
            !consultation.content.toLowerCase().endsWith('.aiff') &&
            !consultation.content.toLowerCase().endsWith('.caf') &&
            !consultation.content.toLowerCase().endsWith('.mp3') &&
            !consultation.content.toLowerCase().endsWith('.mp4') &&
            !consultation.content.toLowerCase().endsWith('.m4p') &&
            !consultation.content.toLowerCase().endsWith('.wav')) {
          return consultation;
        }
        AudioPlayer player;
        try {
          player = AudioPlayer();
          await player.setUrl(consultation.content);
          await player.pause();
          return consultation.copyWith(audioPlayer: player);
        } catch (e) {
          return consultation;
        }
      }
      return consultation;
    }).toList());
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
        if (Platform.isIOS &&
            !consultation.content.toLowerCase().endsWith('.aac') &&
            !consultation.content.toLowerCase().endsWith('.aiff') &&
            !consultation.content.toLowerCase().endsWith('.caf') &&
            !consultation.content.toLowerCase().endsWith('.mp3') &&
            !consultation.content.toLowerCase().endsWith('.mp4') &&
            !consultation.content.toLowerCase().endsWith('.m4p') &&
            !consultation.content.toLowerCase().endsWith('.wav')) {
          return consultation;
        }
        AudioPlayer player;
        try {
          player = AudioPlayer();
          await player.setUrl(consultation.content);
          await player.pause();
          return consultation.copyWith(audioPlayer: player);
        } catch (e) {
          return consultation;
        }
      }
      return consultation;
    }).toList());
    return {
      'consultations': consultations,
      'per_page': jsonMap['meta']['per_page'],
    };
  }

  Future<int> customizedConsultation(
    BuildContext context, {
    required CustomizedConsultation consultation,
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
      Network.consultations,
      body: consultation.toMap(attachments: files),
    );
    return json.decode(response)['data']['id'];
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
      body: consultation.toMap(attachments: files) as Map<String, Object>,
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

  Future<List<Consultant>> allConsultants(BuildContext context) async {
    final response = await _get(context, Network.consultants);
    return (json.decode(response)['data'] as List)
        .map((item) => Consultant.fromMap(item))
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

  Future<String> _put(
    BuildContext context,
    String url, {
    Map<String, Object>? body,
  }) async {
    try {
      final response = await http
          .put(
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
            DIManager.findDep<SharedPrefs>().getToken(),
        HttpHeaders.acceptLanguageHeader:
            Localizor.translator.isEnLocale ? 'en' : 'ar',
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
