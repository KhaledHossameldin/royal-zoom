import 'package:flutter/material.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(context, (route) => route.isFirst);
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            'reset_password'.toLottie((composition) => _controller
              ..duration = composition.duration
              ..forward()),
            11.emptyHeight,
            Text(
              appLocalizations.resetSuccessTitle,
              style: textTheme.bodyLarge,
            ),
            12.emptyHeight,
            Text(
              appLocalizations.resetSuccessSubtitle,
              style: textTheme.bodyLarge!.copyWith(
                color: BrandColors.darkGray,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
