import 'network_services.dart';
import 'shared_preferences_handler.dart';

class Repositroy {
  static Repositroy instance = Repositroy._();
  Repositroy._();

  final _network = NetworkServices();
  final _sharedPreferences = SharedPreferencesHandler();

  Future<void> setLocalePreferences(String languageCode) async {
    await _sharedPreferences.setLocale(languageCode);
  }

  Future<String> getLocalePreferences() async {
    return await _sharedPreferences.getLocale();
  }

  Future<bool> getNotificationsPreferences() async {
    return await _sharedPreferences.getNotifications();
  }

  Future<void> setNotificationsPreferences() async {
    await _sharedPreferences.setNotifications();
  }

  Future<bool> getLocationPreferences() async {
    return await _sharedPreferences.getLocation();
  }

  Future<void> setLocationPreferences() async {
    await _sharedPreferences.setLocation();
  }
}
