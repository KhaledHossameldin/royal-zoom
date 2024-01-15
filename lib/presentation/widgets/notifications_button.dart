import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../localization/app_localizations.dart';
import '../../utilities/extensions.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return IconButton(
      tooltip: appLocalizations.notifications,
      icon: Badge(isLabelVisible: false, child: 'notifications'.svg),
      onPressed: () => Navigator.pushNamed(context, Routes.notifications),
    );
  }
}
