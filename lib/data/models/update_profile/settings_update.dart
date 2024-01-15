import '../../../utilities/extensions.dart';
import '../authentication/user_data.dart';

class SettingsUpdate {
  int? languageId;
  int? currencyId;
  int? timezoneId;
  bool? activateMultiFactorAuthentication;

  SettingsUpdate({
    this.languageId,
    this.currencyId,
    this.timezoneId,
    this.activateMultiFactorAuthentication,
  });

  SettingsUpdate.fromUserData(UserData userData) {
    languageId = userData.languageId;
    currencyId = userData.currencyId;
    timezoneId = userData.countryTimeZoneId;
    activateMultiFactorAuthentication =
        userData.settings?.activateMultiFactorAuthentication;
  }

  Map<String, Object> toMap() {
    final contract = _SettingsUpdateContract();
    final Map<String, Object> map = {};
    if (languageId != null) {
      map.putIfAbsent(contract.languageId, () => languageId!.toString());
    }
    if (currencyId != null) {
      map.putIfAbsent(contract.currencyId, () => currencyId!.toString());
    }
    if (timezoneId != null) {
      map.putIfAbsent(contract.timezoneId, () => timezoneId!.toString());
    }
    if (activateMultiFactorAuthentication != null) {
      map.putIfAbsent(contract.activateMultiFactorAuthentication,
          () => activateMultiFactorAuthentication!.toInt.toString());
    }
    return map;
  }

  @override
  String toString() {
    return 'SettingsUpdate(languageId: $languageId, currencyId: $currencyId, timezoneId: $timezoneId, activateMultiFactorAuthentication: $activateMultiFactorAuthentication)';
  }

  SettingsUpdate copyWith({
    int? languageId,
    int? currencyId,
    int? timezoneId,
    bool? activateMultiFactorAuthentication,
  }) {
    return SettingsUpdate(
      languageId: languageId ?? this.languageId,
      currencyId: currencyId ?? this.currencyId,
      timezoneId: timezoneId ?? this.timezoneId,
      activateMultiFactorAuthentication: activateMultiFactorAuthentication ??
          this.activateMultiFactorAuthentication,
    );
  }
}

class _SettingsUpdateContract {
  final languageId = 'language_id';
  final currencyId = 'currency_id';
  final timezoneId = 'country_time_zone_id';
  final activateMultiFactorAuthentication =
      'activate_multi_factor_authentication';
}
