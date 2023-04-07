enum Gender { male, female }

extension GenderExtension on Gender {
  int toMap() {
    if (this == Gender.male) {
      return 1;
    }
    return 2;
  }
}

extension GenderIntExtension on int {
  Gender genderFromMap() {
    if (this == 1) {
      return Gender.male;
    }
    return Gender.female;
  }
}
