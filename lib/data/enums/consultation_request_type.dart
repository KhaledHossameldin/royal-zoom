enum ConsultationRequestStatus {
  newType,
  requestToChangeTime,
  tender,
  rejectedByConsultant,
  rejectedByUser,
  apprpvedByConsultant,
  confirmedByUser,
}

extension ConsultationRequestStatusExtension on ConsultationRequestStatus {
  int toMap() {
    if (this == ConsultationRequestStatus.newType) {
      return 1;
    }
    if (this == ConsultationRequestStatus.requestToChangeTime) {
      return 2;
    }
    if (this == ConsultationRequestStatus.tender) {
      return 3;
    }
    if (this == ConsultationRequestStatus.rejectedByConsultant) {
      return 4;
    }
    if (this == ConsultationRequestStatus.rejectedByUser) {
      return 5;
    }
    if (this == ConsultationRequestStatus.apprpvedByConsultant) {
      return 6;
    }
    return 7;
  }
}

extension ConsultationRequestStatusIntExtension on int {
  ConsultationRequestStatus consultationRequestTypeFromMap() {
    if (this == 1) {
      return ConsultationRequestStatus.newType;
    }
    if (this == 2) {
      return ConsultationRequestStatus.requestToChangeTime;
    }
    if (this == 3) {
      return ConsultationRequestStatus.tender;
    }
    if (this == 4) {
      return ConsultationRequestStatus.rejectedByConsultant;
    }
    if (this == 5) {
      return ConsultationRequestStatus.rejectedByUser;
    }
    if (this == 6) {
      return ConsultationRequestStatus.apprpvedByConsultant;
    }
    return ConsultationRequestStatus.confirmedByUser;
  }
}
