import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/border_painter.dart';

class ConsultationContentScreen extends StatelessWidget {
  const ConsultationContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 1.2,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              '${appLocalizations.send} ${appLocalizations.normalConsultation}',
            ),
            Text(
              '1 - ${appLocalizations.chooseConsultant}',
              style: const TextStyle(color: BrandColors.gray),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 27.width),
            child: CustomPaint(
              painter: BorderPainter(
                stroke: 3.0,
                padding: 8.width,
                progress: 0.67,
              ),
              child: const Center(
                child: Text.rich(
                  style: TextStyle(color: BrandColors.gray),
                  TextSpan(children: [
                    TextSpan(
                      text: '2',
                      style: TextStyle(color: BrandColors.orange),
                    ),
                    TextSpan(text: '/3'),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
