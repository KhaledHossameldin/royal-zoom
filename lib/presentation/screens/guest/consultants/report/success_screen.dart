import 'package:flutter/material.dart';

import '../../../../../constants/brand_colors.dart';
import '../../../../../localization/app_localizations.dart';
import '../../../../../utilities/extensions.dart';

class ReportConsultantSuccessScreen extends StatefulWidget {
  const ReportConsultantSuccessScreen({super.key});

  @override
  State<ReportConsultantSuccessScreen> createState() =>
      _ReportConsultantSuccessScreenState();
}

class _ReportConsultantSuccessScreenState
    extends State<ReportConsultantSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              'report'.toLottie((composition) => _controller
                ..duration = composition.duration
                ..forward()),
              12.emptyHeight,
              Text(
                appLocalizations.reportSent,
                style: textTheme.bodyLarge!.copyWith(
                  color: BrandColors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
