import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../data/enums/consultant_response_type.dart';
import '../data/enums/consultation_status.dart';
import '../data/enums/payment_method.dart';
import '../data/enums/perview_status.dart';
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

  String get search => _translate('search');

  String get mainMajor => _translate('main_major');

  String get subMajor => _translate('sub_major');

  String get consultationNumberTitle => _translate('consultation_number_title');

  String get consultationStatus => _translate('consultation_status');

  String get consultant => _translate('consultant');

  String get unreviewed => _translate('unreviewed');

  String get reviewed => _translate('reviewed');

  String get consultantResponse => _translate('consultant_response');

  String get appointments => _translate('appointments');

  String get dateChange => _translate('date_change');

  String get consultantAppointments => _translate('consultant_appointments');

  String get notIncludedAppointments => _translate('not_included_appointments');

  String get consultationPrice => _translate('consultation_price');

  String get paymentStatusSearch => _translate('payment_status_search');

  String get paid => _translate('paid');

  String get notPaid => _translate('not_paid');

  String get paymentEvaluation => _translate('payment_evaluation');

  String get evaluatedByUser => _translate('evaluated_by_user');

  String get evaluatedByConsultant => _translate('evaluated_by_consultant');

  String get paymentType => _translate('payment_type');

  String get specifiedByConsultant => _translate('specified_by_consultant');

  String get specificCeiling => _translate('specific_ceiling');

  String get searchResults => _translate('search_results');

  String get consultationDetails => _translate('consultation_details');

  String get scheduledWithDate => _translate('scheduled_with_date');

  String get responseTime => _translate('response_time');

  String get responseAfterChangeTime =>
      _translate('response_after_change_time');

  String get requestChangeTimeTo => _translate('request_change_time_to');

  String get acceptDateChange => _translate('accept_date_change');

  String get edit => _translate('edit');

  String get changeTime => _translate('change_time');

  String get currentTime => _translate('current_time');

  String get decline => _translate('decline');

  String get cancelConsultation => _translate('cancel_consultation');

  String get editConsultation => _translate('edit_consultation');

  String get requestChangeConsultationContent =>
      _translate('request_change_consultation_content');

  String get editResponseType => _translate('edit_response_type');

  String get responseTypeChoiceTitle =>
      _translate('response_type_choice_title');

  String get textSubtitle => _translate('text_subtitle');

  String get onlineMeetingSubtitle => _translate('online_meeting_subtitle');

  String get availableTimes => _translate('available_times');

  String get addToCalendar => _translate('add_to_calendar');

  String get editConsultationTime => _translate('edit_consultation_time');

  String get noConsultant => _translate('no_consultant');

  String get availableTimesEmpty => _translate('available_times_empty');

  String get orderUnlistedAppointment =>
      _translate('order_unlisted_appointment');

  String get dateEditedTitle => _translate('date_edited_title');

  String get backToConsultation => _translate('back_to_consultation');

  String get goToChat => _translate('go_to_chat');

  String get markAllRead => _translate('mark_all_read');

  String get markAllUnread => _translate('mark_all_unread');

  String get payments => _translate('payments');

  String get consultationPayments => _translate('consultation_payments');

  String get walletBalance => _translate('wallet_balance');

  String get refundRequest => _translate('refund_request');

  String get addCredit => _translate('add_credit');

  String get transferCredit => _translate('transfer_credit');

  String get totalPayments => _translate('total_payments');

  String get cancelled => _translate('cancelled');

  String get refunded => _translate('refunded');

  String get completed => _translate('completed');

  String get hold => _translate('hold');

  String get transferDate => _translate('transfer_date');

  String get invoiceNumber => _translate('invoice_number');

  String get paymentMethod => _translate('payment_method');

  String get refund => _translate('refund');

  String get transferReceipt => _translate('transfer_receipt');

  String get invoicesEmpty => _translate('invoices_empty');

  String get price => _translate('price');

  String get sortBy => _translate('sort_by');

  String get descendingOrder => _translate('descending_order');

  String get ascendingOrder => _translate('ascending_order');

  String get dataCompletion => _translate('data_completion');

  String get latestConsultations => _translate('latest_consultations');

  String get viewAll => _translate('view_all');

  String get allConsultations => _translate('all_consultations');

  String get underReviewConsultations =>
      _translate('under_review_consultations');

  String get scheduledConsultations => _translate('scheduled_consultations');

  String get upcomingConsultations => _translate('upcoming_consultations');

  String get pendingPaymentConsultations =>
      _translate('pending_payment_consultations');

  String get requiredAmountConsultations =>
      _translate('required_amount_consultations');

  String get pendingConsultations => _translate('pending_consultations');

  String get chooseMajor => _translate('choose_major');

  String get sendAllConsultants => _translate('send_all_consultants');

  String get consultantAppropriateResponse =>
      _translate('consultant_appropriate_response');

  String get requestAssistance => _translate('request_assistance');

  String get requestAssistanceFees => _translate('request_assistance_fees');

  String get sendConsultationDuration =>
      _translate('send_consultation_duration');

  String get chooseConsultantSubtitle =>
      _translate('choose_consultant_subtitle');

  String get autoAcceptPrice => _translate('auto_accept_price');

  String get autoAcceptPriceSubtitle =>
      _translate('auto_accept_price_subtitle');

  String get consultationSchedule => _translate('consultation_schedule');

  String get chooseMethod => _translate('choose_method');

  String get setPriceCeiling => _translate('set_price_ceiling');

  String get consultantSetPrice => _translate('consultant_set_price');

  String get saveAsDraft => _translate('save_as_draft');

  String get agreeOn => _translate('agree_on');

  String get consultationsTerms => _translate('consultations_terms');

  String get royakeTerms => _translate('royake_terms');

  String get toSendConsultations => _translate('to_send_consultations');

  String get minimumTwoDollars => _translate('minimum_two_dollars');

  String get maximumReceiveTime => _translate('maximum_receive_time');

  String get hour => _translate('hour');

  String get chatsEmpty => _translate('chats_empty');

  String get logout => _translate('logout');

  String get qualifications => _translate('qualifications');

  String get experiences => _translate('experiences');

  String get courses => _translate('courses');

  String get skills => _translate('skills');

  String get projects => _translate('projects');

  String get researches => _translate('researches');

  String get patents => _translate('patents');

  String get volunteering => _translate('volunteering');

  String get certificates => _translate('certificates');

  String get languages => _translate('languages');

  String get activities => _translate('activities');

  String get active => _translate('active');

  String get data => _translate('data');

  String get settings => _translate('settings');

  String get saveChanges => _translate('save_changes');

  String get profileImageFormat => _translate('profile_image_format');

  String get firstName => _translate('first_name');

  String get middleName => _translate('middle_name');

  String get lastName => _translate('last_name');

  String get previewName => _translate('preview_name');

  String get previewNameDescription => _translate('preview_name_description');

  String get male => _translate('male');

  String get female => _translate('female');

  String get gender => _translate('gender');

  String get previewStatus => _translate('preview_status');

  String get save => _translate('save');

  String get profileUpdateValidation => _translate('profile_update_validation');

  String get previewNameValidation => _translate('preview_name_validation');

  String get language => _translate('language');

  String get timezone => _translate('timezone');

  String get currency => _translate('currency');

  String get twoFactorTitle => _translate('two_factor_title');

  String get twoFactorSubtitle => _translate('two_factor_subtitle');

  String get emailSubtitle => _translate('email_subtitle');

  String get smsTitle1 => _translate('sms_title_1');

  String get smsTitle2 => _translate('sms_title_2');

  String get smsSubtitle => _translate('sms_subtitle');

  String get completePayment => _translate('complete_payment');

  String get appTitle => _translate('app_title');

  String get appSubtitle => _translate('app_subtitle');

  String get whatsappSubtitle => _translate('whatsapp_subtitle');

  String get activate => _translate('activate');

  String get consultationReply => _translate('consultation_reply');

  String get appointmentAccept => _translate('appointment_accept');

  String get changeRequest => _translate('change_request');

  String get appointmentReject => _translate('appointment_reject');

  String get receivePendingPayment => _translate('receive_pending_payment');

  String get consultantMessage => _translate('consultant_message');

  String get receiveScheduledConsultation =>
      _translate('receive_scheduled_consultation');

  String get customerSupport => _translate('customer_support');

  String get refundCredit => _translate('refund_credit');

  String get advancedSettings => _translate('advanced_settings');

  String get expiredConsultation => _translate('expired_consultation');

  String get successfulPayment => _translate('successful_payment');

  String get twoFactorAuth => _translate('two_factor_auth');

  String get priceOffer => _translate('price_offer');

  String get successMessage => _translate('success_message');

  String getPreviewStatus(PreviewStatus status) {
    if (status == PreviewStatus.busy) {
      return _translate('busy');
    }
    if (status == PreviewStatus.visible) {
      return _translate('visible');
    }
    return _translate('hidden');
  }

  String getLevel(int level) {
    if (level == 1) {
      return _translate('beginner');
    }
    if (level == 2) {
      return _translate('intermediate');
    }
    return _translate('professional');
  }

  String getPaymentMethod(PaymentMethod paymentMethod) {
    if (paymentMethod == PaymentMethod.wallet) {
      return _translate('bank_transfer');
    }
    if (paymentMethod == PaymentMethod.visa) {
      return 'Visa';
    }
    return 'MasterCard';
  }

  String getConsultationResponseTypeSubtitle(ConsultantResponseType type) {
    if (type == ConsultantResponseType.text) {
      return _translate('text_subtitle');
    }
    if (type == ConsultantResponseType.voice) {
      return _translate('voice_subtitle');
    }
    if (type == ConsultantResponseType.video) {
      return _translate('video_subtitle');
    }
    if (type == ConsultantResponseType.onlineMeeting) {
      return _translate('connect_now_subtitle');
    }
    if (type == ConsultantResponseType.appropriateForConsultant) {
      return _translate('appropriate_for_consultant_subtitle');
    }
    if (type == ConsultantResponseType.fieldConsultation) {
      return _translate('field_consultation_subtitle');
    }
    if (type == ConsultantResponseType.appCall) {
      return _translate('app_call');
    }
    return _translate('frequent_consultation_subtitle');
  }

  String getConsultantResponseType(ConsultantResponseType type) {
    if (type == ConsultantResponseType.text) {
      return _translate('text');
    }
    if (type == ConsultantResponseType.voice) {
      return _translate('voice');
    }
    if (type == ConsultantResponseType.video) {
      return _translate('video');
    }
    if (type == ConsultantResponseType.onlineMeeting) {
      return _translate('online_meeting');
    }
    if (type == ConsultantResponseType.appropriateForConsultant) {
      return _translate('appropriate_for_consultant');
    }
    if (type == ConsultantResponseType.fieldConsultation) {
      return _translate('field_consultation');
    }
    if (type == ConsultantResponseType.appCall) {
      return _translate('app_call');
    }
    return _translate('frequent_consultation');
  }

  String getConsultationStatus(ConsultationStatus status, bool isHidden) {
    if (isHidden) {
      return _translate('hidden');
    }
    if (status == ConsultationStatus.draft) {
      return _translate('draft');
    }
    if (status == ConsultationStatus.pending) {
      return _translate('pending');
    }
    if (status == ConsultationStatus.scehduled) {
      return _translate('scheduled');
    }
    if (status == ConsultationStatus.requestToChangetime) {
      return _translate('request_to_change_time');
    }
    if (status == ConsultationStatus.approvedByConsultant ||
        status == ConsultationStatus.confirmedByUser) {
      return _translate('approved');
    }
    if (status == ConsultationStatus.pendingPayment) {
      return _translate('pending_payment');
    }
    if (status == ConsultationStatus.underReview) {
      return _translate('under_review');
    }
    if (status == ConsultationStatus.answeredByConsultant) {
      return _translate('answered');
    }
    if (status == ConsultationStatus.ended) {
      return _translate('ended');
    }
    return _translate('canelled');
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
