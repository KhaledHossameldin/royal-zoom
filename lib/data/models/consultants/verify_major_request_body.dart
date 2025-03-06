class VerifyRequestBody {
  final int majorId;
  final String resume;
  final String identityProof;
  final List<String> attachments;
  final bool isAcceptPaidConsultations;

  VerifyRequestBody({
    required this.majorId,
    required this.resume,
    required this.identityProof,
    required this.attachments,
    required this.isAcceptPaidConsultations,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'accept_paid_consultations': isAcceptPaidConsultations,
      'major_id': majorId,
      'documents': [
        {'major_document_id': 1, 'file': resume},
        {'major_document_id': 2, 'file': identityProof}
      ],
    };
    if (attachments.isNotEmpty) {
      map.putIfAbsent('attachments', () => attachments);
    }
    return map;
  }

  VerifyRequestBody copyWith({
    int? majorId,
    bool? acceptPaidConsultations,
    String? resume,
    String? identityProof,
    List<String>? attachments,
    bool? isAcceptPaidConsultations,
  }) {
    return VerifyRequestBody(
      majorId: majorId ?? this.majorId,
      resume: resume ?? this.resume,
      identityProof: identityProof ?? this.identityProof,
      attachments: attachments ?? this.attachments,
      isAcceptPaidConsultations:
          isAcceptPaidConsultations ?? this.isAcceptPaidConsultations,
    );
  }

  @override
  String toString() {
    return 'VerifyRequestBody(majorId: $majorId, isAcceptPaidConsultations: $isAcceptPaidConsultations, resume: $resume, identityProof: $identityProof, attachments: $attachments)';
  }
}
