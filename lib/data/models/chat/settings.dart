import 'dart:convert';

import 'package:collection/collection.dart';

class Settings {
  num? acceptNotificationsViaSms;
  num? acceptNotificationsViaEmail;
  num? acceptNotificationsViaWhatsapp;
  num? activateMultiFactorAuthentication;
  num? receiveNotificationOnRefundRequest;
  num? receiveNotificationOnAppointmentReject;
  num? receiveNotificationOnPriceOfferRequest;
  num? receiveNotificationOnRecipeClaimAmount;
  num? receiveNotificationOnConsultationPayment;
  num? receiveNotificationForUpcomingAppointments;
  num? receiveNotificationOnCommentOnConsultation;
  num? receiveNotificationOnMajorRequestRejection;
  num? receiveNotificationOnVerificationAcceptance;
  num? receiveNotificationOnAppointmentCancellation;
  num? receiveNotificationOnMajorRequestAcceptance;
  num? receiveNotificationOnAppointmentRequestAtNonWorkingHour;

  Settings({
    this.acceptNotificationsViaSms,
    this.acceptNotificationsViaEmail,
    this.acceptNotificationsViaWhatsapp,
    this.activateMultiFactorAuthentication,
    this.receiveNotificationOnRefundRequest,
    this.receiveNotificationOnAppointmentReject,
    this.receiveNotificationOnPriceOfferRequest,
    this.receiveNotificationOnRecipeClaimAmount,
    this.receiveNotificationOnConsultationPayment,
    this.receiveNotificationForUpcomingAppointments,
    this.receiveNotificationOnCommentOnConsultation,
    this.receiveNotificationOnMajorRequestRejection,
    this.receiveNotificationOnVerificationAcceptance,
    this.receiveNotificationOnAppointmentCancellation,
    this.receiveNotificationOnMajorRequestAcceptance,
    this.receiveNotificationOnAppointmentRequestAtNonWorkingHour,
  });

  @override
  String toString() {
    return 'Settings(acceptNotificationsViaSms: $acceptNotificationsViaSms, acceptNotificationsViaEmail: $acceptNotificationsViaEmail, acceptNotificationsViaWhatsapp: $acceptNotificationsViaWhatsapp, activateMultiFactorAuthentication: $activateMultiFactorAuthentication, receiveNotificationOnRefundRequest: $receiveNotificationOnRefundRequest, receiveNotificationOnAppointmentReject: $receiveNotificationOnAppointmentReject, receiveNotificationOnPriceOfferRequest: $receiveNotificationOnPriceOfferRequest, receiveNotificationOnRecipeClaimAmount: $receiveNotificationOnRecipeClaimAmount, receiveNotificationOnConsultationPayment: $receiveNotificationOnConsultationPayment, receiveNotificationForUpcomingAppointments: $receiveNotificationForUpcomingAppointments, receiveNotificationOnCommentOnConsultation: $receiveNotificationOnCommentOnConsultation, receiveNotificationOnMajorRequestRejection: $receiveNotificationOnMajorRequestRejection, receiveNotificationOnVerificationAcceptance: $receiveNotificationOnVerificationAcceptance, receiveNotificationOnAppointmentCancellation: $receiveNotificationOnAppointmentCancellation, receiveNotificationOnMajorRequestAcceptance: $receiveNotificationOnMajorRequestAcceptance, receiveNotificationOnAppointmentRequestAtNonWorkingHour: $receiveNotificationOnAppointmentRequestAtNonWorkingHour)';
  }

