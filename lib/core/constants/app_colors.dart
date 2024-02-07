import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColorsController {
  AppColorsController();

  final Rx<Color?> _primaryColor = const Color(0xDDD42B1E).obs;
  final String _primaryColorStr = "#EE3E43";

  Color get primaryColor => _primaryColor.value ?? defaultPrimaryColor;

  String get primaryColorStr => _primaryColorStr;

  final defaultPrimaryColor = Colors.green;
  Color black = Colors.black;
  Color bottomSheetShadow = const Color(0xFF000019);
  Color greyTextColor = const Color(0xFF505050);

  // Color postCountColor = const Color(0xFF484747);

  // Color get deactivatedTextColor => greyTextColor.withOpacity(0.6);
  // Color titleTextColor = const Color(0xFF6D6D6D);
  Color hintTextColor = const Color(0x6666668D);
  Color greyLightTextColor = const Color(0xFFA6A6A6);
  Color navyBlue = const Color(0xAA033B44);
  Color scaffoldBGColor = Colors.white;

  // Color greyMessageBg = const Color(0xFFE9EAEE);
  // Color grey5 = const Color(0xFFC9C9C9);
  // Color placeholderBG = const Color(0xFFF5F5F5);
  // Color lightBlue = const Color(0xff56D8F3);
  // Color blue = const Color(0xff11A8F3);
  Color linkBlue = const Color(0xff2072FF);

  // Color favoriteColor = Colors.yellow;
  // Color green = const Color(0xFF4CAF50);
  // Color checkInButtonColor = const Color(0xFF098D00);
  // Color checkOutButtonColor = const Color(0xFFEE3E43);
  // Color dropDownColor = const Color(0xFF444444);
  // Color greyIconColor = const Color(0xFFC9C9C9);
  // Color taskBG = const Color(0xFFFFEEEE);
  //Color brownGrayColor = const Color(0xDD707070);
  Color borderTextFieldColor = Colors.grey.withOpacity(0.3);
  Color borderButtonColor = Colors.grey.withOpacity(0.5);

  // Color yellow = const Color(0xFFEEBF3F);
  // Color grey = const Color(0xFFF3F3F3);
  //
  Color textButtonBackground = const Color(0x00000000);

  // Color metroBackgroundPageColor = const Color(0xFF471214);
  Color priorityColor = const Color(0xFF8DCA26);

  // Color red = const Color(0xFFF44336);
  // Color orange = const Color(0xFFFF6600);
  // Color greyIconDarkColor = const Color(0xFF707070);
  Color darkGreyTextColor = const Color(0xFF484747);

  // Color greyBackground = const Color(0xFFF2F2F2);
  Color notSelectedGrey = const Color(0xFF7A8FA6);
  Color white = Colors.white;
// Color lightGreyBackground = const Color(0xffF2F2F2);

// Color emptyIconColor = const Color(0xffFFE1E1);
// Color previewLinkBG = const Color(0xfff7f7f8);
// Color dividerColor = const Color(0xff606060);
// Color sliderColor = const Color(0xFF000029);

// static const lightGrey = const Color(0xFFFFFFFF);
// static const darkGrey = const Color(0xFFFFFFFF);
}
