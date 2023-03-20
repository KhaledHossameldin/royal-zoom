import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:royake_mobile/constants/preferences_keys.dart';

class SharedPreferencesHandler {
  Future<void> setLocale(String languageCode) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(PreferencesKeys.locale, languageCode);
  }

  Future<String> getLocale() async {
    if (kDebugMode) {
      return 'ar';
    }
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(PreferencesKeys.locale) ??
        Platform.localeName.substring(0, 2);
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
}
