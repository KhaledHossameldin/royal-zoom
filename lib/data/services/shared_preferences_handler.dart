import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/preferences_keys.dart';
import '../enums/user_type.dart';
import '../models/authentication/user.dart';
import '../models/authentication/user_data.dart';

class SharedPreferencesHandler {
  static SharedPreferencesHandler instance = SharedPreferencesHandler._();
  SharedPreferencesHandler._();

  Future<void> setLocale(String languageCode) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(PreferencesKeys.locale, languageCode);
    Intl.defaultLocale = languageCode;
  }

  Future<String> getLocale() async {
    if (kDebugMode) {
      Intl.defaultLocale = 'ar';
      return 'ar';
    }
    final preferences = await SharedPreferences.getInstance();
    final code = preferences.getString(PreferencesKeys.locale) ??
        Platform.localeName.substring(0, 2);
    Intl.defaultLocale = code;
    return code;
  }

  Future<bool> getNotifications() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(PreferencesKeys.notifications) ?? false;
  }

  Future<void> setNotifications() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferencesKeys.notifications, true);
  }

  Future<bool> getLocation() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(PreferencesKeys.location) ?? false;
  }

  Future<void> setLocation() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferencesKeys.location, true);
  }

  Future<void> setToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(PreferencesKeys.token, token);
  }

  Future<String> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString(PreferencesKeys.token) ?? '';
    return 'Bearer $token';
  }

  Future<void> setUser(User user) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(PreferencesKeys.user, user.toJson());
  }

  Future<User?> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    final userJson = preferences.getString(PreferencesKeys.user);
    if (userJson == null) {
      return null;
    }
    return User.fromJson(userJson);
  }

  Future<void> removeUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.wait([
      preferences.remove(PreferencesKeys.user),
      preferences.remove(PreferencesKeys.type),
    ]);
  }

  Future<void> setUserData(UserData data, UserType type) async {
    final user = await getUser();
    if (user == null) {
      return;
    }
    await Future.wait([setUser(user.copyWith(data: data)), setUserType(type)]);
  }

  Future<void> setUserType(UserType type) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt(PreferencesKeys.type, type.toMap());
  }

  Future<UserType> getUserType() async {
    final preferences = await SharedPreferences.getInstance();
    final type = preferences.getInt(PreferencesKeys.type) ?? 1;
    return type.userTypeFromMap();
  }

  Future<bool> doesUserExist() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.containsKey(PreferencesKeys.user);
  }
}
