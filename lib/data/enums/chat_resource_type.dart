enum ChatResourceType {
  consultation,
  supportTicket,
  verificationRequests,
  newMajorRequest,
  withdrawRequest
}

extension ChatResourceTypeExtension on ChatResourceType {
  int toMap() {
    switch (this) {
      case ChatResourceType.consultation:
        return 1;
      case ChatResourceType.supportTicket:
        return 2;
      case ChatResourceType.verificationRequests:
        return 3;
      case ChatResourceType.newMajorRequest:
        return 4;
      default:
        return 5;
    }
  }
}

extension ChatResourceTypeIntExtension on int {
  ChatResourceType chatResourceTypeFromMap() {
    switch (this) {
      case 1:
        return ChatResourceType.consultation;
      case 2:
        return ChatResourceType.supportTicket;
      case 3:
        return ChatResourceType.verificationRequests;
      case 4:
        return ChatResourceType.newMajorRequest;
      default:
        return ChatResourceType.withdrawRequest;
    }
  }
}
