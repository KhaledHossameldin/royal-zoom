enum ConsultationVisibilityStatus {
  hidden,
  acceptedByUser,
  acceptedByConsultant,
  acceptedByAll,
}

extension ConsultationVisibilityExtension on ConsultationVisibilityStatus {
  int toMap() {
    switch (this) {
      case ConsultationVisibilityStatus.hidden:
        return 1;

      case ConsultationVisibilityStatus.acceptedByUser:
        return 2;

      case ConsultationVisibilityStatus.acceptedByConsultant:
        return 3;

      default:
        return 4;
    }
  }
}

extension ConsultationVisibilityIntExtension on int {
  ConsultationVisibilityStatus consultationVisibilityFromMap() {
    switch (this) {
      case 1:
        return ConsultationVisibilityStatus.hidden;

      case 2:
        return ConsultationVisibilityStatus.acceptedByUser;

      case 3:
        return ConsultationVisibilityStatus.acceptedByConsultant;

      default:
        return ConsultationVisibilityStatus.acceptedByAll;
    }
  }
}
