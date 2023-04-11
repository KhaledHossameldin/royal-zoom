import 'dart:convert';

class Language {
  int id;
  String uuid;
  String name;
  String symbol;
  String createdAt;

  Language({
    required this.id,
    required this.uuid,
    required this.name,
    required this.symbol,
    required this.createdAt,
  });

  Language copyWith({
    int? id,
    String? uuid,
    String? name,
    String? symbol,
    String? createdAt,
  }) =>
      Language(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toMap() {
    final contract = _LanguageContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.name: name,
      contract.symbol: symbol,
      contract.createdAt: createdAt,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    final contract = _LanguageContract();

    return Language(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      name: map[contract.name] ?? '',
      symbol: map[contract.symbol] ?? '',
      createdAt: map[contract.createdAt] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Language.fromJson(String source) =>
      Language.fromMap(json.decode(source));

  @override
  String toString() =>
      'Language(id: $id, uuid: $uuid, name: $name, symbol: $symbol, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Language &&
        other.id == id &&
        other.uuid == uuid &&
        other.name == name &&
        other.symbol == symbol &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      name.hashCode ^
      symbol.hashCode ^
      createdAt.hashCode;
}

class _LanguageContract {
  final id = 'id';
  final uuid = 'uuid';
  final name = 'name';
  final symbol = 'symbol';
  final createdAt = 'created_at';
}
