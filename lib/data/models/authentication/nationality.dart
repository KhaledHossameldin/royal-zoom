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
  }) =>
      Nationality(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        symbol: symbol ?? this.symbol,
        dialCode: dialCode ?? this.dialCode,
        channel: channel ?? this.channel,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toMap() {
    final contract = _NationalityContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.symbol: symbol,
      contract.dialCode: dialCode,
      contract.channel: channel,
      contract.name: name,
      contract.createdAt: createdAt.toIso8601String(),
    };
  }

  factory Nationality.fromMap(Map<String, dynamic> map) {
    final contract = _NationalityContract();

    return Nationality(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      symbol: map[contract.symbol] ?? '',
      dialCode: map[contract.dialCode] ?? '',
      channel: map[contract.channel]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
      createdAt: DateTime.parse(map[contract.createdAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Nationality.fromJson(String source) =>
      Nationality.fromMap(json.decode(source));

  @override
  String toString() =>
      'Nationality(id: $id, uuid: $uuid, symbol: $symbol, dialCode: $dialCode, channel: $channel, name: $name, createdAt: $createdAt)';

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
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      symbol.hashCode ^
      dialCode.hashCode ^
      channel.hashCode ^
      name.hashCode ^
      createdAt.hashCode;
}

class _NationalityContract {
  final id = 'id';
  final uuid = 'uuid';
  final symbol = 'symbol';
  final dialCode = 'dial_code';
  final channel = 'channel';
  final name = 'name';
  final createdAt = 'created_at';
}
