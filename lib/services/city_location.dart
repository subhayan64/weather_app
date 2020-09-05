import 'networking.dart';
import 'weather.dart';

class CityLocation {
  double latitude;
  double longitude;
  String city;
  var status;

  Future<void> getLocation(String queryCity) async {
    // pass city => get location.
    try {
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURLCurrent?q=$queryCity&appid=$apiKey&units=metric');
      var locationData = await networkHelper.getData();

      status = locationData;
      latitude = locationData['coord']['lat'];
      longitude = locationData['coord']['lon'];
      city = '${locationData['name']}, ${locationData['sys']['country']}';
    } catch (e) {
      print('getLocation: ${e.runtimeType}');
    }
  }

  Future<String> getCity(double lat, double lon) async {
    // pass location => get city, country code.
    try {
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURLCurrent?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
      var cityData = await networkHelper.getData();
      if ((cityData['name'] == null || cityData['name'] == '') &&
          cityData['sys']['country'] == null) {
        return 'Location: ${cityData['coord']['lat']}, ${cityData['coord']['lon']}';
      }
      return '${cityData['name']}, ${cityData['sys']['country']}';
    } catch (e) {
      print('getCity: $e');
      return 'Unknown';
    }
  }
}
