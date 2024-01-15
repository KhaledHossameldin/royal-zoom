enum PreviewStatus { visible, hidden, busy }

extension PreviewStatusExtension on PreviewStatus {
  int toMap() {
    if (this == PreviewStatus.visible) {
      return 1;
    }
    if (this == PreviewStatus.hidden) {
      return 2;
    }
    return 3;
  }
}

extension PreviewStatusIntExtension on int {
  PreviewStatus previewStatusFromMap() {
    if (this == 1) {
      return PreviewStatus.visible;
    }
    if (this == 2) {
      return PreviewStatus.hidden;
    }
    return PreviewStatus.busy;
  }
}
