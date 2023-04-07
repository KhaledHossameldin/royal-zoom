import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../constants/brand_colors.dart';

extension BooleanExtension on bool {
  int get toInt => this ? 1 : 0;
}

extension DurationExtension on Duration {
  String get timezoneOffset {
    return 'UTC ${inHours < 0 ? '-' : '+'}${inHours.abs().twoDigits}:${inMinutes.remainder(60).twoDigits}';
  }
}

extension IntegerExtension on int {
  String get threeDigit {
    if (this > 99) {
      return toString();
    } else if (this > 9) {
      return '0$this';
    } else {
      return '00$this';
    }
  }

  String get twoDigits {
    if (this > 9) {
      return '$this';
    } else {
      return '0$this';
    }
  }
}

extension NumbersExtension on num {
  Size get _screenSize =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;

  double get width => _screenSize.width * toDouble() / 428;

  double get height => _screenSize.height * toDouble() / 926;

  SizedBox get emptyWidth => SizedBox(width: width);

  SizedBox get emptyHeight => SizedBox(height: height);
}

extension StringExtension on String {
  SvgPicture get svg => SvgPicture.asset('assets/svgs/$this.svg');

  Image get png => Image.asset('assets/images/$this.png');

  Image get permissionImage =>
      Image.asset('assets/images/permissions/$this.png');

  Color get color => Color(int.parse('0xFF${substring(1)}'));

  Duration get timezoneOffset {
    final timezone = substring(length - 6);
    final time = timezone.split(':');
    return Duration(hours: int.parse(time[0]), minutes: int.parse(time[1]));
  }

  LottieBuilder toLottie(Function(LottieComposition) onLoaded) => Lottie.asset(
        'assets/lottie/$this.json',
        repeat: false,
        onLoaded: onLoaded,
      );

  void showSnackbar(BuildContext context, {Color color = BrandColors.orange}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: color,
            content: Text(
              this,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Droid Arabic Kufi',
              ),
            )),
      );
}

extension ColorExtension on Color {
  String get hex =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
