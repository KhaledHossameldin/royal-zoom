import 'dart:convert';

import 'package:collection/collection.dart';

class Attachment {
  num? id;
  String? file;

  Attachment({this.id, this.file});

  @override
  String toString() => 'Attachment(id: $id, file: $file)';

  factory Attachment.fromMap(Map<String, dynamic> data) => Attachment(
        id: num.tryParse(data['id'].toString()),
        file: data['file']?.toString(),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (file != null) 'file': file,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Attachment].
  factory Attachment.fromJson(String data) {
    return Attachment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Attachment] to a JSON string.
  String toJson() => json.encode(toMap());

  Attachment copyWith({
    num? id,
    String? file,
  }) {
    return Attachment(
      id: id ?? this.id,
      file: file ?? this.file,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Attachment) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ file.hashCode;
}
