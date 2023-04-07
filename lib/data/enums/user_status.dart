enum UserStatus { pending, active, blocked }

extension UserStatusExtension on UserStatus {
  int toMap() {
    if (this == UserStatus.pending) {
      return 1;
    }
    if (this == UserStatus.active) {
      return 2;
    }
    return 3;
  }
}

extension UserStatusIntExtension on int {
  UserStatus userStatusFromMap() {
    if (this == 1) {
      return UserStatus.pending;
    }
    if (this == 2) {
      return UserStatus.active;
    }
    return UserStatus.blocked;
  }
}
