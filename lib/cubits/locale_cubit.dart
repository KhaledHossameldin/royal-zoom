import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../core/di/di_manager.dart';
import '../data/sources/local/shared_prefs.dart';
import '../localization/app_localizations_setup.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this.currentLocale) : super(currentLocale);

  final Locale currentLocale;

  void switchLanguage(String symbol) {
    emit(Locale(symbol));
    DIManager.findDep<SharedPrefs>().setLocale(symbol);
    Get.updateLocale(Locale(symbol));
  }

  void toEnglish() {
    var en = AppLocalizationsSetup.supportedLocales.first;
    emit(en);
    DIManager.findDep<SharedPrefs>().setLocale(en.languageCode);
    Get.updateLocale(en);
  }

  void toArabic() {
    var ar = AppLocalizationsSetup.supportedLocales.last;
    emit(ar);
    DIManager.findDep<SharedPrefs>().setLocale(ar.languageCode);
    Get.updateLocale(ar);
  }
}
