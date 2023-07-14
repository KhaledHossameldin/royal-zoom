import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../data/enums/consultation_status.dart';
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

  String get notifications => _translate('notifications');

  String get notificationsEmpty => _translate('notifications_empty');

  String get skipStep => _translate('skip_step');

  String get locationTitle => _translate('location_title');

  String get locationSubtitle => _translate('location_subtitle');

  String get permit => _translate('permit');

  String get continueAsGuest => _translate('continue_as_guest');

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

  String get consult => _translate('consult');

  String get consultations => _translate('consultations');

  String get chat => _translate('chat');

  String get chatEmpty => _translate('chat_empty');

  String get profile => _translate('profile');

  String get consultants => _translate('consultants');

  String get searchConsultants => _translate('search_consultants');

  String get consultantsEmpty => _translate('consultants_empty');

  String get consultantDetails => _translate('consultant_details');

  String get filter => _translate('filter');

  String get none => _translate('none');

  String get choose => _translate('choose');

  String get country => _translate('country');

  String get city => _translate('city');

  String get reviews => _translate('reviews');

  String get experienceYears => _translate('experience_years');

  String get report => _translate('report');

  String get reportSent => _translate('report_sent');

  String get share => _translate('share');

  String get like => _translate('like');

  String get abstract => _translate('abstract');

  String get biography => _translate('biography');

  String get publishedConsultations => _translate('published_consultations');

  String get main => _translate('main');

  String get guest => _translate('guest');

  String get aboutApplication => _translate('about_application');

  String get contactUs => _translate('contact_us');

  String get shareWithFriends => _translate('share_with_friends');

  String get royakeForConsultations => _translate('royake_for_consultations');

  String get saudiArabia => _translate('saudi_arabia');

  String get howWorkClientsTitle => _translate('how_work_clients_title');

  String get howWorkClientsSubtitle => _translate('how_work_clients_subtitle');

  String get problemsSolved => _translate('problems_solved');

  String get consultantsHelp => _translate('consultants_help');

  String get sendCounsultationTitle => _translate('send_counsultation_title');

  String get sendCounsultationSubtitle =>
      _translate('send_counsultation_subtitle');

  String get receiveReplyTitle => _translate('receive_reply_title');

  String get receiveReplySubtitle => _translate('receive_reply_subtitle');

  String get valueConsultationTitle => _translate('value_consultation_title');

  String get valueConsultationSubtitle =>
      _translate('value_consultation_subtitle');

  String get ourCoreValue => _translate('our_core_value');

  String get valuesShape => _translate('values_shape');

  String get integrityTitle => _translate('integrity_title');

  String get integritySubtitle => _translate('integrity_subtitle');

  String get cooperationTitle => _translate('cooperation_title');

  String get cooperationSubtitle => _translate('cooperation_subtitle');

  String get integrationTitle => _translate('integration_title');

  String get integrationSubtitle => _translate('integration_subtitle');

  String get trustTitle => _translate('trust_title');

  String get trustSubtitle => _translate('trust_subtitle');

  String get ourTeam => _translate('our_team');

  String get teamExperienceTitle => _translate('team_experience_title');

  String get teamExperienceSubtitle => _translate('team_experience_subtitle');

  String get reportAbuse => '$report ${_translate('abuse')}';

  String get reportViolation => '$report ${_translate('violation')}';

  String get reportThisAccount => '$report ${_translate('this_account')}';

  String get whatsappNotInstalled => _translate('whatsapp_not_installed');

  String get yourName => _translate('your_name');

  String get fullName => _translate('full_name');

  String get fullNameValidation => _translate('full_name_validation');

  String get leaveMessage => _translate('leave_message');

  String get topic => _translate('topic');

  String get topicValidation => _translate('topic_validation');

  String get yourMessage => _translate('your_message');

  String get yourMessageValidation => _translate('your_message_validation');

  String get send => _translate('send');

  String get favorite => _translate('favorite');

  String get sarH => _translate('sar_h');

  String get review => _translate('review');

  String get consultantTimes => _translate('consultant_times');

  String get showPrices => _translate('show_prices');

  String get clearReviews => _translate('clear_reviews');

  String get reviewApplication => _translate('review_application');

  String get appReviewTitle => _translate('app_review_title');

  String get comment => _translate('comment');

  String get writeComment => _translate('write_comment');

  String get showName => _translate('show_name');

  String get chooseConsultationType => _translate('choose_consultation_type');

  String get normalConsultation => _translate('normal_consultation');

  String get customizedConsultation => _translate('customized_consultation');

  String get chooseConsultant => _translate('choose_consultant');

  String get hideFromConsultant => _translate('hide_from_consultant');

  String get next => _translate('next');

  String get cancel => _translate('cancel');

  String get consultationContent => _translate('consultation_content');

  String get chooseConsultationContent =>
      _translate('choose_consultation_content');

  String get consultation => _translate('consultation');

  String get enterConsultation => _translate('enter_consultation');

  String get attachedFiles => _translate('attached_files');

  String get previous => _translate('previous');

  String get searchEmpty => _translate('search_empty');

  String get textType => _translate('text_type');

  String get voiceType => _translate('voice_type');

  String get filesLimitTitle => _translate('files_limit_title');

  String get filesLimitSubtitle => _translate('files_limit_subtitle');

  String get filesLimitError => _translate('files_limit_error');

  String get filesSizeError => _translate('files_size_error');

  String get consultantAnswer => _translate('consultant_answer');

  String get answerPreference => _translate('answer_preference');

  String get connectNowTitle => _translate('connect_now_title');

  String get connectNowSubtitle => _translate('connect_now_subtitle');

  String get voiceTitle => _translate('voice_title');

  String get voiceSubtitle => _translate('voice_subtitle');

  String get videoTitle => _translate('video_title');

  String get videoSubtitle => _translate('video_subtitle');

  String get consultationPriceTitle => _translate('consultation_price_title');

  String get chooseConsultationTypeError =>
      _translate('choose_consultation_type_error');

  String get consultationPriceSubitle =>
      _translate('consultation_price_subtitle');

  String get consultationSentTitle => _translate('consultation_sent_title');

  String get consultationSentSubtitle =>
      _translate('consultation_sent_subtitle');

  String get consultationSentNotifications =>
      _translate('consultation_sent_notifications');

  String get consultationSentContact => _translate('consultation_sent_contact');

  String get payment => _translate('payment');

  String get skip => _translate('skip');

  String get viewVerifiedOnly => _translate('view_verified_only');

  String get pricePerHour => _translate('price_per_hour');

  String get from => _translate('from');

  String get to => _translate('to');

  String get sar => _translate('sar');

  String get viewResults => _translate('view_results');

  String get reset => _translate('reset');

  String get majorPricePerHour => _translate('major_price_per_hour');

  String get answerDuration => _translate('answer_duration');

  String get searchConsultations => _translate('search_consultations');

  String get consultationsEmpty => _translate('consultations_empty');

  String get consultationNumber => _translate('consultation_number');

  String get status => _translate('status');

  String get date => _translate('date');

  String getConsultationStatus(ConsultationStatus status, bool isHidden) {
    if (isHidden) {
      return _translate('hidden');
    }
    return _translate('scheduled');
  }

  String getConsultationPaymentStatus(num maximumPrice, bool isPaid) {
    String status = _translate('payment_status');
    if (maximumPrice <= 0) {
      return status + _translate('free');
    }
    if (isPaid) {
      return status + _translate('paid');
    }
    return status + _translate('not_paid');
  }

  String getStars(int count) => Intl.plural(
        count,
        zero: _translate('not_reviewed'),
        one: _translate('one_star'),
        two: _translate('two_stars'),
        other: '$count ${_translate('stars')}',
      );

  String getRate(int rate) {
    switch (rate) {
      case 1:
        return _translate('weak');

      case 2:
        return _translate('acceptable');

      case 3:
        return _translate('good');

      case 4:
        return _translate('very_good');

      default:
        return _translate('excellent');
    }
  }

  String getReview(int count) => Intl.plural(
        count,
        zero: _translate('zero_reviews'),
        one: _translate('one_review'),
        two: _translate('two_reviews'),
        other: '$count ${_translate('many_reviews')}',
      );

  String getMajor(bool isSingle) => Intl.plural(isSingle ? 1 : 5,
      one: _translate('major'), other: _translate('majors'));

  String getReload(String value) =>
      '${_translate('reload')} ${value.toLowerCase()}';

  String getOTPSubtitle(String username) =>
      '${_translate('code_sent')}\n$username';

  String getTimerText(int seconds) =>
      '${_translate('resend_otp_1')} $seconds ${_translate('resend_otp_2')}';

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
