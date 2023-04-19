import 'package:flutter/material.dart';

import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final materialLocalizations = MaterialLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.profile),
        actions: [
          IconButton(
            onPressed: () {},
            icon: 'search'.imageIcon,
            tooltip: materialLocalizations.searchFieldLabel,
          ),
        ],
      ),
      body: const Center(child: Text('Profile')),
    );
  }
}
