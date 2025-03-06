import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/ui/widgets/images/placeholers/media_placeholder_widget.dart';
import 'placeholers/general_image_placeholder.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final Widget? placeholder;

  final double? height;
  final double? width;

  const CachedImage(
      {super.key,
      required this.imageUrl,
      this.fit,
      this.placeholder,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      errorWidget: (BuildContext context, _, __) {
        return placeholder ?? const ImageError();
      },
      placeholder: (BuildContext context, _) {
        return placeholder ?? const MediaPlaceholderWidget();
      },
    );
  }
}
