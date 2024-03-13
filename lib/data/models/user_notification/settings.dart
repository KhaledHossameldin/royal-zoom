import 'dart:convert';

import 'package:collection/collection.dart';

import 'consultant.dart';
import 'user.dart';

class Settings {
  User? user;
  Consultant? consultant;

  Settings({this.user, this.consultant});

  @override
  String toString() => 'Settings(user: $user, consultant: $consultant)';

  factory Settings.fromMap(Map<String, dynamic> data) => Settings(
        user: data['user'] == null
            ? null
            : User.fromMap(Map<String, dynamic>.from(data['user'])),
        consultant: data['consultant'] == null
            ? null
            : Consultant.fromMap(Map<String, dynamic>.from(data['consultant'])),
      );

  Map<String, dynamic> toMap() => {
        if (user != null) 'user': user?.toMap(),
        if (consultant != null) 'consultant': consultant?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Settings].
  factory Settings.fromJson(String data) {
    return Settings.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Settings] to a JSON string.
  String toJson() => json.encode(toMap());

  Settings copyWith({
    User? user,
    Consultant? consultant,
  }) {
    return Settings(
      user: user ?? this.user,
      consultant: consultant ?? this.consultant,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Settings) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => user.hashCode ^ consultant.hashCode;
}
