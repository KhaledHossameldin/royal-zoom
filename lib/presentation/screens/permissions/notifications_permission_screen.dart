import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/brand_colors.dart';
import '../../../constants/routes.dart';
import '../../../data/services/repository.dart';
import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';

class NotificationsPermissionScreen extends StatelessWidget {
  const NotificationsPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context)!;
    final padding = EdgeInsets.symmetric(horizontal: 34.toWidth(context));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Material(),
          'notifications'.toPermissionImage,
          Padding(
            padding: padding,
            child: Column(
              children: [
                Text(
                  appLocalizations.translate('notifications_title'),
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall,
                ),
                30.toEmptyHeight(context),
                Text(
                  appLocalizations.translate('notifications_subtitle'),
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Padding(
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
                    appLocalizations.translate('activate_notifications'),
                  ),
                ),
                6.toEmptyHeight(context),
                TextButton(
                  onPressed: () => _goToLocation(context),
                  style: TextButton.styleFrom(
                    foregroundColor: BrandColors.darkGray,
                  ),
                  child: Text(
                    appLocalizations.translate('skip_step'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goToLocation(BuildContext context) {
    Repositroy.instance.setNotificationsPreferences();
    Navigator.pushReplacementNamed(
      context,
      Routes.locationPermssion,
    );
  }
}
