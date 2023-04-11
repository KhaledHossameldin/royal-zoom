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
  }) =>
      Currency(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toMap() {
    final contract = _CurrencyContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.name: name,
      contract.symbol: symbol,
      contract.isActive: isActive.toInt,
      contract.createdAt: createdAt.toIso8601String(),
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    final contract = _CurrencyContract();

    return Currency(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      name: map[contract.name] ?? '',
      symbol: map[contract.symbol] ?? '',
      isActive: map[contract.isActive] != 0,
      createdAt: DateTime.parse(map[contract.createdAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));

  @override
  String toString() =>
      'Currency(id: $id, uuid: $uuid, name: $name, symbol: $symbol, isActive: $isActive, createdAt: $createdAt)';

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
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      name.hashCode ^
      symbol.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode;
}

class _CurrencyContract {
  final id = 'id';
  final uuid = 'uuid';
  final name = 'name';
  final symbol = 'symbol';
  final isActive = 'is_active';
  final createdAt = 'created_at';
}
