enum NotificationChannel { database, email, sms, whatsapp }

extension NotificationChannelExtension on NotificationChannel {
  int toMap() {
    if (this == NotificationChannel.database) {
      return 1;
    }
    if (this == NotificationChannel.email) {
      return 2;
    }
    if (this == NotificationChannel.sms) {
      return 3;
    }
    return 4;
  }
}

extension NotificationChannelInt on int {
  NotificationChannel notificationChannelFromMap() {
    if (this == 1) {
      return NotificationChannel.database;
    }
    if (this == 2) {
      return NotificationChannel.email;
    }
    if (this == 3) {
      return NotificationChannel.sms;
    }
    return NotificationChannel.whatsapp;
  }
}
