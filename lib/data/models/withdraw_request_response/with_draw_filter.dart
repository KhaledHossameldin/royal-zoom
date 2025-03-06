class WithDrawFilterRequest {
  String? startDate;
  String? endDate;
  String? sortType;
  int? page;
  WithDrawFilterRequest({
    this.sortType,
    this.endDate,
    this.page,
    this.startDate,
  });

  Map<String, dynamic> toJson() => {
        if (startDate != null) 'start_date': startDate,
        if (endDate != null) 'end_date': endDate,
        if (sortType != null) 'sort_type': sortType,
        if (page != null) 'page': page,
      };

  WithDrawFilterRequest copyWith({
    String? startDate,
    String? endDate,
    String? sortType,
    int? page,
    bool forceNull = false,
  }) {
    if (forceNull) {
      return WithDrawFilterRequest(
        sortType: null,
        endDate: null,
        startDate: null,
        page: page ?? this.page,
      );
    }
    return WithDrawFilterRequest(
      sortType: sortType ?? this.sortType,
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      page: page ?? this.page,
    );
  }
}
