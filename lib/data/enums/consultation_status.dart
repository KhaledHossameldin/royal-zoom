enum ConsultationStatus {
  draft,
  pending,
  scehduled,
  requestToChangetime,
  approvedByConsultant,
  confirmedByUser,
  pendingPayment,
  underReview,
  answeredByConsultant,
  ended,
  cancelledByConsultant,
  cancelledByUser,
  cancelledBySystem,
}

extension ConsultationStatusExtension on ConsultationStatus {
  int toMap() {
    switch (this) {
      case ConsultationStatus.draft:
        return 1;

      case ConsultationStatus.pending:
        return 2;

      case ConsultationStatus.scehduled:
        return 3;

      case ConsultationStatus.requestToChangetime:
        return 4;

      case ConsultationStatus.approvedByConsultant:
        return 5;

      case ConsultationStatus.confirmedByUser:
        return 6;

      case ConsultationStatus.pendingPayment:
        return 7;

      case ConsultationStatus.underReview:
        return 8;

      case ConsultationStatus.answeredByConsultant:
        return 9;

      case ConsultationStatus.ended:
        return 10;

      case ConsultationStatus.cancelledByConsultant:
        return 11;

      case ConsultationStatus.cancelledByUser:
        return 12;

      default:
        return 13;
    }
  }
}

extension ConsultationStatusIntExtension on int {
  ConsultationStatus consultationStatusFromMap() {
    switch (this) {
      case 1:
        return ConsultationStatus.draft;

      case 2:
        return ConsultationStatus.pending;

      case 3:
        return ConsultationStatus.scehduled;

      case 4:
        return ConsultationStatus.requestToChangetime;

      case 5:
        return ConsultationStatus.approvedByConsultant;

      case 6:
        return ConsultationStatus.confirmedByUser;

      case 7:
        return ConsultationStatus.pendingPayment;

      case 8:
        return ConsultationStatus.underReview;

      case 9:
        return ConsultationStatus.answeredByConsultant;

      case 10:
        return ConsultationStatus.ended;

      case 11:
        return ConsultationStatus.cancelledByConsultant;

      case 12:
        return ConsultationStatus.cancelledByUser;

      default:
        return ConsultationStatus.cancelledBySystem;
    }
  }
}
