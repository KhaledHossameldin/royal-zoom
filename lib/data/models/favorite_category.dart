import 'dart:convert';

class FavoriteCategory {
  final int id;
  final String name;
  final String type;

  FavoriteCategory({
    required this.id,
    required this.name,
    required this.type,
  });

  FavoriteCategory copyWith({
    int? id,
    String? name,
    String? type,
  }) {
    return FavoriteCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _FavoriteCategoryContract();
    return {
      contract.id: id,
      contract.name: name,
      contract.type: type,
    };
  }

  factory FavoriteCategory.fromMap(Map<String, dynamic> map) {
    final contract = _FavoriteCategoryContract();
    return FavoriteCategory(
      id: map[contract.id]?.toInt() ?? 0,
      name: map[contract.name] ?? '',
      type: map[contract.type] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteCategory.fromJson(String source) =>
      FavoriteCategory.fromMap(json.decode(source));

  @override
  String toString() => 'FavoriteCategory(id: $id, name: $name, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteCategory &&
        other.id == id &&
        other.name == name &&
        other.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ type.hashCode;
}

class _FavoriteCategoryContract {
  final id = 'id';
  final name = 'name';
  final type = 'type';
}
