import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/routes.dart';
import '../../../data/services/repository.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

class NotificationsPermissionScreen extends StatelessWidget {
  const NotificationsPermissionScreen({super.key});

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
          'notifications'.permissionImage,
          Padding(
            padding: padding,
            child: Column(
              children: [
                Text(
                  appLocalizations.notificationsTitle,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineLarge,
                ),
                30.emptyHeight,
                Text(
                  appLocalizations.notificationsSubtitle,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),
              ],
            ),
          ),
          _buildButtons(context, padding),
        ],
      ),
    );
  }

  Padding _buildButtons(BuildContext context, EdgeInsets padding) {
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
      padding: padding,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await Permission.notification.request();
              if (context.mounted) {
                _goToLocation(context);
              }
            },
            child: Text(
              appLocalizations.activateNotifications,
            ),
          ),
          6.emptyHeight,
          TextButton(
            onPressed: () => _goToLocation(context),
            child: Text(appLocalizations.skipStep),
          ),
        ],
      ),
    );
  }

  void _goToLocation(BuildContext context) {
    Repository.instance.setNotificationsPreferences();
    Navigator.pushReplacementNamed(
      context,
      Routes.locationPermssion,
    );
  }
}
