// resource type
// 1 consultation
// 2 support ticket

// chat content type
// 1 text
// 2 voice
// 3 attachment

enum ChatContentType { text, voice, attachment }

extension ChatContentTypeExtension on ChatContentType {
  int toMap() {
    switch (this) {
      case ChatContentType.text:
        return 1;

      case ChatContentType.voice:
        return 2;

      default:
        return 3;
    }
  }
}

extension ChatContentTypeIntExtension on int {
  ChatContentType chatContentTypeFromMap() {
    switch (this) {
      case 1:
        return ChatContentType.text;

      case 2:
        return ChatContentType.voice;

      default:
        return ChatContentType.attachment;
    }
  }
}
