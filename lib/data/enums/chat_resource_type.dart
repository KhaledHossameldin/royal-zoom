enum ChatResourceType { consultation, supportTicket }

extension ChatResourceTypeExtension on ChatResourceType {
  int toMap() {
    switch (this) {
      case ChatResourceType.consultation:
        return 1;

      default:
        return 2;
    }
  }
}

extension ChatResourceTypeIntExtension on int {
  ChatResourceType chatResourceTypeFromMap() {
    switch (this) {
      case 1:
        return ChatResourceType.consultation;

      default:
        return ChatResourceType.supportTicket;
    }
  }
}
