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
  }) =>
      Settings(
        acceptNotificationsViaApp:
            acceptNotificationsViaApp ?? this.acceptNotificationsViaApp,
        acceptNotificationsViaSms:
            acceptNotificationsViaSms ?? this.acceptNotificationsViaSms,
        acceptNotificationsViaEmail:
            acceptNotificationsViaEmail ?? this.acceptNotificationsViaEmail,
        acceptNotificationsViaWhatsapp: acceptNotificationsViaWhatsapp ??
            this.acceptNotificationsViaWhatsapp,
        automaticAcceptForLowestOffers: automaticAcceptForLowestOffers ??
            this.automaticAcceptForLowestOffers,
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

  Map<String, dynamic> toMap() {
    final contract = _SettingsContract();

    return {
      contract.acceptNotificationsViaApp: acceptNotificationsViaApp?.toInt,
      contract.acceptNotificationsViaSms: acceptNotificationsViaSms?.toInt,
      contract.acceptNotificationsViaEmail: acceptNotificationsViaEmail?.toInt,
      contract.acceptNotificationsViaWhatsapp:
          acceptNotificationsViaWhatsapp?.toInt,
      contract.automaticAcceptForLowestOffers:
          automaticAcceptForLowestOffers?.toInt,
      contract.receiveNotificationOnPriceOffer:
          receiveNotificationOnPriceOffer?.toInt,
      contract.activateMultiFactorAuthentication:
          activateMultiFactorAuthentication?.toInt,
      contract.receiveNotificationOnRefundCredit:
          receiveNotificationOnRefundCredit?.toInt,
      contract.receiveNotificationForPendingPayment:
          receiveNotificationForPendingPayment?.toInt,
      contract.receiveNotificationOnAppointmentAccept:
          receiveNotificationOnAppointmentAccept?.toInt,
      contract.receiveNotificationOnAppointmentReject:
          receiveNotificationOnAppointmentReject?.toInt,
      contract.receiveNotificationOnConsultantMessage:
          receiveNotificationOnConsultantMessage?.toInt,
      contract.receiveNotificationOnConsultantReply:
          receiveNotificationOnConsultantReply?.toInt,
      contract.receiveNotificationOnSuccessfulPayment:
          receiveNotificationOnSuccessfulPayment?.toInt,
      contract.receiveNotificationOnTwoFactorAuthEnabled:
          receiveNotificationOnTwoFactorAuthEnabled?.toInt,
      contract.receiveNotificationOnCustomerSupportMessage:
          receiveNotificationOnCustomerSupportMessage?.toInt,
      contract.receiveNotificationOnAppointmentChangeRequest:
          receiveNotificationOnAppointmentChangeRequest?.toInt,
      contract.receiveNotificationOnExpiredConsultationAccept:
          receiveNotificationOnExpiredConsultationAccept?.toInt,
      contract.receiveNotificationBeforePublishingScheduledConsultation:
          receiveNotificationBeforePublishingScheduledConsultation?.toInt,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    final contract = _SettingsContract();

    return Settings(
      acceptNotificationsViaApp: map[contract.acceptNotificationsViaApp] != 0,
      acceptNotificationsViaSms: map[contract.acceptNotificationsViaSms] != 0,
      acceptNotificationsViaEmail:
          map[contract.acceptNotificationsViaEmail] != 0,
      acceptNotificationsViaWhatsapp:
          map[contract.acceptNotificationsViaWhatsapp] != 0,
      automaticAcceptForLowestOffers:
          map[contract.automaticAcceptForLowestOffers] != 0,
      receiveNotificationOnPriceOffer:
          map[contract.receiveNotificationOnPriceOffer] != 0,
      activateMultiFactorAuthentication:
          map[contract.activateMultiFactorAuthentication] != 0,
      receiveNotificationOnRefundCredit:
          map[contract.receiveNotificationOnRefundCredit] != 0,
      receiveNotificationForPendingPayment:
          map[contract.receiveNotificationForPendingPayment] != 0,
      receiveNotificationOnAppointmentAccept:
          map[contract.receiveNotificationOnAppointmentAccept] != 0,
      receiveNotificationOnAppointmentReject:
          map[contract.receiveNotificationOnAppointmentReject] != 0,
      receiveNotificationOnConsultantMessage:
          map[contract.receiveNotificationOnConsultantMessage] != 0,
      receiveNotificationOnConsultantReply:
          map[contract.receiveNotificationOnConsultantReply] != 0,
      receiveNotificationOnSuccessfulPayment:
          map[contract.receiveNotificationOnSuccessfulPayment] != 0,
      receiveNotificationOnTwoFactorAuthEnabled:
          map[contract.receiveNotificationOnTwoFactorAuthEnabled] != 0,
      receiveNotificationOnCustomerSupportMessage:
          map[contract.receiveNotificationOnCustomerSupportMessage] != 0,
      receiveNotificationOnAppointmentChangeRequest:
          map[contract.receiveNotificationOnAppointmentChangeRequest] != 0,
      receiveNotificationOnExpiredConsultationAccept:
          map[contract.receiveNotificationOnExpiredConsultationAccept] != 0,
      receiveNotificationBeforePublishingScheduledConsultation: map[contract
              .receiveNotificationBeforePublishingScheduledConsultation] !=
          0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));

  @override
  String toString() =>
      'Settings(acceptNotificationsViaApp: $acceptNotificationsViaApp, acceptNotificationsViaSms: $acceptNotificationsViaSms, acceptNotificationsViaEmail: $acceptNotificationsViaEmail, acceptNotificationsViaWhatsapp: $acceptNotificationsViaWhatsapp, automaticAcceptForLowestOffers: $automaticAcceptForLowestOffers, receiveNotificationOnPriceOffer: $receiveNotificationOnPriceOffer, activateMultiFactorAuthentication: $activateMultiFactorAuthentication, receiveNotificationOnRefundCredit: $receiveNotificationOnRefundCredit, receiveNotificationForPendingPayment: $receiveNotificationForPendingPayment, receiveNotificationOnAppointmentAccept: $receiveNotificationOnAppointmentAccept, receiveNotificationOnAppointmentReject: $receiveNotificationOnAppointmentReject, receiveNotificationOnConsultantMessage: $receiveNotificationOnConsultantMessage, receiveNotificationOnConsultantReply: $receiveNotificationOnConsultantReply, receiveNotificationOnSuccessfulPayment: $receiveNotificationOnSuccessfulPayment, receiveNotificationOnTwoFactorAuthEnabled: $receiveNotificationOnTwoFactorAuthEnabled, receiveNotificationOnCustomerSupportMessage: $receiveNotificationOnCustomerSupportMessage, receiveNotificationOnAppointmentChangeRequest: $receiveNotificationOnAppointmentChangeRequest, receiveNotificationOnExpiredConsultationAccept: $receiveNotificationOnExpiredConsultationAccept, receiveNotificationBeforePublishingScheduledConsultation: $receiveNotificationBeforePublishingScheduledConsultation)';

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
  int get hashCode =>
      acceptNotificationsViaApp.hashCode ^
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

class _SettingsContract {
  final acceptNotificationsViaApp = 'accept_notifications_via_app';
  final acceptNotificationsViaSms = 'accept_notifications_via_sms';
  final acceptNotificationsViaEmail = 'accept_notifications_via_email';
  final acceptNotificationsViaWhatsapp = 'accept_notifications_via_whatsapp';
  final automaticAcceptForLowestOffers = 'automatic_accept_for_lowest_offers';
  final receiveNotificationOnPriceOffer = 'receive_notification_on_price_offer';
  final activateMultiFactorAuthentication =
      'activate_multi_factor_authentication';
  final receiveNotificationOnRefundCredit =
      'receive_notification_on_refund_credit';
  final receiveNotificationForPendingPayment =
      'receive_notification_for_pending_payment';
  final receiveNotificationOnAppointmentAccept =
      'receive_notification_on_appointment_accept';
  final receiveNotificationOnAppointmentReject =
      'receive_notification_on_appointment_reject';
  final receiveNotificationOnConsultantMessage =
      'receive_notification_on_consultant_message';
  final receiveNotificationOnConsultantReply =
      'receive_notification_on_consultation_reply';
  final receiveNotificationOnSuccessfulPayment =
      'receive_notification_on_successful_payment';
  final receiveNotificationOnTwoFactorAuthEnabled =
      'receive_notification_on_two_factor_auth_enabled';
  final receiveNotificationOnCustomerSupportMessage =
      'receive_notification_on_customer_support_message';
  final receiveNotificationOnAppointmentChangeRequest =
      'receive_notification_on_appointment_change_request';
  final receiveNotificationOnExpiredConsultationAccept =
      'receive_notification_on_expired_consultation_accept';
  final receiveNotificationBeforePublishingScheduledConsultation =
      'receive_notification_before_publishing_scheduled_consultation';
}
