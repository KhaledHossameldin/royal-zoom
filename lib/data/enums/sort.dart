enum Sort { ascending, descending }

extension SortExtension on Sort {
  String get text {
    if (this == Sort.ascending) {
      return 'asc';
    }
    return 'desc';
  }
}
