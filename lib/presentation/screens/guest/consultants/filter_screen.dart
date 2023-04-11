import 'package:flutter/material.dart';

import '../../../../localization/app_localizations.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(appLocalizations.filter),
      ),
      body: Center(child: Text(appLocalizations.filter)),
    );
  }
}
