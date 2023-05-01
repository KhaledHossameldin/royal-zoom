import '../../../utilities/extensions.dart';

class ConsultantsFilter {
  final int? majorId;
  final int? countryId;
  final int? cityId;
  final String? searchKey;

  ConsultantsFilter({
    this.majorId,
    this.countryId,
    this.cityId,
    this.searchKey,
  });

  Map<String, String>? toMap() {
    Map<String, String> map = {};
    if (majorId != null) {
      map.putIfAbsent('major_id', () => majorId.toString());
    }
    if (countryId != null) {
      map.putIfAbsent('country_id', () => countryId.toString());
    }
    if (cityId != null) {
      map.putIfAbsent('city_id', () => cityId.toString());
    }
    if (searchKey != null) {
      map.putIfAbsent('search_key', () => searchKey!);
    }
    if (map.isEmpty) {
      return null;
    }
    return map;
  }

  ConsultantsFilter copyWith({
    int? majorId,
    int? countryId,
    int? cityId,
    String? searchKey,
  }) {
    return ConsultantsFilter(
      majorId: majorId ?? this.majorId,
      countryId: countryId ?? this.countryId,
      cityId: cityId ?? this.cityId,
      searchKey: searchKey.isNullOrEmpty ? null : searchKey,
    );
  }

  ConsultantsFilter clear() => ConsultantsFilter();
}
