//Position of the user's device is determined using the GeoLocator package.
//
//Once the location(latitude, longitude) is determined, an API call is made to
//OpenWeatherMap to get the weather forecast data, name of city and country code.
//
//Also checking for potential errors while fetching data, such as unavailability
//internet connection and gps location of device.

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weatherapp/screens/alert_dialogue_box.dart';
import 'package:weatherapp/services/weather.dart';
import 'forecast_screen.dart';
import 'package:weatherapp/services/city_location.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({this.bgImageNo});
  final bgImageNo;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String bgNo;
  @override
  void initState() {
    super.initState();
    bgNo = (widget.bgImageNo).toString();
    getLocationWeatherData();

  }
  void getLocationWeatherData() async {
    WeatherModel weatherModel = WeatherModel();
    await weatherModel.getCurrentLocationWeather();

    if(weatherModel.weatherData == null){
      //weatherData is null when the app has not been able to connect to internet.
      //if weatherData is not null, that means the app has been able to connect to internet,
      //and is either returning the response status code or the actual weather data.
      AlertDialogue(context, 'Couldn\'t fetch weather!', '- Check internet connection', AlertType.error).displayAlert();

    }else{
      if(weatherModel.lat == null && weatherModel.lon == null){
        //weatherModel.lat,weatherModel.lon are null if geolocator has not sent back coordinates.
        AlertDialogue(context, 'Couldn\'t fetch weather!', '- Check GPS location', AlertType.error).displayAlert();
      }
      else{
        var city = await CityLocation().getCity(weatherModel.lat,weatherModel.lon);
        //checking if in the second api call for current weather data->city and country is fetched back.
        if(city == 'Unknown'){
          AlertDialogue(context, 'Couldn\'t fetch weather!', '- Check internet connection', AlertType.error).displayAlert();
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return ForecastScreen(
                //passing the weather data and address of the location to the ForecastScreen.
                locationWeather: weatherModel.weatherData,
                locationCity: city,
              );
            },
          ),);
        }
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
            //displaying same background image as the home screen.
            image: AssetImage('images/bg$bgNo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          //while the data is being fetched, implementing SpinKitDoubleBounce animation.
            child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        )),
      ),
    );
  }
}
