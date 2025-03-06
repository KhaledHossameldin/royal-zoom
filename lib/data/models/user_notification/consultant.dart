import 'dart:convert';

import 'package:collection/collection.dart';

class Consultant {
  num? acceptNotificationsViaSms;
  num? acceptNotificationsViaEmail;
  num? acceptNotificationsViaWhatsapp;

  Consultant({
    this.acceptNotificationsViaSms,
    this.acceptNotificationsViaEmail,
    this.acceptNotificationsViaWhatsapp,
  });

  @override
  String toString() {
    return 'Consultant(acceptNotificationsViaSms: $acceptNotificationsViaSms, acceptNotificationsViaEmail: $acceptNotificationsViaEmail, acceptNotificationsViaWhatsapp: $acceptNotificationsViaWhatsapp)';
  }

  factory Consultant.fromMap(Map<String, dynamic> data) => Consultant(
        acceptNotificationsViaSms:
            num.tryParse(data['accept_notifications_via_sms'].toString()),
        acceptNotificationsViaEmail:
            num.tryParse(data['accept_notifications_via_email'].toString()),
        acceptNotificationsViaWhatsapp:
            num.tryParse(data['accept_notifications_via_whatsapp'].toString()),
      );

  Map<String, dynamic> toMap() => {
        if (acceptNotificationsViaSms != null)
          'accept_notifications_via_sms': acceptNotificationsViaSms,
        if (acceptNotificationsViaEmail != null)
          'accept_notifications_via_email': acceptNotificationsViaEmail,
        if (acceptNotificationsViaWhatsapp != null)
          'accept_notifications_via_whatsapp': acceptNotificationsViaWhatsapp,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Consultant].
  factory Consultant.fromJson(String data) {
    return Consultant.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Consultant] to a JSON string.
  String toJson() => json.encode(toMap());

  Consultant copyWith({
    num? acceptNotificationsViaSms,
    num? acceptNotificationsViaEmail,
    num? acceptNotificationsViaWhatsapp,
  }) {
    return Consultant(
      acceptNotificationsViaSms:
          acceptNotificationsViaSms ?? this.acceptNotificationsViaSms,
      acceptNotificationsViaEmail:
          acceptNotificationsViaEmail ?? this.acceptNotificationsViaEmail,
      acceptNotificationsViaWhatsapp:
          acceptNotificationsViaWhatsapp ?? this.acceptNotificationsViaWhatsapp,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Consultant) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      acceptNotificationsViaSms.hashCode ^
      acceptNotificationsViaEmail.hashCode ^
      acceptNotificationsViaWhatsapp.hashCode;
}
