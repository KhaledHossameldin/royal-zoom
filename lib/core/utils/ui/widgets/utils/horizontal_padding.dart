import 'package:flutter/material.dart';

import '../../../../../../core/utils/screen_utils/device_utils.dart';

class HorizontalPadding extends StatelessWidget {
  final double percentage;

  const HorizontalPadding(this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: ScreenHelper.fromWidth55(percentage));
  }
}
