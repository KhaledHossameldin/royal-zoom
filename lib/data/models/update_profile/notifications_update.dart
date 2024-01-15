import '../../../utilities/extensions.dart';
import '../authentication/settings.dart';

class NotificationsUpdate {
  bool acceptViaEmail = false;
  bool acceptViaSMS = false;
  bool acceptViaApp = false;
  bool acceptViaWhatsapp = false;
  bool receiveOnPriceOffer = false;
  bool receiveOnConsultationReply = false;
  bool receiveOnAppointmentAccept = false;
  bool receiveOnAppointmentReject = false;
  bool receiveOnAppointmentChangeRequest = false;
  bool receiveOnPendingPayment = false;
  bool receiveOnConsultantMessage = false;
  bool receiveOnCustomerSupportMessage = false;
  bool receiveBeforePublishingScheduledConsultation = false;
  bool receiveOnRefundCredit = false;
  bool receiveOnExpiredConsultationAccept = false;
  bool receiveOnSuccessfulPayment = false;
  bool receiveOnTwoFactorAuthEnabled = false;

  NotificationsUpdate({
    this.acceptViaEmail = false,
    this.acceptViaSMS = false,
    this.acceptViaApp = false,
    this.acceptViaWhatsapp = false,
    this.receiveOnPriceOffer = false,
    this.receiveOnConsultationReply = false,
    this.receiveOnAppointmentAccept = false,
    this.receiveOnAppointmentReject = false,
    this.receiveOnAppointmentChangeRequest = false,
    this.receiveOnPendingPayment = false,
    this.receiveOnConsultantMessage = false,
    this.receiveOnCustomerSupportMessage = false,
    this.receiveBeforePublishingScheduledConsultation = false,
    this.receiveOnRefundCredit = false,
    this.receiveOnExpiredConsultationAccept = false,
    this.receiveOnSuccessfulPayment = false,
    this.receiveOnTwoFactorAuthEnabled = false,
  });

  NotificationsUpdate.fromUserData(Settings settings) {
    acceptViaEmail = settings.acceptNotificationsViaEmail ?? false;
    acceptViaSMS = settings.acceptNotificationsViaSms ?? false;
    acceptViaApp = settings.acceptNotificationsViaApp ?? false;
    acceptViaWhatsapp = settings.acceptNotificationsViaWhatsapp ?? false;
    receiveOnPriceOffer = settings.receiveNotificationOnPriceOffer ?? false;
    receiveOnConsultationReply =
        settings.receiveNotificationOnConsultantReply ?? false;
    receiveOnAppointmentAccept =
        settings.receiveNotificationOnAppointmentAccept ?? false;
    receiveOnAppointmentReject =
        settings.receiveNotificationOnAppointmentAccept ?? false;
    receiveOnAppointmentChangeRequest =
        settings.receiveNotificationOnAppointmentChangeRequest ?? false;
    receiveOnPendingPayment =
        settings.receiveNotificationForPendingPayment ?? false;
    receiveOnConsultantMessage =
        settings.receiveNotificationOnConsultantMessage ?? false;
    receiveOnCustomerSupportMessage =
        settings.receiveNotificationOnCustomerSupportMessage ?? false;
    receiveBeforePublishingScheduledConsultation =
        settings.receiveNotificationBeforePublishingScheduledConsultation ??
            false;
    receiveOnRefundCredit = settings.receiveNotificationOnRefundCredit ?? false;
    receiveOnExpiredConsultationAccept =
        settings.receiveNotificationOnExpiredConsultationAccept ?? false;
    receiveOnSuccessfulPayment =
        settings.receiveNotificationOnSuccessfulPayment ?? false;
    receiveOnTwoFactorAuthEnabled =
        settings.receiveNotificationOnTwoFactorAuthEnabled ?? false;
  }

  NotificationsUpdate copyWith({
    bool? acceptViaEmail,
    bool? acceptViaSMS,
    bool? acceptViaApp,
    bool? acceptViaWhatsapp,
    bool? receiveOnPriceOffer,
    bool? receiveOnConsultationReply,
    bool? receiveOnAppointmentAccept,
    bool? receiveOnAppointmentReject,
    bool? receiveOnAppointmentChangeRequest,
    bool? receiveOnPendingPayment,
    bool? receiveOnConsultantMessage,
    bool? receiveOnCustomerSupportMessage,
    bool? receiveBeforePublishingScheduledConsultation,
    bool? receiveOnRefundCredit,
    bool? receiveOnExpiredConsultationAccept,
    bool? receiveOnSuccessfulPayment,
    bool? receiveOnTwoFactorAuthEnabled,
  }) {
    return NotificationsUpdate(
      acceptViaEmail: acceptViaEmail ?? this.acceptViaEmail,
      acceptViaSMS: acceptViaSMS ?? this.acceptViaSMS,
      acceptViaApp: acceptViaApp ?? this.acceptViaApp,
      acceptViaWhatsapp: acceptViaWhatsapp ?? this.acceptViaWhatsapp,
      receiveOnPriceOffer: receiveOnPriceOffer ?? this.receiveOnPriceOffer,
      receiveOnConsultationReply:
          receiveOnConsultationReply ?? this.receiveOnConsultationReply,
      receiveOnAppointmentAccept:
          receiveOnAppointmentAccept ?? this.receiveOnAppointmentAccept,
      receiveOnAppointmentReject:
          receiveOnAppointmentReject ?? this.receiveOnAppointmentReject,
      receiveOnAppointmentChangeRequest: receiveOnAppointmentChangeRequest ??
          this.receiveOnAppointmentChangeRequest,
      receiveOnPendingPayment:
          receiveOnPendingPayment ?? this.receiveOnPendingPayment,
      receiveOnConsultantMessage:
          receiveOnConsultantMessage ?? this.receiveOnConsultantMessage,
      receiveOnCustomerSupportMessage: receiveOnCustomerSupportMessage ??
          this.receiveOnCustomerSupportMessage,
      receiveBeforePublishingScheduledConsultation:
          receiveBeforePublishingScheduledConsultation ??
              this.receiveBeforePublishingScheduledConsultation,
      receiveOnRefundCredit:
          receiveOnRefundCredit ?? this.receiveOnRefundCredit,
      receiveOnExpiredConsultationAccept: receiveOnExpiredConsultationAccept ??
          this.receiveOnExpiredConsultationAccept,
      receiveOnSuccessfulPayment:
          receiveOnSuccessfulPayment ?? this.receiveOnSuccessfulPayment,
      receiveOnTwoFactorAuthEnabled:
          receiveOnTwoFactorAuthEnabled ?? this.receiveOnTwoFactorAuthEnabled,
    );
  }

