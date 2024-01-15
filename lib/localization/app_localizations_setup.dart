import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

class AppLocalizationsSetup {
  static const Iterable<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
      [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
