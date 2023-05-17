import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../utilities/countries.dart';

class LocationServices {
  static LocationServices instance = LocationServices._();
  LocationServices._();

  Placemark? _current;

  Placemark get current => _current ?? Placemark(isoCountryCode: 'SA');
  Country get country =>
      countries.firstWhere((element) => element.code == current.isoCountryCode);

  Future<void> setCurrent(bool isFromMain) async {
    if (!isFromMain) {
      await Geolocator.requestPermission();
    }
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }
    final isService = await Geolocator.isLocationServiceEnabled();
    if (!isService) {
      return;
    }
    final position = await Geolocator.getCurrentPosition();
    final placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    _current = placemark[0];
  }
}
