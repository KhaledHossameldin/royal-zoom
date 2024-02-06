import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../core/di/di_manager.dart';

class MediaPlaceholderWidget extends StatelessWidget {
  const MediaPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DIManager.findCC().primaryColor.withOpacity(0.08),
      child: Image.asset(
        AppAssets.media_placeholder,
      ),
    );
  }
}
