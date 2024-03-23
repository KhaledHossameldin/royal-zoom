import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/preferences_keys.dart';
import '../../enums/user_type.dart';
import '../../models/authentication/user_data.dart';

class SharedPrefs {
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void setLocale(String languageCode) {
    _preferences.setString(PreferencesKeys.locale, languageCode);
    Intl.defaultLocale = languageCode;
  }

  String getLocale() {
    if (kDebugMode) {
      Intl.defaultLocale = 'ar';
      return 'ar';
    }

    final code = _preferences.getString(PreferencesKeys.locale) ??
        Platform.localeName.substring(0, 2);
    Intl.defaultLocale = code;
    return code;
  }

  bool getNotifications() {
    return _preferences.getBool(PreferencesKeys.notifications) ?? false;
  }

  void setNotifications() {
    _preferences.setBool(PreferencesKeys.notifications, true);
  }

  bool getLocation() {
    return _preferences.getBool(PreferencesKeys.location) ?? false;
  }

  void setLocation() {
    _preferences.setBool(PreferencesKeys.location, true);
  }

  void setToken(String token) {
    _preferences.setString(PreferencesKeys.token, token);
  }

  String getToken() {
    final token = _preferences.getString(PreferencesKeys.token) ?? '';
    return 'Bearer $token';
  }

  void setUser(UserData user) {
    if (isUserRemembered()) {
      _preferences.setString(PreferencesKeys.user, user.toJson());
    } else {
      _preferences.setString(PreferencesKeys.tempUser, user.toJson());
    }
  }

  UserData? getUser() {
    if (isUserRemembered()) {
      final userJson = _preferences.getString(PreferencesKeys.user);
      if (userJson == null) {
        return null;
      }
      return UserData.fromJson(userJson);
    }
    final userJson = _preferences.getString(PreferencesKeys.tempUser);
    if (userJson == null) {
      return null;
    }
    return UserData.fromJson(userJson);
  }

  void removeUser() {
    Future.wait([
      _preferences.remove(PreferencesKeys.user),
      _preferences.remove(PreferencesKeys.type),
      _forgetUser(),
    ]);
  }

  Future<void> removeTempUser() async {
    await _preferences.remove(PreferencesKeys.tempUser);
  }

  // void setUserData(UserData data, UserType type) {
  //   final user = getUser();
  //   if (user == null) {
  //     return;
  //   }
  //   setUser(user.copyWith(data: data));
  //   setUserType(type);
  // }

  void setUserType(UserType type) {
    _preferences.setInt(PreferencesKeys.type, type.toMap());
  }

  void rememberUser() {
    _preferences.setBool(PreferencesKeys.isRemembered, true);
  }

  bool isUserRemembered() =>
      _preferences.getBool(PreferencesKeys.isRemembered) ?? false;
  Future _forgetUser() =>
      _preferences.setBool(PreferencesKeys.isRemembered, false);

  UserType getUserType() {
    final type = _preferences.getInt(PreferencesKeys.type) ?? 1;
    return type.userTypeFromMap();
  }

  bool doesUserExist() {
    return _preferences.containsKey(PreferencesKeys.user);
  }

  void setFcmToken(String token) {
    _preferences.setString(PreferencesKeys.fcmToken, token);
  }
}
