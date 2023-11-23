import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../enums/appointment_status.dart';

class AppointmentFilter {
  DateTimeRange? dateRange;
  AppointmentStatus? status;
  int? consultantId;
  int? consultationId;

  AppointmentFilter({
    this.dateRange,
    this.status,
    this.consultantId,
    this.consultationId,
  });

  Map<String, Object>? toMap() {
    Map<String, Object> params = {};
    if (dateRange != null) {
      final format = DateFormat('yyyy-MM-dd', 'en');
      params.putIfAbsent('date_from', () => format.format(dateRange!.start));
      params.putIfAbsent('date_to', () => format.format(dateRange!.end));
    }
    if (status != null) {
      params.putIfAbsent(
        'appointment_status',
        () => status!.toMap().toString(),
      );
    }
    if (consultantId != null) {
      params.putIfAbsent('consultant_id', () => consultantId.toString());
    }
    if (consultationId != null) {
      params.putIfAbsent('consultation_id', () => consultationId.toString());
    }
    return params.isNotEmpty ? params : null;
  }

  AppointmentFilter copyWith({
    DateTimeRange? dateRange,
    AppointmentStatus? status,
    int? consultantId,
    int? consultationId,
  }) {
    return AppointmentFilter(
      dateRange: dateRange ?? this.dateRange,
      status: status ?? this.status,
      consultantId: consultantId ?? this.consultantId,
      consultationId: consultationId ?? this.consultationId,
    );
  }

  AppointmentFilter clear() => AppointmentFilter();
}
