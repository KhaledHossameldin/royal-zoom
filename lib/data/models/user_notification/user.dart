import 'dart:convert';

import 'package:collection/collection.dart';

class User {
  num? acceptNotificationsViaSms;
  num? acceptNotificationsViaEmail;
  num? acceptNotificationsViaWhatsapp;
  num? receiveNotificationOnPriceOffer;
  num? receiveNotificationOnRefundCredit;
  num? receiveNotificationForPendingPayment;
  num? receiveNotificationOnAppointmentAccept;
  num? receiveNotificationOnAppointmentReject;
  num? receiveNotificationOnConsultantMessage;
  num? receiveNotificationOnConsultationReply;
  num? receiveNotificationOnSuccessfulPayment;
  num? receiveNotificationOnCustomerSupportMessage;
  num? receiveNotificationOnAppointmentChangeRequest;
  num? receiveNotificationBeforePublishingScheduledConsultation;

  User({
    this.acceptNotificationsViaSms,
    this.acceptNotificationsViaEmail,
    this.acceptNotificationsViaWhatsapp,
    this.receiveNotificationOnPriceOffer,
    this.receiveNotificationOnRefundCredit,
    this.receiveNotificationForPendingPayment,
    this.receiveNotificationOnAppointmentAccept,
    this.receiveNotificationOnAppointmentReject,
    this.receiveNotificationOnConsultantMessage,
    this.receiveNotificationOnConsultationReply,
    this.receiveNotificationOnSuccessfulPayment,
    this.receiveNotificationOnCustomerSupportMessage,
    this.receiveNotificationOnAppointmentChangeRequest,
    this.receiveNotificationBeforePublishingScheduledConsultation,
  });

  @override
  String toString() {
    return 'User(acceptNotificationsViaSms: $acceptNotificationsViaSms, acceptNotificationsViaEmail: $acceptNotificationsViaEmail, acceptNotificationsViaWhatsapp: $acceptNotificationsViaWhatsapp, receiveNotificationOnPriceOffer: $receiveNotificationOnPriceOffer, receiveNotificationOnRefundCredit: $receiveNotificationOnRefundCredit, receiveNotificationForPendingPayment: $receiveNotificationForPendingPayment, receiveNotificationOnAppointmentAccept: $receiveNotificationOnAppointmentAccept, receiveNotificationOnAppointmentReject: $receiveNotificationOnAppointmentReject, receiveNotificationOnConsultantMessage: $receiveNotificationOnConsultantMessage, receiveNotificationOnConsultationReply: $receiveNotificationOnConsultationReply, receiveNotificationOnSuccessfulPayment: $receiveNotificationOnSuccessfulPayment, receiveNotificationOnCustomerSupportMessage: $receiveNotificationOnCustomerSupportMessage, receiveNotificationOnAppointmentChangeRequest: $receiveNotificationOnAppointmentChangeRequest, receiveNotificationBeforePublishingScheduledConsultation: $receiveNotificationBeforePublishingScheduledConsultation)';
  }

  factory User.fromMap(Map<String, dynamic> data) => User(
        acceptNotificationsViaSms:
            num.tryParse(data['accept_notifications_via_sms'].toString()),
        acceptNotificationsViaEmail:
            num.tryParse(data['accept_notifications_via_email'].toString()),
        acceptNotificationsViaWhatsapp:
            num.tryParse(data['accept_notifications_via_whatsapp'].toString()),
        receiveNotificationOnPriceOffer: num.tryParse(
            data['receive_notification_on_price_offer'].toString()),
        receiveNotificationOnRefundCredit: num.tryParse(
            data['receive_notification_on_refund_credit'].toString()),
        receiveNotificationForPendingPayment: num.tryParse(
            data['receive_notification_for_pending_payment'].toString()),
        receiveNotificationOnAppointmentAccept: num.tryParse(
            data['receive_notification_on_appointment_accept'].toString()),
        receiveNotificationOnAppointmentReject: num.tryParse(
            data['receive_notification_on_appointment_reject'].toString()),
        receiveNotificationOnConsultantMessage: num.tryParse(
            data['receive_notification_on_consultant_message'].toString()),
        receiveNotificationOnConsultationReply: num.tryParse(
            data['receive_notification_on_consultation_reply'].toString()),
        receiveNotificationOnSuccessfulPayment: num.tryParse(
            data['receive_notification_on_successful_payment'].toString()),
        receiveNotificationOnCustomerSupportMessage: num.tryParse(
            data['receive_notification_on_customer_support_message']
                .toString()),
        receiveNotificationOnAppointmentChangeRequest: num.tryParse(
            data['receive_notification_on_appointment_change_request']
                .toString()),
        receiveNotificationBeforePublishingScheduledConsultation: num.tryParse(
            data['receive_notification_before_publishing_scheduled_consultation']
                .toString()),
      );

