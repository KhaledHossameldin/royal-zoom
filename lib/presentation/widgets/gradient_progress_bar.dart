import 'package:flutter/material.dart';

import '../../constants/brand_colors.dart';
import '../../utilities/extensions.dart';

class GradientProgressBar extends StatelessWidget {
  const GradientProgressBar({super.key, required this.progress});

  final int progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BrandColors.snowWhite,
        borderRadius: BorderRadius.circular(29.0),
      ),
      child: Row(
        children: [
          Flexible(
            flex: progress,
            fit: FlexFit.tight,
            child: Container(
              height: 10.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29.0),
                gradient: LinearGradient(colors: [
                  BrandColors.green.withOpacity(0.5),
                  BrandColors.darkGreen,
                ]),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 100 - progress,
            child: const Material(),
          ),
        ],
      ),
    );
  }
}
