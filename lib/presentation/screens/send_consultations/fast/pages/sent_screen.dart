import 'package:flutter/material.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../constants/fonts.dart';
import '../../../../../localization/app_localizations.dart';
import '../../../../../utilities/extensions.dart';

class FastConsultationSentScreen extends StatelessWidget {
  const FastConsultationSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 40.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox.square(
                  dimension: 280.width,
                  child: 'report'.lottieOneTime,
                ),
                25.emptyHeight,
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 17.0,
                      color: BrandColors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: appLocalizations.consultationSentTitle,
                        style: const TextStyle(color: BrandColors.orange),
                      ),
                      TextSpan(
                        text: ' ${ModalRoute.of(context)!.settings.arguments}',
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  appLocalizations.consultationSentSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                15.emptyHeight,
                Text(
                  appLocalizations.consultationSentNotifications,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.normal,
                      fontFamily: Fonts.main,
                    ),
                    children: [
                      TextSpan(text: appLocalizations.consultationSentContact),
                      const WidgetSpan(child: Icon(Icons.forum)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(appLocalizations.payment),
                  ),
                ),
                15.emptyWidth,
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                    child: Text(appLocalizations.skip),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
