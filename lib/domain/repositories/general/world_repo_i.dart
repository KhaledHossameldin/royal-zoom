import '../../../core/results/result.dart';
import '../../../data/models/authentication/city.dart';
import '../../../data/models/authentication/country.dart';
import '../../../data/models/authentication/currency.dart';
import '../../../data/models/authentication/language.dart';
import '../../../data/models/authentication/timezone.dart';

abstract class IWorldRepo {
  Future<Result<List<Currency>>> getCurrencies();
  Future<Result<List<Timezone>>> getTimeZones();
  Future<Result<List<Language>>> getLanguages();
  Future<Result<List<City>>> getCities();
  Future<Result<List<Country>>> getCountries();
}
