import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/services/repository.dart';
import '../localization/app_localizations_setup.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this.currentLocale) : super(currentLocale);

  final Locale currentLocale;

  void switchLanguage(String symbol) {
    emit(Locale(symbol));
    Repository.instance.setLocalePreferences(symbol);
  }

  void toEnglish() {
    var en = AppLocalizationsSetup.supportedLocales.first;
    emit(en);
    Repository.instance.setLocalePreferences(en.languageCode);
  }

  void toArabic() {
    var ar = AppLocalizationsSetup.supportedLocales.last;
    emit(ar);
    Repository.instance.setLocalePreferences(ar.languageCode);
  }
}
