import 'dart:convert';

import '../../../utilities/extensions.dart';

class Currency {
  int id;
  String uuid;
  String name;
  String symbol;
  bool isActive;
  DateTime createdAt;

  Currency({
    required this.id,
    required this.uuid,
    required this.name,
    required this.symbol,
    required this.isActive,
    required this.createdAt,
  });

  Currency copyWith({
    int? id,
    String? uuid,
    String? name,
    String? symbol,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Currency(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _CurrencyContract.id: id,
      _CurrencyContract.uuid: uuid,
      _CurrencyContract.name: name,
      _CurrencyContract.symbol: symbol,
      _CurrencyContract.isActive: isActive.toInt,
      _CurrencyContract.createdAt: createdAt.toIso8601String(),
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map[_CurrencyContract.id]?.toInt() ?? 0,
      uuid: map[_CurrencyContract.uuid] ?? '',
      name: map[_CurrencyContract.name] ?? '',
      symbol: map[_CurrencyContract.symbol] ?? '',
      isActive: map[_CurrencyContract.isActive] != 0,
      createdAt: DateTime.parse(map[_CurrencyContract.createdAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Currency(id: $id, uuid: $uuid, name: $name, symbol: $symbol, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Currency &&
        other.id == id &&
        other.uuid == uuid &&
        other.name == name &&
        other.symbol == symbol &&
        other.isActive == isActive &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        name.hashCode ^
        symbol.hashCode ^
        isActive.hashCode ^
        createdAt.hashCode;
  }
}

class _CurrencyContract {
  static const id = 'id';
  static const uuid = 'uuid';
  static const name = 'name';
  static const symbol = 'symbol';
  static const isActive = 'is_active';
  static const createdAt = 'created_at';
}
