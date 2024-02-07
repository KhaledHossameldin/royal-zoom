import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/network/endpoints/network.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../models/authentication/city.dart';
import '../../../models/authentication/country.dart';
import '../../../models/authentication/currency.dart';
import '../../../models/authentication/language.dart';
import '../../../models/authentication/timezone.dart';

class WorldRemoteDataSource {
  Future<Result<List<Currency>>> getCurrencies() async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((currency) => Currency.fromJson(currency)).toList(),
      method: HttpMethod.GET,
      url: Network.currencies,
    );
  }

  Future<Result<List<Timezone>>> getTimeZones() async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((timezone) => Timezone.fromJson(timezone)).toList(),
      method: HttpMethod.GET,
      url: Network.timezones,
    );
  }

  Future<Result<List<Language>>> getLanguages() async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((language) => Language.fromJson(language)).toList(),
      method: HttpMethod.GET,
      url: Network.languages,
    );
  }

  Future<Result<List<City>>> getCities() async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((city) => City.fromJson(city)).toList(),
      method: HttpMethod.GET,
      url: Network.cities,
    );
  }

  Future<Result<List<Country>>> getCountries() async {
    return await RemoteDataSource.request(
      converterList: (list) =>
          list!.map((country) => Country.fromJson(country)).toList(),
      method: HttpMethod.GET,
      url: Network.countries,
    );
  }
}
