enum MajorType { public, main, sub }

extension MajorTypeExtension on MajorType {
  int toMap() {
    if (this == MajorType.public) {
      return 1;
    }
    if (this == MajorType.main) {
      return 2;
    }
    return 3;
  }
}

extension MajorTypeIntExtension on int {
  MajorType majorTypeFromMap() {
    if (this == 1) {
      return MajorType.public;
    }
    if (this == 2) {
      return MajorType.main;
    }
    return MajorType.sub;
  }
}
