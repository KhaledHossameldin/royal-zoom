enum ConsultationContentType { text, voice }

extension ConsultationContentTypeExtension on ConsultationContentType {
  int toMap() {
    if (this == ConsultationContentType.text) {
      return 1;
    }
    return 2;
  }
}

extension ConsultationContentTypeIntExtension on int {
  ConsultationContentType consultationContentTypeFromMap() {
    if (this == 1) {
      return ConsultationContentType.text;
    }
    return ConsultationContentType.voice;
  }
}
