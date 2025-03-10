import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/di/di_manager.dart';
import '../enums/chat_content_type.dart';
import '../enums/chat_resource_type.dart';
import '../enums/consultant_response_type.dart';
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
import '../sources/local/shared_prefs.dart';
import 'audio_handler.dart';
import 'location_services.dart';
import 'network_services.dart';
import 'pusher_handler.dart';

class Repository {
  static Repository instance = Repository._();
  Repository._();

  final _network = NetworkServices.instance;
  final _sharedPreferences = DIManager.findDep<SharedPrefs>();
  final _location = LocationServices.instance;
  final _audio = AudioHandler.instance;
  final _pusher = PusherHandler.instance;

  Future<void> initializePusher() async => await _pusher.init();

  Future<void> connect(int id, dynamic onEvent) async =>
      _pusher.connect(id, onEvent);

  void disconnect(int id) => _pusher.disconnect(id);

  Future<void> playAudio() async => await _audio.play();

  Future<void> setAudioFilePath(String path) async => _audio.setFilePath(path);

  Future<Duration?> setAudioUrl(String url) async => await _audio.setUrl(url);

  void disposeAudio() => _audio.dispose();

  Future<void> verifyMajor(
    BuildContext context, {
    required int majorId,
    required bool acceptPaidConsultations,
    required String resumePath,
    required String identityProofPath,
    required List<String> documents,
  }) async =>
      await _network.verifyMajor(
        context,
        majorId: majorId,
        acceptPaidConsultations: acceptPaidConsultations,
        resumePath: resumePath,
        identityProofPath: identityProofPath,
        documents: documents,
      );

