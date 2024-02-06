import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/di/di_manager.dart';
import '../../../../../core/utils/ui/widgets/images/cached_image.dart';
import '../../../../../core/utils/ui/widgets/images/svg_image_asset.dart';

class CustomImage extends StatelessWidget {
  final double cornerRadius;
  final Color? color;
  final double? width;
  final double? height;
  final String? image;
  final Widget? placeHolder;
  final bool isNetworkImage;
  final Color? backgroundColor;
  final bool hasBorder;
  final bool isImageFile;
  final File? file;
  final Border? border;
  final BoxShadow? shadow;
  final BoxFit? boxFit;
  final EdgeInsets? padding;

  const CustomImage._({
    required this.cornerRadius,
    required this.image,
    this.backgroundColor,
    this.isImageFile = false,
    this.file,
    this.color,
    this.width,
    this.boxFit,
    this.height,
    this.placeHolder,
    this.isNetworkImage = true,
    this.shadow,
    this.hasBorder = false,
    this.border,
    this.padding,
  });

  factory CustomImage.circular({
    required double radius,
    required String? image,
    Widget? placeHolder,
    BoxShadow? shadow,
    BoxFit? boxFit,
    Color? backgroundColor,
    Color? color,
    EdgeInsets? padding,
    bool hasBorder = false,
    isNetworkImage = true,
    isImageFile = false,
    file,
    Border? border,
  }) =>
      CustomImage._(
        image: image,
        cornerRadius: radius,
        height: radius,
        width: radius,
        boxFit: boxFit,
        file: file,
        isImageFile: isImageFile,
        color: color,
        backgroundColor: backgroundColor,
        isNetworkImage: isNetworkImage,
        placeHolder: placeHolder,
        shadow: shadow,
        hasBorder: hasBorder,
        border: border,
        padding: padding,
      );

  factory CustomImage.rectangle({
    double cornerRadius = 0.0,
    required String? image,
    double? width,
    double? height,
    Widget? placeHolder,
    BoxShadow? shadow,
    BoxFit? boxFit,
    Color? backgroundColor,
    Color? color,
    isImageFile = false,
    file,
    bool hasBorder = false,
    isNetworkImage = true,
    EdgeInsets? padding,
  }) =>
      CustomImage._(
        image: image,
        cornerRadius: cornerRadius,
        height: height,
        width: width,
        boxFit: boxFit,
        color: color,
        backgroundColor: backgroundColor,
        isNetworkImage: isNetworkImage,
        placeHolder: placeHolder,
        shadow: shadow,
        file: file,
        isImageFile: isImageFile,
        padding: padding,
        hasBorder: hasBorder,
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width,
      height: height,
      decoration: BoxDecoration(
          boxShadow: shadow == null ? [] : [shadow!],
          border: !(hasBorder == true)
              ? Border.all(color: Colors.transparent, width: 0.0)
              : border ??
                  Border.all(
                      color: DIManager.findDep<AppColorsController>()
                          .primaryColor
                          .withOpacity(0.7),
                      width: 0.7),
          borderRadius: BorderRadius.circular(cornerRadius),
          color: backgroundColor),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cornerRadius),
          child: isImageFile ? _buildImageFile() : _buildNetworkOrAssetsImage(),
        ),
      ),
    );
  }

  _buildLocalImage() {
    bool isSvgPicture = image!.endsWith('svg');
    if (isSvgPicture) {
      return SvgImageAsset(
        image ?? '',
        fit: boxFit ?? BoxFit.cover,
        color: color,
      );
    }
    return Image.asset(
      image!,
      fit: boxFit ?? BoxFit.cover,
      color: color,
    );
  }

  _buildImageFile() {
    return Image.file(
      file!,
      fit: boxFit ?? BoxFit.cover,
      color: color,
    );
  }

  _buildNetworkImage() {
    return CachedImage(
      imageUrl: image ?? '',
      placeholder: placeHolder,
      width: width,
      height: height,
      fit: boxFit ?? BoxFit.cover,
    );
  }

  _buildNetworkOrAssetsImage() {
    final isNetwork =
        ((image?.isNotEmpty ?? false) && (image?.startsWith('http') ?? false) ||
            (image?.startsWith('https') ?? false));

    final isAssetImage = image?.startsWith('assets') ?? false;
    if (isNetwork) return _buildNetworkImage();
    if (isAssetImage) return _buildLocalImage();
    if (placeHolder != null) return placeHolder;
    return Container();
  }
}
