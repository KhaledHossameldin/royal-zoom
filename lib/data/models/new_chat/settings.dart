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

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        acceptNotificationsViaSms:
            num.tryParse(json['accept_notifications_via_sms'].toString()),
        acceptNotificationsViaEmail:
            num.tryParse(json['accept_notifications_via_email'].toString()),
        acceptNotificationsViaWhatsapp:
            num.tryParse(json['accept_notifications_via_whatsapp'].toString()),
        activateMultiFactorAuthentication: num.tryParse(
            json['activate_multi_factor_authentication'].toString()),
        receiveNotificationOnRefundRequest: num.tryParse(
            json['receive_notification_on_refund_request'].toString()),
        receiveNotificationOnAppointmentReject: num.tryParse(
            json['receive_notification_on_appointment_reject'].toString()),
        receiveNotificationOnPriceOfferRequest: num.tryParse(
            json['receive_notification_on_price_offer_request'].toString()),
        receiveNotificationOnRecipeClaimAmount: num.tryParse(
            json['receive_notification_on_recipe_claim_amount'].toString()),
        receiveNotificationOnConsultationPayment: num.tryParse(
            json['receive_notification_on_consultation_payment'].toString()),
        receiveNotificationForUpcomingAppointments: num.tryParse(
            json['receive_notification_for_upcoming_appointments'].toString()),
        receiveNotificationOnCommentOnConsultation: num.tryParse(
            json['receive_notification_on_comment_on_consultation'].toString()),
        receiveNotificationOnMajorRequestRejection: num.tryParse(
            json['receive_notification_on_major_request_rejection'].toString()),
        receiveNotificationOnVerificationAcceptance: num.tryParse(
            json['receive_notification_on_verification_acceptance'].toString()),
        receiveNotificationOnAppointmentCancellation: num.tryParse(
            json['receive_notification_on_appointment_cancellation']
                .toString()),
        receiveNotificationOnMajorRequestAcceptance: num.tryParse(
            json['receive_notification_on_major_request_acceptance']
                .toString()),
        receiveNotificationOnAppointmentRequestAtNonWorkingHour: num.tryParse(
            json['receive_notification_on_appointment_request_at_non_working_hour']
                .toString()),
      );

  Map<String, dynamic> toJson() => {
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
}
