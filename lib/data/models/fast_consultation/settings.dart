class Settings {
  num? acceptNotificationsViaSms;
  num? acceptNotificationsViaEmail;
  num? acceptNotificationsViaWhatsapp;
  num? activateMultiFactorAuthentication;
  num? receiveNotificationOnRefundCredit;
  num? receiveNotificationForPendingPayment;
  num? receiveNotificationOnAppointmentAccept;
  num? receiveNotificationOnAppointmentReject;
  num? receiveNotificationOnConsultantMessage;
  num? receiveNotificationOnConsultationReply;
  num? receiveNotificationOnCustomerSupportMessage;
  num? receiveNotificationOnAppointmentChangeRequest;

  Settings({
    this.acceptNotificationsViaSms,
    this.acceptNotificationsViaEmail,
    this.acceptNotificationsViaWhatsapp,
    this.activateMultiFactorAuthentication,
    this.receiveNotificationOnRefundCredit,
    this.receiveNotificationForPendingPayment,
    this.receiveNotificationOnAppointmentAccept,
    this.receiveNotificationOnAppointmentReject,
    this.receiveNotificationOnConsultantMessage,
    this.receiveNotificationOnConsultationReply,
    this.receiveNotificationOnCustomerSupportMessage,
    this.receiveNotificationOnAppointmentChangeRequest,
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
        receiveNotificationOnRefundCredit: num.tryParse(
            json['receive_notification_on_refund_credit'].toString()),
        receiveNotificationForPendingPayment: num.tryParse(
            json['receive_notification_for_pending_payment'].toString()),
        receiveNotificationOnAppointmentAccept: num.tryParse(
            json['receive_notification_on_appointment_accept'].toString()),
        receiveNotificationOnAppointmentReject: num.tryParse(
            json['receive_notification_on_appointment_reject'].toString()),
        receiveNotificationOnConsultantMessage: num.tryParse(
            json['receive_notification_on_consultant_message'].toString()),
        receiveNotificationOnConsultationReply: num.tryParse(
            json['receive_notification_on_consultation_reply'].toString()),
        receiveNotificationOnCustomerSupportMessage: num.tryParse(
            json['receive_notification_on_customer_support_message']
                .toString()),
        receiveNotificationOnAppointmentChangeRequest: num.tryParse(
            json['receive_notification_on_appointment_change_request']
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
        if (receiveNotificationOnCustomerSupportMessage != null)
          'receive_notification_on_customer_support_message':
              receiveNotificationOnCustomerSupportMessage,
        if (receiveNotificationOnAppointmentChangeRequest != null)
          'receive_notification_on_appointment_change_request':
              receiveNotificationOnAppointmentChangeRequest,
      };
}
