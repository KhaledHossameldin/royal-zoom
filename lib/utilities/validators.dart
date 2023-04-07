import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/enums/email_phone.dart';
import '../localization/app_localizations.dart';

class Validators {
  Validators._();

  static String? email(BuildContext context, {required String email}) {
    final appLocalizations = AppLocalizations.of(context);
    if (email.isEmpty) {
      return appLocalizations.emailEmptyValidation;
    }
    final isValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    if (!isValid) {
      return appLocalizations.emailFormatValidation;
    }
    return null;
  }

  static String? password(BuildContext context, {required String password}) {
    if (kDebugMode) {
      return null;
    }
    final appLocalizations = AppLocalizations.of(context);
    if (password.isEmpty) {
      return appLocalizations.passwordEmptyValidation;
    }
    final containsLowerCase = RegExp('.*[a-z].*').hasMatch(password);
    final containsUpperCase = RegExp('.*[A-Z].*').hasMatch(password);
    if (!containsUpperCase || !containsLowerCase || password.length < 8) {
      return appLocalizations.passwordInvalidValidation;
    }
    return null;
  }

  static String? phone(
    BuildContext context, {
    required String phone,
    required int length,
  }) {
    final appLocalizations = AppLocalizations.of(context);
    if (phone.isEmpty) {
      return appLocalizations.phoneEmptyValidation;
    }
    if (phone.length < length) {
      return appLocalizations.phoneInvalidValidation;
    }
    return null;
  }

  static String? phoneEmail(
    BuildContext context, {
    required EmailPhone emailPhone,
    required String username,
    required int length,
  }) {
    final appLocalizations = AppLocalizations.of(context);
    if (emailPhone == EmailPhone.none) {
      return appLocalizations.emailPhoneEmptyValidation;
    } else if (emailPhone == EmailPhone.email) {
      return email(context, email: username);
    } else if (emailPhone == EmailPhone.phone) {
      if (username.length < length) {
        return phone(context, phone: username, length: length);
      }
    }
    return null;
  }

  static String? termsAndPolicy(BuildContext context, bool isAccept) {
    final appLocalizations = AppLocalizations.of(context);
    if (!isAccept) {
      return appLocalizations.termsPrivacyValidation;
    }
    return null;
  }
}