  Map<String, dynamic> toMap() => {
        if (acceptNotificationsViaSms != null)
          'accept_notifications_via_sms': acceptNotificationsViaSms,
        if (acceptNotificationsViaEmail != null)
          'accept_notifications_via_email': acceptNotificationsViaEmail,
        if (acceptNotificationsViaWhatsapp != null)
          'accept_notifications_via_whatsapp': acceptNotificationsViaWhatsapp,
        if (receiveNotificationOnPriceOffer != null)
          'receive_notification_on_price_offer':
              receiveNotificationOnPriceOffer,
        if (receiveNotificationOnRefundCredit != null)
          'receive_notification_on_refund_credit':
              receiveNotificationOnRefundCredit,
        if (receiveNotificationForPendingPayment != null)
          'receive_notification_for_pending_payment':
              receiveNotificationForPendingPayment,
        if (receiveNotificationOnAppointmentAccept != null)
          'receive_notification_on_appointment_accept':
              receiveNotificationOnAppointmentAccept,
        if (receiveNotificationOnAppointmentReject != null)
          'receive_notification_on_appointment_reject':
              receiveNotificationOnAppointmentReject,
        if (receiveNotificationOnConsultantMessage != null)
          'receive_notification_on_consultant_message':
              receiveNotificationOnConsultantMessage,
        if (receiveNotificationOnConsultationReply != null)
          'receive_notification_on_consultation_reply':
              receiveNotificationOnConsultationReply,
        if (receiveNotificationOnSuccessfulPayment != null)
          'receive_notification_on_successful_payment':
              receiveNotificationOnSuccessfulPayment,
        if (receiveNotificationOnCustomerSupportMessage != null)
          'receive_notification_on_customer_support_message':
              receiveNotificationOnCustomerSupportMessage,
        if (receiveNotificationOnAppointmentChangeRequest != null)
          'receive_notification_on_appointment_change_request':
              receiveNotificationOnAppointmentChangeRequest,
        if (receiveNotificationBeforePublishingScheduledConsultation != null)
          'receive_notification_before_publishing_scheduled_consultation':
              receiveNotificationBeforePublishingScheduledConsultation,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

  User copyWith({
    num? acceptNotificationsViaSms,
    num? acceptNotificationsViaEmail,
    num? acceptNotificationsViaWhatsapp,
    num? receiveNotificationOnPriceOffer,
    num? receiveNotificationOnRefundCredit,
    num? receiveNotificationForPendingPayment,
    num? receiveNotificationOnAppointmentAccept,
    num? receiveNotificationOnAppointmentReject,
    num? receiveNotificationOnConsultantMessage,
    num? receiveNotificationOnConsultationReply,
    num? receiveNotificationOnSuccessfulPayment,
    num? receiveNotificationOnCustomerSupportMessage,
    num? receiveNotificationOnAppointmentChangeRequest,
    num? receiveNotificationBeforePublishingScheduledConsultation,
  }) {
    return User(
      acceptNotificationsViaSms:
          acceptNotificationsViaSms ?? this.acceptNotificationsViaSms,
      acceptNotificationsViaEmail:
          acceptNotificationsViaEmail ?? this.acceptNotificationsViaEmail,
      acceptNotificationsViaWhatsapp:
          acceptNotificationsViaWhatsapp ?? this.acceptNotificationsViaWhatsapp,
      receiveNotificationOnPriceOffer: receiveNotificationOnPriceOffer ??
          this.receiveNotificationOnPriceOffer,
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
      receiveNotificationOnConsultationReply:
          receiveNotificationOnConsultationReply ??
              this.receiveNotificationOnConsultationReply,
      receiveNotificationOnSuccessfulPayment:
          receiveNotificationOnSuccessfulPayment ??
              this.receiveNotificationOnSuccessfulPayment,
      receiveNotificationOnCustomerSupportMessage:
          receiveNotificationOnCustomerSupportMessage ??
              this.receiveNotificationOnCustomerSupportMessage,
      receiveNotificationOnAppointmentChangeRequest:
          receiveNotificationOnAppointmentChangeRequest ??
              this.receiveNotificationOnAppointmentChangeRequest,
      receiveNotificationBeforePublishingScheduledConsultation:
          receiveNotificationBeforePublishingScheduledConsultation ??
              this.receiveNotificationBeforePublishingScheduledConsultation,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      acceptNotificationsViaSms.hashCode ^
      acceptNotificationsViaEmail.hashCode ^
      acceptNotificationsViaWhatsapp.hashCode ^
      receiveNotificationOnPriceOffer.hashCode ^
      receiveNotificationOnRefundCredit.hashCode ^
      receiveNotificationForPendingPayment.hashCode ^
      receiveNotificationOnAppointmentAccept.hashCode ^
      receiveNotificationOnAppointmentReject.hashCode ^
      receiveNotificationOnConsultantMessage.hashCode ^
      receiveNotificationOnConsultationReply.hashCode ^
      receiveNotificationOnSuccessfulPayment.hashCode ^
      receiveNotificationOnCustomerSupportMessage.hashCode ^
      receiveNotificationOnAppointmentChangeRequest.hashCode ^
      receiveNotificationBeforePublishingScheduledConsultation.hashCode;
}
