import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/brand_back_button.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key, required this.isGuest});

  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      appBar: AppBar(
        leading: const BrandBackButton(),
        title: Text(appLocalizations.termsOfUseTitle),
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
              appLocalizations.termsOfUseTitle,
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

class _TermsItem extends StatelessWidget {
  const _TermsItem({
    required this.isGuest,
  });

  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.termsAndConditionsDetails,
        arguments: isGuest,
      ),
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16.height,
          horizontal: 20.width,
        ),
        child: Column(
          children: [
            Builder(builder: (context) {
              const textStyle = TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.normal,
                color: BrandColors.darkBlackGreen,
              );
              return const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('سياسة التسجيل', style: textStyle),
                  Text('1.00', style: textStyle),
                ],
              );
            }),
            9.emptyHeight,
            Builder(builder: (context) {
              final textStyle = TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade800,
              );
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('تاريخ الاصدار', style: textStyle),
                  Text('تاريخ التعديل', style: textStyle),
                ],
              );
            }),
            3.emptyHeight,
            Builder(builder: (context) {
              final textStyle = TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade700,
              );
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('22/07/2022', style: textStyle),
                  Text('22/07/2022', style: textStyle),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
