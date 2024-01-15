enum ConsultantResponseType {
  text,
  voice,
  video,
  onlineMeeting,
  appropriateForConsultant,
  fieldConsultation,
  appCall,
  frequentConsultation,
  none,
}

extension ConsultationContentTypeExtension on ConsultantResponseType {
  int toMap() {
    switch (this) {
      case ConsultantResponseType.text:
        return 1;

      case ConsultantResponseType.voice:
        return 2;

      case ConsultantResponseType.video:
        return 3;

      case ConsultantResponseType.onlineMeeting:
        return 4;

      case ConsultantResponseType.appropriateForConsultant:
        return 5;

      case ConsultantResponseType.fieldConsultation:
        return 6;

      case ConsultantResponseType.appCall:
        return 7;

      case ConsultantResponseType.frequentConsultation:
        return 8;

      default:
        return -1;
    }
  }
}

extension ConsultantResponseTypeIntExtension on int {
  ConsultantResponseType consultantResponseTypeFromMap() {
    switch (this) {
      case 1:
        return ConsultantResponseType.text;

      case 2:
        return ConsultantResponseType.voice;

      case 3:
        return ConsultantResponseType.video;

      case 4:
        return ConsultantResponseType.onlineMeeting;

      case 5:
        return ConsultantResponseType.appropriateForConsultant;

      case 6:
        return ConsultantResponseType.fieldConsultation;

      case 7:
        return ConsultantResponseType.appCall;

      case 8:
        return ConsultantResponseType.frequentConsultation;

      default:
        return ConsultantResponseType.none;
    }
  }
}