  factory Settings.fromMap(Map<String, dynamic> data) => Settings(
        acceptNotificationsViaSms:
            num.tryParse(data['accept_notifications_via_sms'].toString()),
        acceptNotificationsViaEmail:
            num.tryParse(data['accept_notifications_via_email'].toString()),
        acceptNotificationsViaWhatsapp:
            num.tryParse(data['accept_notifications_via_whatsapp'].toString()),
        activateMultiFactorAuthentication: num.tryParse(
            data['activate_multi_factor_authentication'].toString()),
        receiveNotificationOnRefundRequest: num.tryParse(
            data['receive_notification_on_refund_request'].toString()),
        receiveNotificationOnAppointmentReject: num.tryParse(
            data['receive_notification_on_appointment_reject'].toString()),
        receiveNotificationOnPriceOfferRequest: num.tryParse(
            data['receive_notification_on_price_offer_request'].toString()),
        receiveNotificationOnRecipeClaimAmount: num.tryParse(
            data['receive_notification_on_recipe_claim_amount'].toString()),
        receiveNotificationOnConsultationPayment: num.tryParse(
            data['receive_notification_on_consultation_payment'].toString()),
        receiveNotificationForUpcomingAppointments: num.tryParse(
            data['receive_notification_for_upcoming_appointments'].toString()),
        receiveNotificationOnCommentOnConsultation: num.tryParse(
            data['receive_notification_on_comment_on_consultation'].toString()),
        receiveNotificationOnMajorRequestRejection: num.tryParse(
            data['receive_notification_on_major_request_rejection'].toString()),
        receiveNotificationOnVerificationAcceptance: num.tryParse(
            data['receive_notification_on_verification_acceptance'].toString()),
        receiveNotificationOnAppointmentCancellation: num.tryParse(
            data['receive_notification_on_appointment_cancellation']
                .toString()),
        receiveNotificationOnMajorRequestAcceptance: num.tryParse(
            data['receive_notification_on_major_request_acceptance']
                .toString()),
        receiveNotificationOnAppointmentRequestAtNonWorkingHour: num.tryParse(
            data['receive_notification_on_appointment_request_at_non_working_hour']
                .toString()),
      );

  Map<String, dynamic> toMap() => {
        if (acceptNotificationsViaSms != null)
          'accept_notifications_via_sms': acceptNotificationsViaSms,
        if (acceptNotificationsViaEmail != null)
          'accept_notifications_via_email': acceptNotificationsViaEmail,
        if (acceptNotificationsViaWhatsapp != null)
          'accept_notifications_via_whatsapp': acceptNotificationsViaWhatsapp,
        if (activateMultiFactorAuthentication != null)
          'activate_multi_factor_authentication':
              activateMultiFactorAuthentication,
        if (receiveNotificationOnRefundRequest != null)
          'receive_notification_on_refund_request':
              receiveNotificationOnRefundRequest,
        if (receiveNotificationOnAppointmentReject != null)
          'receive_notification_on_appointment_reject':
              receiveNotificationOnAppointmentReject,
        if (receiveNotificationOnPriceOfferRequest != null)
          'receive_notification_on_price_offer_request':
              receiveNotificationOnPriceOfferRequest,
        if (receiveNotificationOnRecipeClaimAmount != null)
          'receive_notification_on_recipe_claim_amount':
              receiveNotificationOnRecipeClaimAmount,
        if (receiveNotificationOnConsultationPayment != null)
          'receive_notification_on_consultation_payment':
              receiveNotificationOnConsultationPayment,
        if (receiveNotificationForUpcomingAppointments != null)
          'receive_notification_for_upcoming_appointments':
              receiveNotificationForUpcomingAppointments,
        if (receiveNotificationOnCommentOnConsultation != null)
          'receive_notification_on_comment_on_consultation':
              receiveNotificationOnCommentOnConsultation,
        if (receiveNotificationOnMajorRequestRejection != null)
          'receive_notification_on_major_request_rejection':
              receiveNotificationOnMajorRequestRejection,
        if (receiveNotificationOnVerificationAcceptance != null)
          'receive_notification_on_verification_acceptance':
              receiveNotificationOnVerificationAcceptance,
        if (receiveNotificationOnAppointmentCancellation != null)
          'receive_notification_on_appointment_cancellation':
              receiveNotificationOnAppointmentCancellation,
        if (receiveNotificationOnMajorRequestAcceptance != null)
          'receive_notification_on_major_request_acceptance':
              receiveNotificationOnMajorRequestAcceptance,
        if (receiveNotificationOnAppointmentRequestAtNonWorkingHour != null)
          'receive_notification_on_appointment_request_at_non_working_hour':
              receiveNotificationOnAppointmentRequestAtNonWorkingHour,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Settings].
  factory Settings.fromJson(String data) {
    return Settings.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Settings] to a JSON string.
  String toJson() => json.encode(toMap());

