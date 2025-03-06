enum NewMajorStatus {
  pending,
  approved,
  rejected,
}

extension NewMajorStatusExtenstion on NewMajorStatus {
  int toMap() {
    switch (this) {
      case NewMajorStatus.pending:
        return 1;
      case NewMajorStatus.approved:
        return 2;
      case NewMajorStatus.rejected:
        return 3;
    }
  }
}

extension NewMajorStatusIntExtenstion on int {
  NewMajorStatus newMajorStatusFromMap() {
    switch (this) {
      case 1:
        return NewMajorStatus.pending;
      case 2:
        return NewMajorStatus.approved;
      case 3:
        return NewMajorStatus.rejected;
      default:
        return NewMajorStatus.pending;
    }
  }
}
