//The typed string by the user is used as a parameter in api call to OpenWeatherMap
//
//Once the current weather data is fetched for the city(typed string), lat and lon is extracted.
//A second api call is made to get the forecast weather i.e. current, minutely, hourly and daily.
//
//Also checking for potential errors while fetching data, such as unavailability
//internet connection and invalid city names.

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/services/weather.dart';
import 'forecast_screen.dart';
import 'package:weatherapp/services/city_location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'alert_dialogue_box.dart';

class CityLoadingScreen extends StatefulWidget {
  CityLoadingScreen({this.typedData, this.bgImageNo});
  final typedData;
  final bgImageNo;
  @override
  _CityLoadingScreenState createState() => _CityLoadingScreenState();
}

class _CityLoadingScreenState extends State<CityLoadingScreen> {
  String bgNo;
  @override
  void initState() {
    super.initState();
    bgNo = (widget.bgImageNo).toString();
    getCityWeatherData(widget.typedData);
  }

  void getCityWeatherData(var typedString) async {
    CityLocation cityLocation = CityLocation();
    await cityLocation.getLocation(typedString);

    if (cityLocation.status == null) {
      //if cityLocation.status is null, it implies the app has not been able to connect to internet.
      //other wise it would return the status code or the actual data.
      AlertDialogue(context, 'Could not fetch weather for "$typedString"',
              '- Check internet connection', AlertType.error)
          .displayAlert();
    } else {
      //if cityLocation.status is not null then socket connection has been made.
      //if cityLocation.status returned unsuccessful status code, then cityLocation.longitude
      //and cityLocation.longitude will be null.
      if (cityLocation.longitude != null && cityLocation.longitude != null) {
        var weatherData = await WeatherModel()
            .getCityWeather(cityLocation.latitude, cityLocation.longitude);

        if (weatherData == null) {
          //checking if for the second api call data is fetched successfully.
          AlertDialogue(context, 'Could not fetch weather for "$typedString"',
                  '- Check internet connection', AlertType.error)
              .displayAlert();
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return ForecastScreen(
                  locationWeather: weatherData,
                  locationCity: cityLocation.city,
                );
              },
            ),
          );
        }
      } else {
        AlertDialogue(context, 'Could not fetch weather for "$typedString"',
                '- Check spelling of "$typedString"', AlertType.error)
            .displayAlert();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x00FFFFFF),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg$bgNo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        )),
      ),
    );
  }
}
// Navigator.of(context).pushReplacement(MaterialPageRoute(
//   builder: (context) {
//     return ForecastScreen(
//       locationWeather: weatherData,
//       locationCity: cityLocation.city,
//     );
//   },
// ),);
