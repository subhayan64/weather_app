//class to implement asynchronous functions that take locations from different sources
//(geolocator and current weather api call) and returns the weather data.

import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/services/networking.dart';

const apiKey = 'YOUR-KEY-HERE';
const openWeatherMapURLOneCall =
    'https://api.openweathermap.org/data/2.5/onecall';
const openWeatherMapURLCurrent =
    'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  var weatherData;
  double lat;
  double lon;
  Future<void> getCurrentLocationWeather() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();
      lat = location.latitude;
      lon = location.longitude;
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURLOneCall?lat=$lat&lon=$lon&%20&appid=$apiKey&units=metric');
      weatherData = await networkHelper.getData();
    } catch (e) {
      print('getCurrentLocationWeather: $e');
    }
  }

  Future<dynamic> getCityWeather(double latitude, double longitude) async {
    try {
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURLOneCall?lat=$latitude&lon=$longitude&%20&appid=$apiKey&units=metric');
      weatherData = await networkHelper.getData();

      return weatherData;
    } catch (e) {
      print('getCityWeather: $e');
    }
  }
}
