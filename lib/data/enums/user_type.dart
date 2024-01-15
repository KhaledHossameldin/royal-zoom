enum UserType { normal, consultant }

extension UserTypeExtension on UserType {
  int toMap() {
    if (this == UserType.normal) {
      return 1;
    }
    return 2;
  }
}

extension UserTypeIntExtension on int {
  UserType userTypeFromMap() {
    if (this == 1) {
      return UserType.normal;
    }
    return UserType.consultant;
  }
}
