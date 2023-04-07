import 'dart:convert';

import '../../../utilities/extensions.dart';

class Settings {
  final bool? acceptNotificationsViaApp;
  final bool? acceptNotificationsViaSms;
  final bool? acceptNotificationsViaEmail;
  final bool? acceptNotificationsViaWhatsapp;
  final bool? automaticAcceptForLowestOffers;
  final bool? receiveNotificationOnPriceOffer;
  final bool? activateMultiFactorAuthentication;
  final bool? receiveNotificationOnRefundCredit;
  final bool? receiveNotificationForPendingPayment;
  final bool? receiveNotificationOnAppointmentAccept;
  final bool? receiveNotificationOnAppointmentReject;
  final bool? receiveNotificationOnConsultantMessage;
  final bool? receiveNotificationOnConsultantReply;
  final bool? receiveNotificationOnSuccessfulPayment;
  final bool? receiveNotificationOnTwoFactorAuthEnabled;
  final bool? receiveNotificationOnCustomerSupportMessage;
  final bool? receiveNotificationOnAppointmentChangeRequest;
  final bool? receiveNotificationOnExpiredConsultationAccept;
  final bool? receiveNotificationBeforePublishingScheduledConsultation;

  Settings({
    this.acceptNotificationsViaApp,
    this.acceptNotificationsViaSms,
    this.acceptNotificationsViaEmail,
    this.acceptNotificationsViaWhatsapp,
    this.automaticAcceptForLowestOffers,
    this.receiveNotificationOnPriceOffer,
    this.activateMultiFactorAuthentication,
    this.receiveNotificationOnRefundCredit,
    this.receiveNotificationForPendingPayment,
    this.receiveNotificationOnAppointmentAccept,
    this.receiveNotificationOnAppointmentReject,
    this.receiveNotificationOnConsultantMessage,
    this.receiveNotificationOnConsultantReply,
    this.receiveNotificationOnSuccessfulPayment,
    this.receiveNotificationOnTwoFactorAuthEnabled,
    this.receiveNotificationOnCustomerSupportMessage,
    this.receiveNotificationOnAppointmentChangeRequest,
    this.receiveNotificationOnExpiredConsultationAccept,
    this.receiveNotificationBeforePublishingScheduledConsultation,
  });

