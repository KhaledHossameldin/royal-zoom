import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import '../constants/brand_colors.dart';
import '../constants/fonts.dart';
import '../data/enums/consultation_status.dart';

extension TimeOfDayFormat on TimeOfDay {
  String toMap() {
    return '$hour:$minute:00';
  }
}

extension BooleanExtension on bool {
  int get toInt => this ? 1 : 0;
}

extension DurationExtension on Duration {
  String get timezoneOffset {
    return 'UTC ${inHours < 0 ? '-' : '+'}${inHours.abs().twoDigits}:${inMinutes.remainder(60).twoDigits}';
  }

  String get audioTime {
    return '${inMinutes.remainder(60).twoDigits}:${inSeconds.remainder(60).twoDigits}';
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

  String get seconds => '${(this ~/ 60).twoDigits}:${(this % 60).twoDigits}';
}

extension NumbersExtension on num {
  Size get _screenSize =>
      MediaQueryData.fromView(PlatformDispatcher.instance.views.first).size;

  double get width => _screenSize.width * toDouble() / 428;

  double get height => _screenSize.height * toDouble() / 926;

  SizedBox get emptyWidth => SizedBox(width: width);

  SizedBox get emptyHeight => SizedBox(height: height);
  double get screenWidth => _screenSize.width;
  double get screenHeight => _screenSize.height;
  double fromHeight(double percent) => _screenSize.height * percent / 100.0;
  double fromWidth(double percent) => _screenSize.height * percent / 100.0;
}

extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension StringExtension on String {
  DateTime get date {
    final date = split('-');
    return DateTime(int.parse(date[0]), int.parse(date[1]), int.parse(date[2]));
  }

  TimeOfDay get time {
    final times = split(':');
    return TimeOfDay(hour: int.parse(times[0]), minute: int.parse(times[1]));
  }

  SvgPicture get svg => SvgPicture.asset('assets/svgs/$this.svg');

  Image get png => Image.asset('assets/images/$this.png');

  VideoPlayerController get video =>
      VideoPlayerController.asset('assets/videos/$this.mp4');

  LottieBuilder get lottie => Lottie.asset('assets/lottie/$this.json');

  LottieBuilder get lottieOneTime => Lottie.asset(
        'assets/lottie/$this.json',
        repeat: false,
      );

  Image get permissionImage =>
      Image.asset('assets/images/permissions/$this.png');

  ImageIcon get imageIcon =>
      ImageIcon(AssetImage('assets/images/$this.png'), size: 20.0);

  Color get color => Color(int.parse('0xFF${substring(1)}'));

  Duration get timezoneOffset {
    if (endsWith('UTC')) {
      return const Duration();
    }
    final timezone = substring(length - 6);
    final time = timezone.split(':');
    return Duration(hours: int.parse(time[0]), minutes: int.parse(time[1]));
  }

  SvgPicture buildSVG({
    required Color color,
    BlendMode blendMode = BlendMode.modulate,
  }) =>
      SvgPicture.asset(
        'assets/svgs/$this.svg',
        colorFilter: ColorFilter.mode(color, blendMode),
      );

  ImageIcon buidImageIcon({
    double size = 20.0,
    Color color = Colors.black,
  }) =>
      ImageIcon(
        size: size,
        color: color,
        AssetImage('assets/images/$this.png'),
      );

  BottomNavigationBarItem buildBottomAppBarIcon(String label) =>
      BottomNavigationBarItem(
          label: label,
          icon: ImageIcon(AssetImage(
            'assets/images/bottom_app_bar_icons/$this.png',
          )),
          activeIcon: ImageIcon(AssetImage(
            'assets/images/bottom_app_bar_icons/${this}_active.png',
          )));

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
              fontFamily: Fonts.main,
            ),
          ),
        ),
      );
}

extension ColorExtension on Color {
  String get hex =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

extension DateTimeRangeExtension on DateTimeRange {
  String get text {
    final format = DateFormat('yyyy-MM-dd', 'en');
    return '${format.format(start)} - ${format.format(end)}';
  }
}

extension ConsultationStatusExtension on ConsultationStatus {
  Color get color {
    if (this == ConsultationStatus.draft) {
      return BrandColors.black;
    }
    if (this == ConsultationStatus.pending) {
      return const Color(0xFF2E59BC);
    }
    if (this == ConsultationStatus.scehduled) {
      return const Color(0xFF9A9A9A);
    }
    if (this == ConsultationStatus.requestToChangetime) {
      return const Color(0xFFE93BE3);
    }
    if (this == ConsultationStatus.approvedByConsultant ||
        this == ConsultationStatus.confirmedByUser) {
      return Colors.green;
    }
    if (this == ConsultationStatus.pendingPayment) {
      return BrandColors.orange;
    }
    if (this == ConsultationStatus.underReview) {
      return Colors.brown;
    }
    if (this == ConsultationStatus.answeredByConsultant) {
      return Colors.lime;
    }
    if (this == ConsultationStatus.ended) {
      return const Color(0xFF6E7CAC);
    }
    return Colors.red;
  }
}

extension ConvertDurationToMMSS on Duration {
  String toMMSS() {
    int minsInt = ((inMilliseconds ~/ 1000) ~/ 60);
    int secsInt = ((inMilliseconds ~/ 1000));
    String mins = minsInt < 10 ? '0$minsInt' : minsInt.toString();
    String secs = secsInt < 10 ? '0$secsInt' : secsInt.toString();
    return '$mins:$secs';
  }
}
