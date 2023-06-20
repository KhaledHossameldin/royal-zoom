import 'package:flutter/material.dart';

class BrandColors {
  BrandColors._();

  static const orange = Color(0xFFF2A431);
  static const red = Color(0xFFFD6F3D);
  static const purple = Color(0xFFA096FF);
  static const snowWhite = Color(0xFFF8F8F8);
  static const mediumGreen = Color(0xFF5D6864);
  static const green = Color(0xFF5DBC2E);
  static const darkGreen = Color(0xFF1A4224);
  static const darkBlackGreen = Color(0xFF1A4224);
  static const lightBlue = Color(0xFF03BDDE);
  static const indigoBlue = Color(0xFF6E7CAC);
  static const darkBlue = Color(0xFF3F4765);
  static const gray = Color(0xFFBFBFBF);
  static const mediumGray = Color(0xFFAAAAAA);
  static const darkGray = Color(0xFF666666);
  static const black = Color(0xFF2C3F38);
  static const shadow = Color(0xFFFFFF01);

  static const blackTransparent = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Colors.black, Colors.transparent],
  );
}
