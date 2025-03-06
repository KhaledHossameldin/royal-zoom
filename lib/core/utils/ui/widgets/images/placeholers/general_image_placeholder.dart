import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_assets.dart';

class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder({super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.general_placeholder_image,
      fit: BoxFit.cover,
    );
  }
}

class ImageError extends StatelessWidget {
  const ImageError({super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.general_error_image,
      fit: BoxFit.cover,
    );
  }
}
