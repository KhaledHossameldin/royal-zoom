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
            Text(
              appLocalizations.privacyPolicyTitle,
              style: textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              appLocalizations.userPolicies,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: List.generate(
                24,
                (index) => RichText(
                  text: TextSpan(children: [
                    if (appLocalizations.locale.languageCode == 'ar')
                      WidgetSpan(child: 12.emptyWidth),
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 5.0,
                      ),
                    ),
                    if (appLocalizations.locale.languageCode == 'en')
                      WidgetSpan(child: 12.emptyWidth),
                    TextSpan(
                      text: appLocalizations.getPolicies(index + 1),
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Droid Arabic Kufi',
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Text(
              appLocalizations.consultantsPolicies,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: List.generate(
                24,
                (index) => RichText(
                  text: TextSpan(children: [
                    if (appLocalizations.locale.languageCode == 'ar')
                      WidgetSpan(child: 12.emptyWidth),
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 5.0,
                      ),
                    ),
                    if (appLocalizations.locale.languageCode == 'en')
                      WidgetSpan(child: 12.emptyWidth),
                    TextSpan(
                      text: appLocalizations.getPolicies(index + 1),
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Droid Arabic Kufi',
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