  Future<UserData> getProfileData(
    BuildContext context, {
    required UserType type,
  }) async {
    final data = await _network.getProfileData(context, type: type);
    if (_sharedPreferences.doesUserExist()) {
      _sharedPreferences.setUserType(type);
      _sharedPreferences.setUser(data);
    }
    return data;
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
  }) async =>
      _network.addNewMajorRequest(
        context,
        majorId: majorId,
        isActive: isActive,
        yearsOfExperience: yearsOfExperience,
        price: price,
        terms: terms,
        isNotificationsEnabled: isNotificationsEnabled,
        name: name,
      );

  Future<void> updateConsultation(BuildContext context,
          {required int id,
          required ConsultantResponseType responseType}) async =>
      _network.updateConsultation(context, id: id, responseType: responseType);

  Future<void> addConsultationComment(BuildContext context,
          {required int id, required String comment}) async =>
      _network.addConsultationComment(context, id: id, comment: comment);

  Future<void> rateConsultation(
    BuildContext context, {
    required int id,
    required int rate,
  }) async =>
      _network.rateConsultation(context, id: id, rate: rate);

  Future<void> rejectChangeTimeRequest(
    BuildContext context, {
    required int id,
  }) async =>
      _network.rejectChangeTimeRequest(context, id: id);

  Future<void> acceptChangeTimeRequest(
    BuildContext context, {
    required int id,
  }) async =>
      _network.acceptChangeTimeRequest(context, id: id);

  Future<void> cancelConsultation(
    BuildContext context, {
    required int id,
  }) async =>
      _network.cancelConsultation(context, id: id);

  Future<List<Consultant>> allConsultants(BuildContext context) async =>
      _network.allConsultants(context);

  Future<List<Consultation>> allConsultations(BuildContext context) async =>
      _network.allConsultations(context);

  Future<List<Appointment>> appointments(
    BuildContext context, {
    Map<String, Object>? params,
  }) async =>
      _network.appointments(context, params: params);

  Future<List<FavoriteCategory>> favoriteCategories(
    BuildContext context, {
    required String type,
  }) async =>
      _network.favoriteCategories(context, type: type);

  Future<FavoriteCategory> addFavoriteCategory(
    BuildContext context, {
    required String name,
    required String type,
  }) async =>
      _network.addFavoriteCategory(context, name: name, type: type);

  Future<List<FavoriteConsultant>> getFavoriteConsultants(
    BuildContext context,
  ) async =>
      _network.getFavoriteConsultants(context);

  Future<List<FavoriteConsultation>> getFavoriteConsultations(
    BuildContext context,
  ) async =>
      _network.getFavoriteConsultations(context);

  Future<void> favoriteConsultation(
    BuildContext context, {
    required int id,
    int? category,
  }) async =>
      await _network.favoriteConsultation(context, id: id, category: category);

  Future<void> favoriteConsultant(
    BuildContext context, {
    required int id,
    int? category,
  }) async =>
      await _network.favoriteConsultant(context, id: id, category: category);

  Future<UserData> updateNotifications(
    BuildContext context, {
    required Map<String, Object> body,
  }) async =>
      _network.updateNotifications(context, body: body);

  Future<List<Language>> languages(BuildContext context) async =>
      _network.languages(context);

  Future<List<Currency>> currencies(BuildContext context) async =>
      _network.currencies(context);

  Future<List<Timezone>> timezones(BuildContext context) async =>
      _network.timezones(context);

  Future<UserData> updateSettings(BuildContext context,
          {required Map<String, Object> body}) async =>
      _network.updateSettings(context, body: body);

  Future<UserData> updateProfile(BuildContext context,
          {required Map<String, Object> body}) async =>
      _network.updateProfile(context, body: body);

  Future<Map<String, Object>> notifications(BuildContext context,
          {required int page}) async =>
      _network.notifications(context, page: page);

  Future<ConsultantDetails> showConsultant(BuildContext context,
          {required String username}) async =>
      _network.showConsultant(context, username: username);

  Future<void> logout(BuildContext context) async {
    await _network.logout(context);
    _sharedPreferences.removeUser();
  }

  Future<void> setUserType(UserType type) async =>
      _sharedPreferences.setUserType(type);

  Future<UserType> getUserType() async => _sharedPreferences.getUserType();

  Future<Chat> startChat(BuildContext context,
          {required int id, required ChatResourceType type}) async =>
      _network.startChat(context, id: id, type: type);

  Future<ChatMessage> sendMessage(
    BuildContext context, {
    required int chatId,
    required String content,
    required ChatContentType type,
  }) async =>
      _network.sendMessage(
        context,
        chatId: chatId,
        content: content,
        type: type,
      );

  Future<List<ChatMessage>> chatMessages(BuildContext context,
          {required int id}) async =>
      _network.chatMessages(context, id: id);

  Future<List<Chat>> chats(BuildContext context) async =>
      _network.chats(context);

  Future<HomeStatistics> homeStatistics(BuildContext context) async =>
      _network.homeStatistics(context);

  Future<List<Consultation>> lastConsultations(BuildContext context) async =>
      _network.lastConsultations(context);

  Future<int> statistics(BuildContext context) async =>
      _network.statistics(context);

  Future<List<Invoice>> invoices(
    BuildContext context, {
    required InvoiceType type,
    required Map<String, Object> params,
  }) async =>
      _network.invoices(context, type: type, params: params);

  Future<int> changeAppointmentDate(
    BuildContext context, {
    required int id,
    required String date,
  }) async =>
      _network.changeAppointmentDate(context, id: id, date: date);

  Future<ConsultationDetails> showConsultation(
    BuildContext context, {
    required int id,
    required AudioPlayer? player,
  }) async =>
      _network.showConsultation(context, id: id, player: player);

  Future<Map<String, List<ConsultantAvailableTime>>> consultantTimes(
    BuildContext context, {
    required int id,
  }) async =>
      _network.consultantTimes(context, id: id);

  Future<Map<String, Object>> consultations(
    BuildContext context, {
    required Map<String, Object> params,
  }) async =>
      _network.consultations(context, params: params);

  Future<int> customizedConsultation(
    BuildContext context, {
    required CustomizedConsultation consultation,
  }) async =>
      _network.customizedConsultation(context, consultation: consultation);

  Future<int> fastConsultation(
    BuildContext context, {
    required FastConsultation consultation,
  }) async =>
      _network.fastConsultation(context, consultation: consultation);

  Future<List<City>> cities(
    BuildContext context, {
    required int countryId,
  }) async =>
      _network.cities(context, countryId: countryId);

  Future<List<Country>> countries(BuildContext context) async =>
      await _network.countries(context);

  Future<List<Major>> majors(BuildContext context) async =>
      await _network.majors(context);

  Future<Map<String, Object>> consultants(
    BuildContext context, {
    required Map<String, Object> params,
  }) async =>
      _network.consultants(context, params: params);

  Future<User> activate(
    BuildContext context, {
    required String username,
    required String code,
  }) async =>
      await _network.activate(context, username: username, code: code);

  Future<void> register(
    BuildContext context, {
    required String username,
    required String password,
    required String confirm,
  }) async =>
      _network.register(
        context,
        username: username,
        password: password,
        confirm: confirm,
      );

  Future<void> resendOTP(
    BuildContext context, {
    required String username,
  }) async =>
      await _network.resendOTP(context, username: username);

  Future<void> reset(
    BuildContext context, {
    required String username,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async =>
      await _network.reset(
        context,
        username: username,
        code: code,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

  Future<void> checkOTP(
    BuildContext context, {
    required String username,
    required String code,
  }) async =>
      await _network.checkOTP(context, username: username, code: code);

  Future<void> forgetPassword(
    BuildContext context, {
    required String username,
  }) async =>
      await _network.forgetPassword(context, username: username);

  Future<User> login(
    BuildContext context, {
    required String username,
    required String password,
    required bool isRemember,
  }) async {
    final user = await _network.login(
      context,
      username: username,
      password: password,
    );
    _sharedPreferences.setToken(user.token);
    if (isRemember) {
      await setUser(user.data);
    }
    return user;
  }

  Future<void> setUser(UserData user) async => _sharedPreferences.setUser(user);

  Future<UserData?> getUser() async => _sharedPreferences.getUser();

  Future<void> setLocalePreferences(String languageCode) async =>
      _sharedPreferences.setLocale(languageCode);

  Future<String> getLocalePreferences() async => _sharedPreferences.getLocale();

  Future<bool> getNotificationsPreferences() async =>
      _sharedPreferences.getNotifications();

  Future<void> setNotificationsPreferences() async =>
      _sharedPreferences.setNotifications();

  Future<bool> getLocationPreferences() async =>
      _sharedPreferences.getLocation();

  Future<void> setLocationPreferences() async =>
      _sharedPreferences.setLocation();

  Future<void> setTokenPreferences(String token) async =>
      _sharedPreferences.setToken(token);

  Future<String> getTokenPreferences() async => _sharedPreferences.getToken();

  Future<void> setCurrentLocation({bool isFromMain = false}) async =>
      await _location.setCurrent(isFromMain);

  Placemark get currentLocation => _location.current;
}
