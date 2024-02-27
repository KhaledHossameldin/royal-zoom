import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

class Localizor {
  static late AppLocalizations translator;
  Localizor(BuildContext context) {
    translator = AppLocalizations.of(context);
  }
}
