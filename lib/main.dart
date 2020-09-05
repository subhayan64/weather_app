///Weather is a weather forecasting app developed using flutter.
///
///Using OpenWeatherMap's [https://openweathermap.org/] API to fetch the
///weather forecast for a coordinate or a user entered city.
///
///Flutter app developed by Subhayan Mukhopadhyay [https://github.com/subhayan64]

import 'package:flutter/material.dart';
import 'screens/city_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/get_city_loading_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => CityScreen(),
        '/loadingScreen': (context) => LoadingScreen(),
        '/cityLoadingScreen': (context) => CityLoadingScreen(),
      },
    );
  }
}
