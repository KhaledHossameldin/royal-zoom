import 'package:flutter/material.dart';

import '../../localization/app_localizations.dart';

class CopyRight extends StatelessWidget {
  const CopyRight({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Text(appLocalizations.copyright, style: textTheme.bodySmall);
  }
}