  @override
  String toString() {
    return 'NotificationsUpdate(acceptViaEmail: $acceptViaEmail, acceptViaSMS: $acceptViaSMS, acceptViaApp: $acceptViaApp, acceptViaWhatsapp: $acceptViaWhatsapp, receiveOnPriceOffer: $receiveOnPriceOffer, receiveOnConsultationReply: $receiveOnConsultationReply, receiveOnAppointmentAccept: $receiveOnAppointmentAccept, receiveOnAppointmentReject: $receiveOnAppointmentReject, receiveOnAppointmentChangeRequest: $receiveOnAppointmentChangeRequest, receiveOnPendingPayment: $receiveOnPendingPayment, receiveOnConsultantMessage: $receiveOnConsultantMessage, receiveOnCustomerSupportMessage: $receiveOnCustomerSupportMessage, receiveBeforePublishingScheduledConsultation: $receiveBeforePublishingScheduledConsultation, receiveOnRefundCredit: $receiveOnRefundCredit, receiveOnExpiredConsultationAccept: $receiveOnExpiredConsultationAccept, receiveOnSuccessfulPayment: $receiveOnSuccessfulPayment, receiveOnTwoFactorAuthEnabled: $receiveOnTwoFactorAuthEnabled)';
  }

  Map<String, Object> toMap() {
    final contract = _NotificationsUpdateContract();
    return {
      contract.acceptViaEmail: acceptViaEmail.toInt,
      contract.acceptViaSMS: acceptViaSMS.toInt,
      contract.acceptViaApp: acceptViaApp.toInt,
      contract.acceptViaWhatsapp: acceptViaWhatsapp.toInt,
      contract.receiveOnPriceOffer: receiveOnPriceOffer.toInt,
      contract.receiveOnConsultationReply: receiveOnConsultationReply.toInt,
      contract.receiveOnAppointmentAccept: receiveOnAppointmentAccept.toInt,
      contract.receiveOnAppointmentReject: receiveOnAppointmentReject.toInt,
      contract.receiveOnAppointmentChangeRequest:
          receiveOnAppointmentChangeRequest.toInt,
      contract.receiveOnPendingPayment: receiveOnPendingPayment.toInt,
      contract.receiveOnConsultantMessage: receiveOnConsultantMessage.toInt,
      contract.receiveOnCustomerSupportMessage:
          receiveOnCustomerSupportMessage.toInt,
      contract.receiveBeforePublishingScheduledConsultation:
          receiveBeforePublishingScheduledConsultation.toInt,
      contract.receiveOnRefundCredit: receiveOnRefundCredit.toInt,
      contract.receiveOnExpiredConsultationAccept:
          receiveOnExpiredConsultationAccept.toInt,
      contract.receiveOnSuccessfulPayment: receiveOnSuccessfulPayment.toInt,
      contract.receiveOnTwoFactorAuthEnabled:
          receiveOnTwoFactorAuthEnabled.toInt,
    };
  }
}

class _NotificationsUpdateContract {
  final acceptViaEmail = 'accept_notifications_via_email';
  final acceptViaSMS = 'accept_notifications_via_sms';
  final acceptViaApp = 'accept_notifications_via_app';
  final acceptViaWhatsapp = 'accept_notifications_via_whatsapp';
  final receiveOnPriceOffer = 'receive_notification_on_price_offer';
  final receiveOnConsultationReply =
      'receive_notification_on_consultation_reply';
  final receiveOnAppointmentAccept =
      'receive_notification_on_appointment_accept';
  final receiveOnAppointmentReject =
      'receive_notification_on_appointment_reject';
  final receiveOnAppointmentChangeRequest =
      'receive_notification_on_appointment_change_request';
  final receiveOnPendingPayment = 'receive_notification_for_pending_payment';
  final receiveOnConsultantMessage =
      'receive_notification_on_consultant_message';
  final receiveOnCustomerSupportMessage =
      'receive_notification_on_customer_support_message';
  final receiveBeforePublishingScheduledConsultation =
      'receive_notification_before_publishing_scheduled_consultation';
  final receiveOnRefundCredit = 'receive_notification_on_refund_credit';
  final receiveOnExpiredConsultationAccept =
      'receive_notification_on_expired_consultation_accept';
  final receiveOnSuccessfulPayment =
      'receive_notification_on_successful_payment';
  final receiveOnTwoFactorAuthEnabled =
      'receive_notification_on_two_factor_auth_enabled';
}
