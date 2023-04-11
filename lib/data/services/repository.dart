import 'package:flutter/material.dart';

import '../models/authentication/city.dart';
import '../models/authentication/country.dart';
import '../models/authentication/user.dart';
import '../models/major.dart';
import 'network_services.dart';
import 'shared_preferences_handler.dart';

class Repository {
  static Repository instance = Repository._();
  Repository._();

  final _network = NetworkServices.instance;
  final _sharedPreferences = SharedPreferencesHandler.instance;

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
    required int page,
  }) async =>
      _network.consultants(context, page: page);

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
}
