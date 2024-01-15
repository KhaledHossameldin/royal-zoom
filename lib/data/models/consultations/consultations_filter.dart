import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../enums/consultant_response_type.dart';
import '../../enums/consultation_status.dart';
import '../consultants/consultant.dart';

class ConsultationsFilter {
  DateTimeRange? dateRange;
  String searchText;
  int? mainMajorId;
  int? subMajorId;
  List<Consultant>? consultants = [];
  List<ConsultantResponseType>? responseTypes = [];
  List<ConsultationStatus>? status = [];
  bool? isPaid;

  ConsultationsFilter({
    this.status,
    this.dateRange,
    this.searchText = '',
    this.mainMajorId,
    this.subMajorId,
    this.consultants,
    this.responseTypes,
    this.isPaid,
  });

  ConsultationsFilter copyWith({
    List<ConsultationStatus>? status,
    DateTimeRange? dateRange,
    String? searchText,
    int? mainMajorId,
    int? subMajorId,
    List<Consultant>? consultants,
    List<ConsultantResponseType>? responseTypes,
    bool? isPaid,
  }) {
    return ConsultationsFilter(
      status: status ?? this.status,
      dateRange: dateRange ?? this.dateRange,
      searchText: searchText ?? this.searchText,
      mainMajorId: mainMajorId ?? this.mainMajorId,
      subMajorId: subMajorId ?? this.subMajorId,
      consultants: consultants ?? this.consultants,
      responseTypes: responseTypes ?? this.responseTypes,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  Map<String, Object> toMap(int page) {
    final params = <String, Object>{'page': page.toString()};
    if (searchText.isNotEmpty) {
      params.putIfAbsent('search_key', () => searchText);
    }
    if (status != null && status!.isNotEmpty) {
      params.putIfAbsent(
          'status[]', () => status!.map((e) => e.toMap().toString()).toList());
    }
    if (dateRange != null) {
      final format = DateFormat('yyyy-MM-dd', 'en');
      params.putIfAbsent('start_date', () => format.format(dateRange!.start));
      params.putIfAbsent('end_date', () => format.format(dateRange!.end));
    }
    if (consultants != null && consultants!.isNotEmpty) {
      params.putIfAbsent(
        'consultants[]',
        () => consultants!.map((e) => e.id.toString()).toList(),
      );
    }
    if (responseTypes != null && responseTypes!.isNotEmpty) {
      params.putIfAbsent(
        'consultant_response_types[]',
        () => responseTypes!.map((e) => e.toMap().toString()).toList(),
      );
    }
    return params;
  }

  void clear() {
    status = null;
    dateRange = null;
    searchText = '';
    mainMajorId = null;
    subMajorId = null;
    consultants = [];
    responseTypes = [];
    isPaid = null;
  }

  @override
  String toString() =>
      'ConsultationsFilter(status: $status, dateRange: $dateRange, searchText: $searchText, mainMajorId: $mainMajorId, subMajorId: $subMajorId, consultants: $consultants, responseTypes: $responseTypes, isPaid: $isPaid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConsultationsFilter &&
        other.status == status &&
        other.dateRange == dateRange &&
        other.searchText == searchText &&
        other.mainMajorId == mainMajorId &&
        other.subMajorId == subMajorId &&
        other.consultants == consultants &&
        other.responseTypes == responseTypes &&
        other.isPaid == isPaid;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      dateRange.hashCode ^
      searchText.hashCode ^
      mainMajorId.hashCode ^
      subMajorId.hashCode ^
      consultants.hashCode ^
      responseTypes.hashCode ^
      isPaid.hashCode;
}
