import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension NumbersExtension on num {
  Size _getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double toWidth(BuildContext context) {
    final screenSize = _getScreenSize(context);
    return screenSize.width * toDouble() / 428;
  }

  double toHeight(BuildContext context) {
    final screenSize = _getScreenSize(context);
    return screenSize.height * toDouble() / 926;
  }

  SizedBox toEmptyWidth(BuildContext context) =>
      SizedBox(width: toWidth(context));

  SizedBox toEmptyHeight(BuildContext context) =>
      SizedBox(height: toHeight(context));
}

extension StringExtension on String {
  get toSVG => SvgPicture.asset('assets/svgs/$this.svg');

  get toPNG => Image.asset('assets/images/$this.png');

  get toLottie => Image.asset('assets/lottie/$this.json');

  void showSnackbar(BuildContext context, {Color? color}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(this), backgroundColor: color),
      );
}
