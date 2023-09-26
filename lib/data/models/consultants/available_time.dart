import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../utilities/extensions.dart';

class ConsultantAvailableTime {
  final int userId;
  final String day;
  final TimeOfDay time;
  final bool isPrimary;

  ConsultantAvailableTime({
    required this.userId,
    required this.day,
    required this.time,
    required this.isPrimary,
  });

  ConsultantAvailableTime copyWith({
    int? userId,
    String? day,
    TimeOfDay? time,
    bool? isPrimary,
  }) {
    return ConsultantAvailableTime(
      userId: userId ?? this.userId,
      day: day ?? this.day,
      time: time ?? this.time,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _ConsultantAvailableTimeContract();
    return {
      contract.userId: userId,
      contract.day: day,
      contract.time: time.toMap(),
      contract.isPrimary: isPrimary,
    };
  }

  factory ConsultantAvailableTime.fromMap(Map<String, dynamic> map) {
    final contract = _ConsultantAvailableTimeContract();
    return ConsultantAvailableTime(
      userId: map[contract.userId]?.toInt() ?? 0,
      day: map[contract.day] ?? '',
      time: (map[contract.time].toString()).time,
      isPrimary: map[contract.isPrimary] != 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsultantAvailableTime.fromJson(String source) =>
      ConsultantAvailableTime.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConsultantAvailableTime(userId: $userId, day: $day, time: $time, isPrimary: $isPrimary)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConsultantAvailableTime &&
        other.userId == userId &&
        other.day == day &&
        other.time == time &&
        other.isPrimary == isPrimary;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ day.hashCode ^ time.hashCode ^ isPrimary.hashCode;
  }
}

class _ConsultantAvailableTimeContract {
  final userId = 'user_id';
  final day = 'day';
  final time = 'time';
  final isPrimary = 'is_primary';
}
