import 'dart:convert';

class HomeStatistics {
  final int all;
  final int underReview;
  final int scheduled;
  final int upcoming;
  final int pending;
  final int pendingPayment;
  final num requiredAmount;

  HomeStatistics({
    required this.all,
    required this.underReview,
    required this.scheduled,
    required this.upcoming,
    required this.pending,
    required this.pendingPayment,
    required this.requiredAmount,
  });

  HomeStatistics copyWith({
    int? all,
    int? underReview,
    int? scheduled,
    int? upcoming,
    int? pending,
    int? pendingPayment,
    num? requiredAmount,
  }) =>
      HomeStatistics(
        all: all ?? this.all,
        underReview: underReview ?? this.underReview,
        scheduled: scheduled ?? this.scheduled,
        upcoming: upcoming ?? this.upcoming,
        pending: pending ?? this.pending,
        pendingPayment: pendingPayment ?? this.pendingPayment,
        requiredAmount: requiredAmount ?? this.requiredAmount,
      );

  Map<String, dynamic> toMap() {
    final contract = _HomeStatisticsContract();
    return {
      contract.all: all,
      contract.underReview: underReview,
      contract.scheduled: scheduled,
      contract.upcoming: upcoming,
      contract.pending: pending,
      contract.pendingPayment: pendingPayment,
      contract.requiredAmount: requiredAmount,
    };
  }

  factory HomeStatistics.fromMap(Map<String, dynamic> map) {
    final contract = _HomeStatisticsContract();
    return HomeStatistics(
      all: map[contract.all]?.toInt() ?? 0,
      underReview: map[contract.underReview]?.toInt() ?? 0,
      scheduled: map[contract.scheduled]?.toInt() ?? 0,
      upcoming: map[contract.upcoming]?.toInt() ?? 0,
      pending: map[contract.pending]?.toInt() ?? 0,
      pendingPayment: map[contract.pendingPayment]?.toInt() ?? 0,
      requiredAmount: map[contract.requiredAmount] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeStatistics.fromJson(String source) =>
      HomeStatistics.fromMap(json.decode(source));

  @override
  String toString() =>
      'HomeStatistics(all: $all, underReview: $underReview, scheduled: $scheduled, upcoming: $upcoming, pending: $pending, pendingPayment: $pendingPayment, requiredAmount: $requiredAmount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeStatistics &&
        other.all == all &&
        other.underReview == underReview &&
        other.scheduled == scheduled &&
        other.upcoming == upcoming &&
        other.pending == pending &&
        other.pendingPayment == pendingPayment &&
        other.requiredAmount == requiredAmount;
  }

  @override
  int get hashCode =>
      all.hashCode ^
      underReview.hashCode ^
      scheduled.hashCode ^
      upcoming.hashCode ^
      pending.hashCode ^
      pendingPayment.hashCode ^
      requiredAmount.hashCode;
}

class _HomeStatisticsContract {
  final all = 'consultations_all';
  final underReview = 'consultations_under_review';
  final scheduled = 'consultations_scheduled';
  final upcoming = 'consultations_upcoming';
  final pending = 'consultations_pending';
  final pendingPayment = 'consultations_pending_payment';
  final requiredAmount = 'consultations_required_amount';
}
