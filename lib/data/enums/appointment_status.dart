enum AppointmentStatus { upcoming, ended }

extension AppointmentStatusExtension on AppointmentStatus {
  int toMap() {
    if (this == AppointmentStatus.upcoming) {
      return 1;
    }
    return 2;
  }
}

extension AppointmentStatusIntExtension on int {
  AppointmentStatus appointmentStatusFromMap() {
    if (this == 1) {
      return AppointmentStatus.upcoming;
    }
    return AppointmentStatus.ended;
  }
}
