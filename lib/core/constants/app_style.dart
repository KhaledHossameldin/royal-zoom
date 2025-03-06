import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_font.dart';
import '../../../core/constants/dimens.dart';
import '../../../core/di/di_manager.dart';
import '../../../core/utils/localization/app_localizations.dart';
import '../../../core/utils/screen_utils/device_utils.dart';

class AppStyle {
  static BoxDecoration formFieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(Dimens.bigBorderRadius),
    boxShadow: [
      BoxShadow(
        spreadRadius: 1,
        blurRadius: 7,
        color: Colors.grey.shade300.withOpacity(0.9),
        offset: const Offset(0.0, 2.5),
      )
    ],
  );

  static BoxShadow get iconShadow => BoxShadow(
      offset: const Offset(0, 2.0),
      color: DIManager.findCC().primaryColor.withOpacity(0.2),
      spreadRadius: 1.0,
      blurRadius: 3.0);

  static BoxShadow coloredShadow(Color color) => BoxShadow(
      offset: const Offset(0, 1),
      color: color,
      spreadRadius: 1.0,
      blurRadius: 1.0);

  static BoxShadow get normalShadow => BoxShadow(
      color: Colors.grey.shade300,
      blurRadius: 4,
      spreadRadius: 1.0,
      offset: const Offset(0, 1));

  static BoxShadow get bottomSheetShadow => BoxShadow(
        color: const Color(0xFF000029).withOpacity(0.15),
        blurRadius: 6,
        spreadRadius: 0,
        offset: const Offset(0, -5),
      );

  static BoxShadow get mediumShadow => BoxShadow(
      color: Colors.grey.shade400,
      blurRadius: 4,
      spreadRadius: 1.0,
      offset: const Offset(0, 1));

  static BoxShadow get normalIconShadow => BoxShadow(
        color: Colors.grey.shade300,
        offset: const Offset(0, 0),
        spreadRadius: 1.5,
        blurRadius: 6.0,
      );

  static InputDecoration inputDecoration(
      {String? hintText,
      String? labelText,
      FocusNode? focusNode,
      Widget? suffixIcon,
      bool? obscuring,
      Color? labelColor,
      Function? onObscurePressed}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 17.w),
      hintStyle: TextStyle(
          fontSize: AppFontSize.fontSize_14,
          color: labelColor ?? DIManager.findCC().hintTextColor),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
          color: focusNode?.hasFocus == true
              ? DIManager.findCC().black
              : DIManager.findCC().greyTextColor),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: obscuring != null
          ? IconButton(
              icon: Icon(
                obscuring ? Icons.visibility : Icons.visibility_off,
                size: Dimens.iconSize,
                color: DIManager.findCC().greyLightTextColor,
              ),
              onPressed: () {
                onObscurePressed!();
              })
          : suffixIcon,
      // border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(Dimens.bigBorderRadius)),
      focusColor: DIManager.findCC().borderTextFieldColor,
      focusedBorder: OutlineInputBorder(
        //borderRadius: BorderRadius.circular(Dimens.bigBorderRadius),
        borderSide: BorderSide(
            color: DIManager.findCC().borderTextFieldColor, width: 1.w),
      ),
      enabledBorder: OutlineInputBorder(
        //borderRadius: BorderRadius.circular(Dimens.bigBorderRadius),
        borderSide: BorderSide(
            width: 1.w, color: DIManager.findCC().borderTextFieldColor),
      ),
      disabledBorder: OutlineInputBorder(
        //  borderRadius: BorderRadius.circular(Dimens.bigBorderRadius),
        borderSide: BorderSide(
            width: 1.w, color: DIManager.findCC().borderTextFieldColor),
      ),
    );
  }

  static InputDecoration inputDecorationSearch({
    String? hintText,
    TextStyle? hintStyle,
    required FocusNode searchFocusNode,
  }) =>
      InputDecoration(
        hintStyle:
            hintStyle ?? TextStyle(color: DIManager.findCC().greyTextColor),
        hintText: hintText ?? translate('search_here'),
        //labelText: labelText,
        focusColor: DIManager.findCC().primaryColor,
        hoverColor: DIManager.findCC().primaryColor,
        labelStyle: TextStyle(
            color: searchFocusNode.hasFocus == true
                ? DIManager.findCC().primaryColor
                : DIManager.findCC().greyTextColor),
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.white,
        // contentPadding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
        focusedBorder: InputBorder.none,
        border: InputBorder.none,

        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        //   borderSide: BorderSide(color: Colors.grey),
        // ),
      );

  static InputDecoration inputDecorationOutlined({
    String? hintText,
    String? labelText,
    FocusNode? focusNode,
    Widget? suffixIcon,
    Color? borderColor,
    Color? labelColor,
    double opacity = 1.0,
    double borderSideWidth = 1,
  }) {
    return InputDecoration(
      hintStyle: TextStyle(
        color: labelColor ?? DIManager.findCC().hintTextColor,
        fontWeight: AppFontWeight.bold,
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: focusNode?.hasFocus == true
            ? DIManager.findCC().primaryColor
            : labelColor ??
                DIManager.findCC().hintTextColor.withOpacity(opacity),
        fontWeight: AppFontWeight.bold,
      ),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          width: borderSideWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: borderColor != null
              ? borderColor.withOpacity(opacity)
              : Colors.grey.withOpacity(opacity),
          width: borderSideWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: DIManager.findCC().primaryColor,
          width: borderSideWidth,
        ),
      ),
    );
  }

  static InputDecoration inputDecorationWithOulLine({
    String? hintText,
    String? labelText,
    FocusNode? focusNode,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintStyle: TextStyle(color: DIManager.findCC().greyTextColor),
      hintText: labelText,
      //labelText: labelText,
      focusColor: DIManager.findCC().primaryColor,
      hoverColor: DIManager.findCC().primaryColor,
      labelStyle: TextStyle(
          color: focusNode?.hasFocus == true
              ? DIManager.findCC().primaryColor
              : DIManager.findCC().greyTextColor),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: DIManager.findCC().primaryColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: DIManager.findCC().primaryColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }

  AppStyle._();

  static String? fontFamily;

  static TextStyle errorMessageStyle = TextStyle(
    fontSize: AppFontSize.fontSize_12,
    color: DIManager.findCC().darkGreyTextColor,
    height: 2.0,
  );

  static TextStyle get smallTitleTextStyle => TextStyle(
        fontSize: AppFontSize.fontSize_13,
        color: DIManager.findCC().darkGreyTextColor,
      );

  // 10
  static TextStyle lightSubtitle = TextStyle(
    fontSize: AppFontSize.fontSize_10,
    fontWeight: AppFontWeight.light,
    color: DIManager.findCC().greyTextColor,
  );

  // 12
  static TextStyle get defaultStyle => TextStyle(
        fontSize: AppFontSize.fontSize_12,
        color: DIManager.findCC().darkGreyTextColor,
        // height: AppFont.fontHeight,
      );

  // 16
  static TextStyle titleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_16,
    color: DIManager.findCC().darkGreyTextColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    // height: AppFont.fontHeight,
  );

  // 18
  static TextStyle bigTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_18,
    color: DIManager.findCC().darkGreyTextColor,
  );

  // 14
  static TextStyle smallTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_14,
    color: DIManager.findCC().darkGreyTextColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle tabBarLabelStyle = TextStyle(
    fontSize: ScreenHelper.scaleText(51),
    color: DIManager.findCC().primaryColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle tabBarUnselectedLabelStyle = TextStyle(
    fontSize: AppFontSize.fontSize_14,
    color: DIManager.findCC().greyTextColor,
  );

  static TextStyle appbarStyle = TextStyle(
    fontSize: AppFontSize.fontSize_18,
    color: DIManager.findCC().black,
    fontWeight: FontWeight.bold,
  );

  static double get appbarElevation => 4.0;
}
