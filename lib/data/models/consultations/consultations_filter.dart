import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../enums/consultation_status.dart';

class ConsultationsFilter {
  ConsultationStatus? status;
  DateTimeRange? dateRange;
  String searchText;

  ConsultationsFilter({
    this.status,
    this.dateRange,
    this.searchText = '',
  });

  ConsultationsFilter copyWith({
    ConsultationStatus? status,
    DateTimeRange? dateRange,
    String? searchText,
  }) {
    return ConsultationsFilter(
      status: status ?? this.status,
      dateRange: dateRange ?? this.dateRange,
      searchText: searchText ?? this.searchText,
    );
  }

  Map<String, Object> toMap(int page) {
    final params = <String, Object>{'page': page.toString()};
    if (searchText.isNotEmpty) {
      params.putIfAbsent('search_key', () => searchText);
    }
    if (status != null) {
      params.putIfAbsent('status', () => status!.toMap().toString());
    }
    if (dateRange != null) {
      final format = DateFormat('yyyy-MM-dd', 'en');
      params.putIfAbsent('start_date', () => format.format(dateRange!.start));
      params.putIfAbsent('end_date', () => format.format(dateRange!.end));
    }
    return params;
  }

  void clear() {
    status = null;
    dateRange = null;
    searchText = '';
  }

  @override
  String toString() =>
      'ConsultationsFilter(status: $status, dateRange: $dateRange, searchText: $searchText)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConsultationsFilter &&
        other.status == status &&
        other.dateRange == dateRange &&
        other.searchText == searchText;
  }

  @override
  int get hashCode =>
      status.hashCode ^ dateRange.hashCode ^ searchText.hashCode;
}