  Settings copyWith({
    num? acceptNotificationsViaSms,
    num? acceptNotificationsViaEmail,
    num? acceptNotificationsViaWhatsapp,
    num? activateMultiFactorAuthentication,
    num? receiveNotificationOnRefundRequest,
    num? receiveNotificationOnAppointmentReject,
    num? receiveNotificationOnPriceOfferRequest,
    num? receiveNotificationOnRecipeClaimAmount,
    num? receiveNotificationOnConsultationPayment,
    num? receiveNotificationForUpcomingAppointments,
    num? receiveNotificationOnCommentOnConsultation,
    num? receiveNotificationOnMajorRequestRejection,
    num? receiveNotificationOnVerificationAcceptance,
    num? receiveNotificationOnAppointmentCancellation,
    num? receiveNotificationOnMajorRequestAcceptance,
    num? receiveNotificationOnAppointmentRequestAtNonWorkingHour,
  }) {
    return Settings(
      acceptNotificationsViaSms:
          acceptNotificationsViaSms ?? this.acceptNotificationsViaSms,
      acceptNotificationsViaEmail:
          acceptNotificationsViaEmail ?? this.acceptNotificationsViaEmail,
      acceptNotificationsViaWhatsapp:
          acceptNotificationsViaWhatsapp ?? this.acceptNotificationsViaWhatsapp,
      activateMultiFactorAuthentication: activateMultiFactorAuthentication ??
          this.activateMultiFactorAuthentication,
      receiveNotificationOnRefundRequest: receiveNotificationOnRefundRequest ??
          this.receiveNotificationOnRefundRequest,
      receiveNotificationOnAppointmentReject:
          receiveNotificationOnAppointmentReject ??
              this.receiveNotificationOnAppointmentReject,
      receiveNotificationOnPriceOfferRequest:
          receiveNotificationOnPriceOfferRequest ??
              this.receiveNotificationOnPriceOfferRequest,
      receiveNotificationOnRecipeClaimAmount:
          receiveNotificationOnRecipeClaimAmount ??
              this.receiveNotificationOnRecipeClaimAmount,
      receiveNotificationOnConsultationPayment:
          receiveNotificationOnConsultationPayment ??
              this.receiveNotificationOnConsultationPayment,
      receiveNotificationForUpcomingAppointments:
          receiveNotificationForUpcomingAppointments ??
              this.receiveNotificationForUpcomingAppointments,
      receiveNotificationOnCommentOnConsultation:
          receiveNotificationOnCommentOnConsultation ??
              this.receiveNotificationOnCommentOnConsultation,
      receiveNotificationOnMajorRequestRejection:
          receiveNotificationOnMajorRequestRejection ??
              this.receiveNotificationOnMajorRequestRejection,
      receiveNotificationOnVerificationAcceptance:
          receiveNotificationOnVerificationAcceptance ??
              this.receiveNotificationOnVerificationAcceptance,
      receiveNotificationOnAppointmentCancellation:
          receiveNotificationOnAppointmentCancellation ??
              this.receiveNotificationOnAppointmentCancellation,
      receiveNotificationOnMajorRequestAcceptance:
          receiveNotificationOnMajorRequestAcceptance ??
              this.receiveNotificationOnMajorRequestAcceptance,
      receiveNotificationOnAppointmentRequestAtNonWorkingHour:
          receiveNotificationOnAppointmentRequestAtNonWorkingHour ??
              this.receiveNotificationOnAppointmentRequestAtNonWorkingHour,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Settings) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      acceptNotificationsViaSms.hashCode ^
      acceptNotificationsViaEmail.hashCode ^
      acceptNotificationsViaWhatsapp.hashCode ^
      activateMultiFactorAuthentication.hashCode ^
      receiveNotificationOnRefundRequest.hashCode ^
      receiveNotificationOnAppointmentReject.hashCode ^
      receiveNotificationOnPriceOfferRequest.hashCode ^
      receiveNotificationOnRecipeClaimAmount.hashCode ^
      receiveNotificationOnConsultationPayment.hashCode ^
      receiveNotificationForUpcomingAppointments.hashCode ^
      receiveNotificationOnCommentOnConsultation.hashCode ^
      receiveNotificationOnMajorRequestRejection.hashCode ^
      receiveNotificationOnVerificationAcceptance.hashCode ^
      receiveNotificationOnAppointmentCancellation.hashCode ^
      receiveNotificationOnMajorRequestAcceptance.hashCode ^
      receiveNotificationOnAppointmentRequestAtNonWorkingHour.hashCode;
}
