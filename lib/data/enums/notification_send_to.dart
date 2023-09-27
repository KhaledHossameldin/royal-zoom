enum NotificationSendTo { all, admins, consultants, users }

extension NotificationSendToExtension on NotificationSendTo {
  int toMap() {
    if (this == NotificationSendTo.all) {
      return 1;
    }
    if (this == NotificationSendTo.admins) {
      return 2;
    }
    if (this == NotificationSendTo.consultants) {
      return 3;
    }
    return 4;
  }
}

extension NotificationSendToInt on int {
  NotificationSendTo notificationSendToFromMap() {
    if (this == 1) {
      return NotificationSendTo.all;
    }
    if (this == 2) {
      return NotificationSendTo.admins;
    }
    if (this == 3) {
      return NotificationSendTo.consultants;
    }
    return NotificationSendTo.users;
  }
}
