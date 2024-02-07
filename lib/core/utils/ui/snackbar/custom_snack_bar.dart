import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/di/di_manager.dart';
import '../../../../core/errors/base_error.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';

class CustomSnackbar {
  static const String routeName = 'CustomSnackbar/showSnackbar';

  static void showSnackbar(String message) {
    Get.snackbar('', '',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        borderRadius: ScreenHelper.fromWidth55(0.5),
        animationDuration: const Duration(seconds: 1),
        backgroundColor: DIManager.findCC().primaryColor.withOpacity(0.9),
        isDismissible: false,
        messageText: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenHelper.fromHeight55(1.0)),
                child: Text(
                  message,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        margin: const EdgeInsets.symmetric());
  }

  static showErrorSnackbar(BaseError error) {
    Get.snackbar(
      translate('error'),
      'message',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      animationDuration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
      isDismissible: false,
      titleText: Text(
        translate('error'),
        style:
            TextStyle(color: Colors.grey.shade300, fontWeight: FontWeight.bold),
      ),
      messageText: Row(
        children: [
          Expanded(
            child: Text(
              error.message ?? '',
              maxLines: 2,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(),
    );
  }
}
