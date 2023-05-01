import 'package:flutter/material.dart';

import '../../../../constants/routes.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/brand_back_button.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key, required this.isGuest});

  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      appBar: AppBar(
        leading: const BrandBackButton(),
        title: Text(appLocalizations.privacyPolicyTitle),
        actions: isGuest
            ? [
                TextButton.icon(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                    (route) => false,
                  ),
                  icon: 'profile'.svg,
                  label: Text(appLocalizations.register),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          16.width,
          12.height,
          16.width,
          bottomViewPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: appLocalizations.privacyPolicy,
              child: Text(
                appLocalizations.privacyPolicyTitle,
                style: textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              appLocalizations.privacyPolicySubtitle,
              style: textTheme.labelSmall,
            ),
            12.emptyHeight,
            Text(
              appLocalizations.privacyPolicyContent,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
