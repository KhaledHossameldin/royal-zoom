import 'dart:convert';

import 'package:collection/collection.dart';

class HomeStatistics {
  num? consultationsAll;
  num? consultationsUnderReview;
  num? consultationsScheduled;
  num? consultationsUpcoming;
  num? consultationsPending;
  num? consultationsPendingPayment;
  String? consultationsRequiredAmount;

  HomeStatistics({
    this.consultationsAll,
    this.consultationsUnderReview,
    this.consultationsScheduled,
    this.consultationsUpcoming,
    this.consultationsPending,
    this.consultationsPendingPayment,
    this.consultationsRequiredAmount,
  });

  @override
  String toString() {
    return 'HomeStatistics(consultationsAll: $consultationsAll, consultationsUnderReview: $consultationsUnderReview, consultationsScheduled: $consultationsScheduled, consultationsUpcoming: $consultationsUpcoming, consultationsPending: $consultationsPending, consultationsPendingPayment: $consultationsPendingPayment, consultationsRequiredAmount: $consultationsRequiredAmount)';
  }

  factory HomeStatistics.fromMap(Map<String, dynamic> data) {
    return HomeStatistics(
      consultationsAll: num.tryParse(data['consultations_all'].toString()),
      consultationsUnderReview:
          num.tryParse(data['consultations_under_review'].toString()),
      consultationsScheduled:
          num.tryParse(data['consultations_scheduled'].toString()),
      consultationsUpcoming:
          num.tryParse(data['consultations_upcoming'].toString()),
      consultationsPending:
          num.tryParse(data['consultations_pending'].toString()),
      consultationsPendingPayment:
          num.tryParse(data['consultations_pending_payment'].toString()),
      consultationsRequiredAmount:
          data['consultations_required_amount']?.toString(),
    );
  }

  Map<String, dynamic> toMap() => {
        if (consultationsAll != null) 'consultations_all': consultationsAll,
        if (consultationsUnderReview != null)
          'consultations_under_review': consultationsUnderReview,
        if (consultationsScheduled != null)
          'consultations_scheduled': consultationsScheduled,
        if (consultationsUpcoming != null)
          'consultations_upcoming': consultationsUpcoming,
        if (consultationsPending != null)
          'consultations_pending': consultationsPending,
        if (consultationsPendingPayment != null)
          'consultations_pending_payment': consultationsPendingPayment,
        if (consultationsRequiredAmount != null)
          'consultations_required_amount': consultationsRequiredAmount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HomeStatistics].
  factory HomeStatistics.fromJson(String data) {
    return HomeStatistics.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HomeStatistics] to a JSON string.
  String toJson() => json.encode(toMap());

  HomeStatistics copyWith({
    num? consultationsAll,
    num? consultationsUnderReview,
    num? consultationsScheduled,
    num? consultationsUpcoming,
    num? consultationsPending,
    num? consultationsPendingPayment,
    String? consultationsRequiredAmount,
  }) {
    return HomeStatistics(
      consultationsAll: consultationsAll ?? this.consultationsAll,
      consultationsUnderReview:
          consultationsUnderReview ?? this.consultationsUnderReview,
      consultationsScheduled:
          consultationsScheduled ?? this.consultationsScheduled,
      consultationsUpcoming:
          consultationsUpcoming ?? this.consultationsUpcoming,
      consultationsPending: consultationsPending ?? this.consultationsPending,
      consultationsPendingPayment:
          consultationsPendingPayment ?? this.consultationsPendingPayment,
      consultationsRequiredAmount:
          consultationsRequiredAmount ?? this.consultationsRequiredAmount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! HomeStatistics) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      consultationsAll.hashCode ^
      consultationsUnderReview.hashCode ^
      consultationsScheduled.hashCode ^
      consultationsUpcoming.hashCode ^
      consultationsPending.hashCode ^
      consultationsPendingPayment.hashCode ^
      consultationsRequiredAmount.hashCode;
}
