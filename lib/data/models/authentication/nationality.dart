import 'dart:convert';

class Nationality {
  int id;
  String uuid;
  String symbol;
  String dialCode;
  int channel;
  String name;
  DateTime createdAt;

  Nationality({
    required this.id,
    required this.uuid,
    required this.symbol,
    required this.dialCode,
    required this.channel,
    required this.name,
    required this.createdAt,
  });

  Nationality copyWith({
    int? id,
    String? uuid,
    String? symbol,
    String? dialCode,
    int? channel,
    String? name,
    DateTime? createdAt,
  }) {
    return Nationality(
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
      _NationalityContract.id: id,
      _NationalityContract.uuid: uuid,
      _NationalityContract.symbol: symbol,
      _NationalityContract.dialCode: dialCode,
      _NationalityContract.channel: channel,
      _NationalityContract.name: name,
      _NationalityContract.createdAt: createdAt.toIso8601String(),
    };
  }

  factory Nationality.fromMap(Map<String, dynamic> map) {
    return Nationality(
      id: map[_NationalityContract.id]?.toInt() ?? 0,
      uuid: map[_NationalityContract.uuid] ?? '',
      symbol: map[_NationalityContract.symbol] ?? '',
      dialCode: map[_NationalityContract.dialCode] ?? '',
      channel: map[_NationalityContract.channel]?.toInt() ?? 0,
      name: map[_NationalityContract.name] ?? '',
      createdAt: DateTime.parse(map[_NationalityContract.createdAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Nationality.fromJson(String source) =>
      Nationality.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Nationality(id: $id, uuid: $uuid, symbol: $symbol, dialCode: $dialCode, channel: $channel, name: $name, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Nationality &&
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

class _NationalityContract {
  static const id = 'id';
  static const uuid = 'uuid';
  static const symbol = 'symbol';
  static const dialCode = 'dial_code';
  static const channel = 'channel';
  static const name = 'name';
  static const createdAt = 'created_at';
}
