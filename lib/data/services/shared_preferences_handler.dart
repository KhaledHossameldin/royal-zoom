import 'dart:io';

import 'package:royake_mobile/constants/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHandler {
  Future<void> setLocale(String languageCode) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(PreferencesKeys.locale, languageCode);
  }

  Future<String> getLocale() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(PreferencesKeys.locale) ??
        Platform.localeName.substring(0, 2);
  }
}
