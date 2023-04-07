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
  }) {
    return Language(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _LanguageContract.id: id,
      _LanguageContract.uuid: uuid,
      _LanguageContract.name: name,
      _LanguageContract.symbol: symbol,
      _LanguageContract.createdAt: createdAt,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      id: map[_LanguageContract.id]?.toInt() ?? 0,
      uuid: map[_LanguageContract.uuid] ?? '',
      name: map[_LanguageContract.name] ?? '',
      symbol: map[_LanguageContract.symbol] ?? '',
      createdAt: map[_LanguageContract.createdAt] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Language.fromJson(String source) =>
      Language.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Language(id: $id, uuid: $uuid, name: $name, symbol: $symbol, createdAt: $createdAt)';
  }

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
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        name.hashCode ^
        symbol.hashCode ^
        createdAt.hashCode;
  }
}

class _LanguageContract {
  static const id = 'id';
  static const uuid = 'uuid';
  static const name = 'name';
  static const symbol = 'symbol';
  static const createdAt = 'created_at';
}
