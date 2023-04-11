import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utilities/extensions.dart';
import 'app_localizations_delegate.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get royake => _translate('royake');

  String get emailEmptyValidation => _translate('email_empty_validation');

  String get emailFormatValidation => _translate('email_format_validation');

  String get phoneEmptyValidation => _translate('phone_empty_validation');

  String get phoneInvalidValidation => _translate('phone_invalid_validation');

  String get passwordEmptyValidation => _translate('password_empty_validation');

  String get passwordInvalidValidation =>
      _translate('password_invalid_validation');

  String get emailPhoneEmptyValidation =>
      _translate('email_phone_empty_validation');

  String get termsPrivacyValidation => _translate('terms_privacy_validation');

  String get notificationsTitle => _translate('notifications_title');

  String get notificationsSubtitle => _translate('notifications_subtitle');

  String get activateNotifications => _translate('activate_notifications');

  String get skipStep => _translate('skip_step');

  String get locationTitle => _translate('location_title');

  String get locationSubtitle => _translate('location_subtitle');

  String get permit => _translate('permit');

  String get skip => _translate('skip');

  String get loginToAccount => _translate('login_to_account');

  String get email => _translate('email');

  String get phone => _translate('phone');

  String get copyright => _translate('copyright');

  String get rememberMe => _translate('remember_me');

  String get resetPassword => _translate('reset_password');

  String get password => _translate('password');

  String get login => _translate('login');

  String get dontHaveAccount => _translate('dont_have_account');

  String get registerNowFree => _translate('register_now_free');

  String get noInternetConnection => _translate('no_internet_connection');

  String get httpError => _translate('http_error');

  String get invalidDataFormat => _translate('invalid_data_format');

  String get requestTimeout => _translate('request_timeout');

  String get unknownError => _translate('unknown_error');

  String get confirmPassword => _translate('confirm_password');

  String get resetPasswordDetailsTitle =>
      _translate('reset_password_details_title');

  String get restore => _translate('restore');

  String get otpTitle => _translate('otp_title');

  String get emailOrPhone => _translate('email_or_phone');

  String get didntReceiveCode => _translate('didnt_receive_code');

  String get confirm => _translate('confirm');

  String get enterNewPassword => _translate('enter_new_password');

  String get resetSuccessTitle => _translate('reset_success_title');

  String get resetSuccessSubtitle => _translate('reset_success_subtitle');

  String get resetTimerDone => _translate('reset_timer_done');

  String get registerTitle => _translate('register_title');

  String get register => _translate('register');

  String get acceptTerms => _translate('accept_terms');

  String get haveAccount => _translate('have_account');

  String get and => _translate('and');

  String get privacyPolicy => _translate('privacy_policy');

  String get termsOfUse => _translate('terms_of_use');

  String get registerSuccessTitle => _translate('register_success_title');

  String get termsOfUseTitle => _translate('terms_of_use_title');

  String get termsOfUseSubtitle => _translate('terms_of_use_subtitle');

  String get termsOfUseContent => _translate('terms_of_use_content');

  String get privacyPolicyTitle => _translate('privacy_policy_title');

  String get privacyPolicySubtitle => _translate('privacy_policy_subtitle');

  String get privacyPolicyContent => _translate('privacy_policy_content');

  String get notifications => _translate('notifications');

  String get sendConsultation => _translate('send_consultation');

  String get consultations => _translate('consultations');

  String get chat => _translate('chat');

  String get profile => _translate('profile');

  String get consultants => _translate('consultants');

  String get searchConsultants => _translate('search_consultants');

  String get consultantsEmpty => _translate('consultants_empty');

  String get consultantsReload => _translate('consultants_reload');

  String get filter => _translate('filter');

  String get none => _translate('none');

  String getOTPSubtitle(String username) {
    return '${_translate('code_sent')}\n$username';
  }

  String getTimerText(int seconds) {
    return '${_translate('resend_otp_1')} ${seconds.threeDigit} ${_translate('resend_otp_2')}';
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};

  Future<void> load() async {
    String jsonString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map<String, String>(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  String _translate(String key) =>
      _localizedStrings[key] ?? 'None existing key';

  bool get isEnLocale => locale.languageCode == 'en';
}
