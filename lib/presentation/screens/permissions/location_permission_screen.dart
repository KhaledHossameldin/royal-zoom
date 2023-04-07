import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/routes.dart';
import '../../../data/services/repository.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final padding = EdgeInsets.symmetric(horizontal: 34.width);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Material(),
          'location'.permissionImage,
          Padding(
            padding: padding,
            child: Column(
              children: [
                Text(
                  appLocalizations.locationTitle,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineLarge,
                ),
                30.emptyHeight,
                Text(
                  appLocalizations.locationSubtitle,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),
              ],
            ),
          ),
          _buildSkipButton(context, padding),
        ],
      ),
    );
  }

  Padding _buildSkipButton(BuildContext context, EdgeInsets padding) {
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
      padding: padding,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await Permission.location.request();
              if (context.mounted) {
                _goToLogin(context);
              }
            },
            child: Text(appLocalizations.permit),
          ),
          6.emptyHeight,
          TextButton(
            onPressed: () => _goToLogin(context),
            child: Text(appLocalizations.skipStep),
          ),
        ],
      ),
    );
  }

  void _goToLogin(BuildContext context) {
    Repository.instance.setLocationPreferences();
    Navigator.pushReplacementNamed(
      context,
      Routes.login,
    );
  }
}
