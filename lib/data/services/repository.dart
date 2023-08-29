import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:just_audio/just_audio.dart';

import '../enums/invoice_type.dart';
import '../models/authentication/city.dart';
import '../models/authentication/country.dart';
import '../models/authentication/user.dart';
import '../models/consultants/available_time.dart';
import '../models/consultations/consultation.dart';
import '../models/consultations/details.dart';
import '../models/consultations/fast.dart';
import '../models/home_statistics.dart';
import '../models/invoices/invoice.dart';
import '../models/major.dart';
import 'audio_handler.dart';
import 'location_services.dart';
import 'network_services.dart';
import 'shared_preferences_handler.dart';

class Repository {
  static Repository instance = Repository._();
  Repository._();

  final _network = NetworkServices.instance;
  final _sharedPreferences = SharedPreferencesHandler.instance;
  final _location = LocationServices.instance;
  final _audio = AudioHandler.instance;

  Future<void> playAudio() async => await _audio.play();

  Future<void> setAudioFilePath(String path) async => _audio.setFilePath(path);

  Future<Duration?> setAudioUrl(String url) async => await _audio.setUrl(url);

  void disposeAudio() => _audio.dispose();

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
    await _sharedPreferences.setToken(user.token);
    if (isRemember) {
      await _sharedPreferences.setUser(user);
    }
    return user;
  }

  Future<void> removeUser() async => await _sharedPreferences.removeUser();

  Future<User?> getUser() async => await _sharedPreferences.getUser();

  Future<void> setLocalePreferences(String languageCode) async =>
      await _sharedPreferences.setLocale(languageCode);

  Future<String> getLocalePreferences() async =>
      await _sharedPreferences.getLocale();

  Future<bool> getNotificationsPreferences() async =>
      await _sharedPreferences.getNotifications();

  Future<void> setNotificationsPreferences() async =>
      await _sharedPreferences.setNotifications();

  Future<bool> getLocationPreferences() async =>
      await _sharedPreferences.getLocation();

  Future<void> setLocationPreferences() async =>
      await _sharedPreferences.setLocation();

  Future<void> setTokenPreferences(String token) async =>
      await _sharedPreferences.setToken(token);

  Future<String> getTokenPreferences() async =>
      await _sharedPreferences.getToken();

  Future<void> setCurrentLocation({bool isFromMain = false}) async =>
      await _location.setCurrent(isFromMain);

  Placemark get currentLocation => _location.current;
}
