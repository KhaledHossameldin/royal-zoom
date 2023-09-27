enum NotificationStatus { invisible, visible }

extension NotificationSendToExtension on NotificationStatus {
  int toMap() {
    if (this == NotificationStatus.invisible) {
      return 0;
    }
    return 1;
  }
}

extension NotificationStatusInt on int {
  NotificationStatus notificationStatusFromMap() {
    if (this == 0) {
      return NotificationStatus.invisible;
    }
    return NotificationStatus.visible;
  }
}
