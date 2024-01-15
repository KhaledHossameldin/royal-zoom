import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/routes.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/brand_back_button.dart';

class TermsAndConditionsDetailsScreen extends StatelessWidget {
  const TermsAndConditionsDetailsScreen({super.key, required this.isGuest});

  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

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
        padding: EdgeInsets.symmetric(
          vertical: 5.height,
          horizontal: 16.width,
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'سياسة التسجيل',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: BrandColors.black,
                  ),
                ),
                Text(
                  '1.00',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Builder(builder: (context) {
              const textStyle = TextStyle(
                fontSize: 10.0,
                color: BrandColors.black,
                fontWeight: FontWeight.normal,
              );
              return const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('تاريخ الاصدار : 22/07/2022', style: textStyle),
                  Text('تاريخ التعديل : 22/07/2022', style: textStyle),
                ],
              );
            }),
            12.emptyHeight,
            const Text('body'),
          ],
        ),
      ),
    );
  }
}
