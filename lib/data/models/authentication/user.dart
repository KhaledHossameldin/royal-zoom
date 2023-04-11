import 'dart:convert';

import 'user_data.dart';

class User {
  final UserData data;
  final String token;

  User({required this.data, required this.token});

  User copyWith({UserData? data, String? token}) =>
      User(data: data ?? this.data, token: token ?? this.token);

  Map<String, dynamic> toMap() {
    final contract = _UserContract();

    return {
      contract.data: data.toMap(),
      contract.token: token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    final contract = _UserContract();

    return User(
      data: UserData.fromMap(map[contract.data]),
      token: map[contract.token] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(data: $data, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.data == data && other.token == token;
  }

  @override
  int get hashCode => data.hashCode ^ token.hashCode;
}

class _UserContract {
  final data = 'data';
  final token = 'token';
}