  Settings copyWith({
    bool? acceptNotificationsViaApp,
    bool? acceptNotificationsViaSms,
    bool? acceptNotificationsViaEmail,
    bool? acceptNotificationsViaWhatsapp,
    bool? automaticAcceptForLowestOffers,
    bool? receiveNotificationOnPriceOffer,
    bool? activateMultiFactorAuthentication,
    bool? receiveNotificationOnRefundCredit,
    bool? receiveNotificationForPendingPayment,
    bool? receiveNotificationOnAppointmentAccept,
    bool? receiveNotificationOnAppointmentReject,
    bool? receiveNotificationOnConsultantMessage,
    bool? receiveNotificationOnConsultantReply,
    bool? receiveNotificationOnSuccessfulPayment,
    bool? receiveNotificationOnTwoFactorAuthEnabled,
    bool? receiveNotificationOnCustomerSupportMessage,
    bool? receiveNotificationOnAppointmentChangeRequest,
    bool? receiveNotificationOnExpiredConsultationAccept,
    bool? receiveNotificationBeforePublishingScheduledConsultation,
  }) {
    return Settings(
      acceptNotificationsViaApp:
          acceptNotificationsViaApp ?? this.acceptNotificationsViaApp,
      acceptNotificationsViaSms:
          acceptNotificationsViaSms ?? this.acceptNotificationsViaSms,
      acceptNotificationsViaEmail:
          acceptNotificationsViaEmail ?? this.acceptNotificationsViaEmail,
      acceptNotificationsViaWhatsapp:
          acceptNotificationsViaWhatsapp ?? this.acceptNotificationsViaWhatsapp,
      automaticAcceptForLowestOffers:
          automaticAcceptForLowestOffers ?? this.automaticAcceptForLowestOffers,
      receiveNotificationOnPriceOffer: receiveNotificationOnPriceOffer ??
          this.receiveNotificationOnPriceOffer,
      activateMultiFactorAuthentication: activateMultiFactorAuthentication ??
          this.activateMultiFactorAuthentication,
      receiveNotificationOnRefundCredit: receiveNotificationOnRefundCredit ??
          this.receiveNotificationOnRefundCredit,
      receiveNotificationForPendingPayment:
          receiveNotificationForPendingPayment ??
              this.receiveNotificationForPendingPayment,
      receiveNotificationOnAppointmentAccept:
          receiveNotificationOnAppointmentAccept ??
              this.receiveNotificationOnAppointmentAccept,
      receiveNotificationOnAppointmentReject:
          receiveNotificationOnAppointmentReject ??
              this.receiveNotificationOnAppointmentReject,
      receiveNotificationOnConsultantMessage:
          receiveNotificationOnConsultantMessage ??
              this.receiveNotificationOnConsultantMessage,
      receiveNotificationOnConsultantReply:
          receiveNotificationOnConsultantReply ??
              this.receiveNotificationOnConsultantReply,
      receiveNotificationOnSuccessfulPayment:
          receiveNotificationOnSuccessfulPayment ??
              this.receiveNotificationOnSuccessfulPayment,
      receiveNotificationOnTwoFactorAuthEnabled:
          receiveNotificationOnTwoFactorAuthEnabled ??
              this.receiveNotificationOnTwoFactorAuthEnabled,
      receiveNotificationOnCustomerSupportMessage:
          receiveNotificationOnCustomerSupportMessage ??
              this.receiveNotificationOnCustomerSupportMessage,
      receiveNotificationOnAppointmentChangeRequest:
          receiveNotificationOnAppointmentChangeRequest ??
              this.receiveNotificationOnAppointmentChangeRequest,
      receiveNotificationOnExpiredConsultationAccept:
          receiveNotificationOnExpiredConsultationAccept ??
              this.receiveNotificationOnExpiredConsultationAccept,
      receiveNotificationBeforePublishingScheduledConsultation:
          receiveNotificationBeforePublishingScheduledConsultation ??
              this.receiveNotificationBeforePublishingScheduledConsultation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _SettingsContract.acceptNotificationsViaApp:
          acceptNotificationsViaApp?.toInt,
      _SettingsContract.acceptNotificationsViaSms:
          acceptNotificationsViaSms?.toInt,
      _SettingsContract.acceptNotificationsViaEmail:
          acceptNotificationsViaEmail?.toInt,
      _SettingsContract.acceptNotificationsViaWhatsapp:
          acceptNotificationsViaWhatsapp?.toInt,
      _SettingsContract.automaticAcceptForLowestOffers:
          automaticAcceptForLowestOffers?.toInt,
      _SettingsContract.receiveNotificationOnPriceOffer:
          receiveNotificationOnPriceOffer?.toInt,
      _SettingsContract.activateMultiFactorAuthentication:
          activateMultiFactorAuthentication?.toInt,
      _SettingsContract.receiveNotificationOnRefundCredit:
          receiveNotificationOnRefundCredit?.toInt,
      _SettingsContract.receiveNotificationForPendingPayment:
          receiveNotificationForPendingPayment?.toInt,
      _SettingsContract.receiveNotificationOnAppointmentAccept:
          receiveNotificationOnAppointmentAccept?.toInt,
      _SettingsContract.receiveNotificationOnAppointmentReject:
          receiveNotificationOnAppointmentReject?.toInt,
      _SettingsContract.receiveNotificationOnConsultantMessage:
          receiveNotificationOnConsultantMessage?.toInt,
      _SettingsContract.receiveNotificationOnConsultantReply:
          receiveNotificationOnConsultantReply?.toInt,
      _SettingsContract.receiveNotificationOnSuccessfulPayment:
          receiveNotificationOnSuccessfulPayment?.toInt,
      _SettingsContract.receiveNotificationOnTwoFactorAuthEnabled:
          receiveNotificationOnTwoFactorAuthEnabled?.toInt,
      _SettingsContract.receiveNotificationOnCustomerSupportMessage:
          receiveNotificationOnCustomerSupportMessage?.toInt,
      _SettingsContract.receiveNotificationOnAppointmentChangeRequest:
          receiveNotificationOnAppointmentChangeRequest?.toInt,
      _SettingsContract.receiveNotificationOnExpiredConsultationAccept:
          receiveNotificationOnExpiredConsultationAccept?.toInt,
      _SettingsContract
              .receiveNotificationBeforePublishingScheduledConsultation:
          receiveNotificationBeforePublishingScheduledConsultation?.toInt,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      acceptNotificationsViaApp:
          map[_SettingsContract.acceptNotificationsViaApp] != 0,
      acceptNotificationsViaSms:
          map[_SettingsContract.acceptNotificationsViaSms] != 0,
      acceptNotificationsViaEmail:
          map[_SettingsContract.acceptNotificationsViaEmail] != 0,
      acceptNotificationsViaWhatsapp:
          map[_SettingsContract.acceptNotificationsViaWhatsapp] != 0,
      automaticAcceptForLowestOffers:
          map[_SettingsContract.automaticAcceptForLowestOffers] != 0,
      receiveNotificationOnPriceOffer:
          map[_SettingsContract.receiveNotificationOnPriceOffer] != 0,
      activateMultiFactorAuthentication:
          map[_SettingsContract.activateMultiFactorAuthentication] != 0,
      receiveNotificationOnRefundCredit:
          map[_SettingsContract.receiveNotificationOnRefundCredit] != 0,
      receiveNotificationForPendingPayment:
          map[_SettingsContract.receiveNotificationForPendingPayment] != 0,
      receiveNotificationOnAppointmentAccept:
          map[_SettingsContract.receiveNotificationOnAppointmentAccept] != 0,
      receiveNotificationOnAppointmentReject:
          map[_SettingsContract.receiveNotificationOnAppointmentReject] != 0,
      receiveNotificationOnConsultantMessage:
          map[_SettingsContract.receiveNotificationOnConsultantMessage] != 0,
      receiveNotificationOnConsultantReply:
          map[_SettingsContract.receiveNotificationOnConsultantReply] != 0,
      receiveNotificationOnSuccessfulPayment:
          map[_SettingsContract.receiveNotificationOnSuccessfulPayment] != 0,
      receiveNotificationOnTwoFactorAuthEnabled:
          map[_SettingsContract.receiveNotificationOnTwoFactorAuthEnabled] != 0,
      receiveNotificationOnCustomerSupportMessage:
          map[_SettingsContract.receiveNotificationOnCustomerSupportMessage] !=
              0,
      receiveNotificationOnAppointmentChangeRequest: map[_SettingsContract
              .receiveNotificationOnAppointmentChangeRequest] !=
          0,
      receiveNotificationOnExpiredConsultationAccept: map[_SettingsContract
              .receiveNotificationOnExpiredConsultationAccept] !=
          0,
      receiveNotificationBeforePublishingScheduledConsultation: map[
              _SettingsContract
                  .receiveNotificationBeforePublishingScheduledConsultation] !=
          0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Settings(acceptNotificationsViaApp: $acceptNotificationsViaApp, acceptNotificationsViaSms: $acceptNotificationsViaSms, acceptNotificationsViaEmail: $acceptNotificationsViaEmail, acceptNotificationsViaWhatsapp: $acceptNotificationsViaWhatsapp, automaticAcceptForLowestOffers: $automaticAcceptForLowestOffers, receiveNotificationOnPriceOffer: $receiveNotificationOnPriceOffer, activateMultiFactorAuthentication: $activateMultiFactorAuthentication, receiveNotificationOnRefundCredit: $receiveNotificationOnRefundCredit, receiveNotificationForPendingPayment: $receiveNotificationForPendingPayment, receiveNotificationOnAppointmentAccept: $receiveNotificationOnAppointmentAccept, receiveNotificationOnAppointmentReject: $receiveNotificationOnAppointmentReject, receiveNotificationOnConsultantMessage: $receiveNotificationOnConsultantMessage, receiveNotificationOnConsultantReply: $receiveNotificationOnConsultantReply, receiveNotificationOnSuccessfulPayment: $receiveNotificationOnSuccessfulPayment, receiveNotificationOnTwoFactorAuthEnabled: $receiveNotificationOnTwoFactorAuthEnabled, receiveNotificationOnCustomerSupportMessage: $receiveNotificationOnCustomerSupportMessage, receiveNotificationOnAppointmentChangeRequest: $receiveNotificationOnAppointmentChangeRequest, receiveNotificationOnExpiredConsultationAccept: $receiveNotificationOnExpiredConsultationAccept, receiveNotificationBeforePublishingScheduledConsultation: $receiveNotificationBeforePublishingScheduledConsultation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Settings &&
        other.acceptNotificationsViaApp == acceptNotificationsViaApp &&
        other.acceptNotificationsViaSms == acceptNotificationsViaSms &&
        other.acceptNotificationsViaEmail == acceptNotificationsViaEmail &&
        other.acceptNotificationsViaWhatsapp ==
            acceptNotificationsViaWhatsapp &&
        other.automaticAcceptForLowestOffers ==
            automaticAcceptForLowestOffers &&
        other.receiveNotificationOnPriceOffer ==
            receiveNotificationOnPriceOffer &&
        other.activateMultiFactorAuthentication ==
            activateMultiFactorAuthentication &&
        other.receiveNotificationOnRefundCredit ==
            receiveNotificationOnRefundCredit &&
        other.receiveNotificationForPendingPayment ==
            receiveNotificationForPendingPayment &&
        other.receiveNotificationOnAppointmentAccept ==
            receiveNotificationOnAppointmentAccept &&
        other.receiveNotificationOnAppointmentReject ==
            receiveNotificationOnAppointmentReject &&
        other.receiveNotificationOnConsultantMessage ==
            receiveNotificationOnConsultantMessage &&
        other.receiveNotificationOnConsultantReply ==
            receiveNotificationOnConsultantReply &&
        other.receiveNotificationOnSuccessfulPayment ==
            receiveNotificationOnSuccessfulPayment &&
        other.receiveNotificationOnTwoFactorAuthEnabled ==
            receiveNotificationOnTwoFactorAuthEnabled &&
        other.receiveNotificationOnCustomerSupportMessage ==
            receiveNotificationOnCustomerSupportMessage &&
        other.receiveNotificationOnAppointmentChangeRequest ==
            receiveNotificationOnAppointmentChangeRequest &&
        other.receiveNotificationOnExpiredConsultationAccept ==
            receiveNotificationOnExpiredConsultationAccept &&
        other.receiveNotificationBeforePublishingScheduledConsultation ==
            receiveNotificationBeforePublishingScheduledConsultation;
  }

  @override
  int get hashCode {
    return acceptNotificationsViaApp.hashCode ^
        acceptNotificationsViaSms.hashCode ^
        acceptNotificationsViaEmail.hashCode ^
        acceptNotificationsViaWhatsapp.hashCode ^
        automaticAcceptForLowestOffers.hashCode ^
        receiveNotificationOnPriceOffer.hashCode ^
        activateMultiFactorAuthentication.hashCode ^
        receiveNotificationOnRefundCredit.hashCode ^
        receiveNotificationForPendingPayment.hashCode ^
        receiveNotificationOnAppointmentAccept.hashCode ^
        receiveNotificationOnAppointmentReject.hashCode ^
        receiveNotificationOnConsultantMessage.hashCode ^
        receiveNotificationOnConsultantReply.hashCode ^
        receiveNotificationOnSuccessfulPayment.hashCode ^
        receiveNotificationOnTwoFactorAuthEnabled.hashCode ^
        receiveNotificationOnCustomerSupportMessage.hashCode ^
        receiveNotificationOnAppointmentChangeRequest.hashCode ^
        receiveNotificationOnExpiredConsultationAccept.hashCode ^
        receiveNotificationBeforePublishingScheduledConsultation.hashCode;
  }
}

class _SettingsContract {
  static const acceptNotificationsViaApp = 'accept_notifications_via_app';
  static const acceptNotificationsViaSms = 'accept_notifications_via_sms';
  static const acceptNotificationsViaEmail = 'accept_notifications_via_email';
  static const acceptNotificationsViaWhatsapp =
      'accept_notifications_via_whatsapp';
  static const automaticAcceptForLowestOffers =
      'automatic_accept_for_lowest_offers';
  static const receiveNotificationOnPriceOffer =
      'receive_notification_on_price_offer';
  static const activateMultiFactorAuthentication =
      'activate_multi_factor_authentication';
  static const receiveNotificationOnRefundCredit =
      'receive_notification_on_refund_credit';
  static const receiveNotificationForPendingPayment =
      'receive_notification_for_pending_payment';
  static const receiveNotificationOnAppointmentAccept =
      'receive_notification_on_appointment_accept';
  static const receiveNotificationOnAppointmentReject =
      'receive_notification_on_appointment_reject';
  static const receiveNotificationOnConsultantMessage =
      'receive_notification_on_consultant_message';
  static const receiveNotificationOnConsultantReply =
      'receive_notification_on_consultation_reply';
  static const receiveNotificationOnSuccessfulPayment =
      'receive_notification_on_successful_payment';
  static const receiveNotificationOnTwoFactorAuthEnabled =
      'receive_notification_on_two_factor_auth_enabled';
  static const receiveNotificationOnCustomerSupportMessage =
      'receive_notification_on_customer_support_message';
  static const receiveNotificationOnAppointmentChangeRequest =
      'receive_notification_on_appointment_change_request';
  static const receiveNotificationOnExpiredConsultationAccept =
      'receive_notification_on_expired_consultation_accept';
  static const receiveNotificationBeforePublishingScheduledConsultation =
      'receive_notification_before_publishing_scheduled_consultation';
}
