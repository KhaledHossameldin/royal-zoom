import 'package:flutter/material.dart';

import '../../../localization/app_localizations.dart';
import '../../../utilities/extensions.dart';
import '../widgets/brand_back_button.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: const BrandBackButton(),
        title: Text(appLocalizations.notifications),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            'notifications'.lottie,
            Text(
              appLocalizations.notificationsEmpty,
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
