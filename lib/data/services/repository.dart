import 'network_services.dart';
import 'shared_preferences_handler.dart';

class Repositroy {
  static Repositroy instance = Repositroy._();
  final _network = NetworkServices();
  final _sharedPreferences = SharedPreferencesHandler();

  Future<void> setLocale(String languageCode) async {
    await _sharedPreferences.setLocale(languageCode);
  }

  Future<String> getLocale() async {
    return await _sharedPreferences.getLocale();
  }

  Repositroy._();
}
