import 'package:flutter/material.dart';

import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/brand_back_button.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.privacyPolicyTitle),
        leading: const BrandBackButton(),
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
