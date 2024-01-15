import 'package:flutter/material.dart';

import '../../../../localization/app_localizations.dart';
import '../../consultants/consultants_screen.dart';

class ConsultantsProfileScreen extends StatelessWidget {
  const ConsultantsProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.consultants)),
      body: const ConsultantsScreen(),
    );
  }
}
