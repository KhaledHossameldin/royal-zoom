import 'dart:convert';

import 'package:flutter/material.dart';

class Country {
  int id;
  String uuid;
  String symbol;
  String dialCode;
  int channel;
  String name;
  DateTime createdAt;

  Country({
    required this.id,
    required this.uuid,
    required this.symbol,
    required this.dialCode,
    required this.channel,
    required this.name,
    required this.createdAt,
  });

  Country copyWith({
    int? id,
    String? uuid,
    String? symbol,
    String? dialCode,
    int? channel,
    String? name,
    DateTime? createdAt,
  }) {
    return Country(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      symbol: symbol ?? this.symbol,
      dialCode: dialCode ?? this.dialCode,
      channel: channel ?? this.channel,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _CountryContract.id: id,
      _CountryContract.uuid: uuid,
      _CountryContract.symbol: symbol,
      _CountryContract.dialCode: dialCode,
      _CountryContract.channel: channel,
      _CountryContract.name: name,
      _CountryContract.createdAt: createdAt.toIso8601String(),
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      id: map[_CountryContract.id]?.toInt() ?? 0,
      uuid: map[_CountryContract.uuid] ?? '',
      symbol: map[Icons.euro_symbol] ?? '',
      dialCode: map[_CountryContract.dialCode] ?? '',
      channel: map[_CountryContract.channel]?.toInt() ?? 0,
      name: map[_CountryContract.name] ?? '',
      createdAt: DateTime.parse(map[_CountryContract.createdAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Country(id: $id, uuid: $uuid, symbol: $symbol, dialCode: $dialCode, channel: $channel, name: $name, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.id == id &&
        other.uuid == uuid &&
        other.symbol == symbol &&
        other.dialCode == dialCode &&
        other.channel == channel &&
        other.name == name &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        symbol.hashCode ^
        dialCode.hashCode ^
        channel.hashCode ^
        name.hashCode ^
        createdAt.hashCode;
  }
}

class _CountryContract {
  static const id = 'id';
  static const uuid = 'uuid';
  static const symbol = 'symbol';
  static const dialCode = 'dial_code';
  static const channel = 'channel';
  static const name = 'name';
  static const createdAt = 'created_at';
}
