import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../enums/invoice_type.dart';
import '../../../enums/sort.dart';

class InvoiceFilter {
  InvoiceType type;
  String searchText;
  DateTimeRange? dateRange;
  Sort? sort;

  InvoiceFilter({
    this.type = InvoiceType.walletCharge,
    this.searchText = '',
    this.dateRange,
    this.sort,
  });

  InvoiceFilter copyWith({
    InvoiceType? type,
    String? searchText,
    DateTimeRange? dateRange,
    Sort? sort,
  }) {
    return InvoiceFilter(
      type: type ?? this.type,
      searchText: searchText ?? this.searchText,
      dateRange: dateRange ?? this.dateRange,
      sort: sort ?? this.sort,
    );
  }

  Map<String, Object> toMap() {
    final params = <String, Object>{'invoiceable_type': type.text};
    if (sort != null) {
      params.putIfAbsent('sort_type', () => sort!.text);
    }
    if (dateRange != null) {
      final format = DateFormat('yyyy-MM-dd', 'en');
      params.putIfAbsent('start_date', () => format.format(dateRange!.start));
      params.putIfAbsent('end_date', () => format.format(dateRange!.end));
    }
    if (searchText.isNotEmpty) {
      params.putIfAbsent('search_key', () => searchText);
    }
    return params;
  }

  @override
  String toString() {
    return 'InvoiceFilter(type: $type, searchText: $searchText, dateRange: $dateRange, sort: $sort)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceFilter &&
        other.type == type &&
        other.searchText == searchText &&
        other.dateRange == dateRange &&
        other.sort == sort;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        searchText.hashCode ^
        dateRange.hashCode ^
        sort.hashCode;
  }
}
