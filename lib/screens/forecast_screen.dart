///Forecast screen
///To display the received data from the api call in two different formats,
///i.e. 'daily' and 'hourly' weather forecast.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

//for capitalizing the first letter of string, all the letters and first letter of every word in the string.
extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.inCaps).join(" ");
}

class ForecastScreen extends StatefulWidget {
  ForecastScreen({this.locationWeather, this.locationCity});
  final locationWeather;
  final locationCity;
  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  int _index = 0;

  //storing each selected weather data into separate variables/property
  String dayUI;
  String dateUI;
  int temperature;
  int minTemp;
  int maxTemp;
  String windSpeed;
  String precipitation;
  int humidity;
  String description;
  String weatherIcon;
  String cityName;
  String forecastTime;
  String backgroundImage;
  int noOfCards;

  String forecastType = 'daily';

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  //function to determine the type of weather data to display.
  void updateUI() {
    if (forecastType == 'daily') {
      noOfCards = 8;
      updateDailyUI(widget.locationWeather, widget.locationCity);
    } else if (forecastType == 'hourly') {
      noOfCards = 24;
      updateHourlyUI(widget.locationWeather, widget.locationCity);
    }
  }

  //function to pick selected weather data from the received data and calculating
  //to display them appropriately in hourly forecast.
  void updateHourlyUI(dynamic weatherData, dynamic cityData) {
    setState(
      () {
        if (weatherData == null) {
          temperature = 0;
          minTemp = 0;
          maxTemp = 0;
          windSpeed = '?';
          precipitation = '?';
          humidity = 0;
          description = 'Unable to get weather data';
          weatherIcon = '?';
          backgroundImage = '13d';
          print('oh no!');
          return;
        } else if (cityData == null) {
          cityName = 'Unknown';
        }

        int k = _index;

        //checking if the index of the bottom scrollable card is 0
        //if it is 0, then displaying the current weather data.
        //otherwise displaying the weather data of that hour.
        if (k == 0) {
          forecastTime = 'Current';
          temperature = weatherData['current']['temp'].toInt();
          weatherIcon = weatherData['current']['weather'][0]['icon'];
          backgroundImage = weatherData['current']['weather'][0]['icon'];
          description = weatherData['current']['weather'][0]['description'];
          windSpeed = (weatherData['current']['wind_speed'] * 18 / 5)
              .toStringAsFixed(1);
          humidity = weatherData['current']['humidity'].toInt();
        } else {
          forecastTime =
              '${DateFormat("jm").format(date(weatherData['hourly'][k]['dt'], weatherData['timezone_offset'])).toUpperCase()}';
          temperature = (widget.locationWeather['hourly'][k]['temp']).round();
          weatherIcon = weatherData['hourly'][k]['weather'][0]['icon'];
          backgroundImage = weatherData['hourly'][k]['weather'][0]['icon'];
          description = weatherData['hourly'][k]['weather'][0]['description'];

          humidity = weatherData['hourly'][k]['humidity'].toInt();
          windSpeed = (weatherData['hourly'][k]['wind_speed'] * 18 / 5)
              .toStringAsFixed(1);
        }
        //calculating the difference in time between, the current hour(the hour
        //the weather data has been fetched) and the hour in the card in question,
        //based on its index.
        //To display the minimum and maximum temperature of the appropriate day.
        DateTime d1 = date(
            weatherData['hourly'][k]['dt'], weatherData['timezone_offset']);
        DateTime d2 = date(
            weatherData['hourly'][0]['dt'], weatherData['timezone_offset']);
        int g = diffInDays(d1, d2);
        double minT = (weatherData['daily'][g]['temp']['min']).toDouble();
        double maxT = (weatherData['daily'][g]['temp']['max']).toDouble();

        int dt = weatherData['hourly'][k]['dt'];
        int timezone_offset = weatherData['timezone_offset'];
        dayUI =
            DateFormat("EEEE").format(date(dt, timezone_offset)).toUpperCase();
        dateUI = DateFormat("dd-LLL-yyyy")
            .format(date(dt, timezone_offset))
            .toUpperCase(); // delete later

        minTemp = minT.toInt();
        maxTemp = maxT.toInt();
        //precipitation/rain values are absent in the received data if its value is 0
        //in that case preventing extraction of that field and precipitation to store 0 instead of null.
        if (weatherData['hourly'][k]['rain'] == null) {
          precipitation = '0';
        } else {
          precipitation =
              weatherData['hourly'][k]['rain']['1h'].toStringAsFixed(1);
        }
      },
    );
  }

  //function to determine changing of the day.
  //returns difference in the two DateTime in terms of days.
  int diffInDays(DateTime date1, DateTime date2) {
    return ((date1.difference(date2) -
                    Duration(hours: date1.hour) +
                    Duration(hours: date2.hour))
                .inHours /
            24)
        .round();
  }

  //function to pick selected weather data from the received data and calculating
  //to display them appropriately in daily forecast.
  void updateDailyUI(dynamic weatherData, dynamic cityData) {
    setState(
      () {
        if (weatherData == null) {
          temperature = 0;
          minTemp = 0;
          maxTemp = 0;
          windSpeed = '?';
          precipitation = '?';
          humidity = 0;
          description = 'Unable to get weather data';
          weatherIcon = '?';
          backgroundImage = '13d';
          print('oh no!');
          return;
        } else if (cityData == null) {
          cityName = 'Unknown';
        }

        cityName = cityData;
        int k = _index;
        double minT = (weatherData['daily'][k]['temp']['min']).toDouble();
        double maxT = (weatherData['daily'][k]['temp']['max']).toDouble();

        //checking if the index of the bottom scrollable card is 0
        //if it is 0, then displaying the current weather data.
        //otherwise displaying the weather data of that hour.
        if (k == 0) {
          forecastTime = 'Current';
          temperature = weatherData['current']['temp'].toInt();
          weatherIcon = weatherData['current']['weather'][0]['icon'];
          backgroundImage = weatherData['current']['weather'][0]['icon'];
          description = weatherData['current']['weather'][0]['description'];
          windSpeed = (weatherData['current']['wind_speed'] * 18 / 5)
              .toStringAsFixed(1);
          humidity = weatherData['current']['humidity'].toInt();
        } else {
          forecastTime = '';
          temperature = (minT + maxT) ~/ 2;
          weatherIcon = weatherData['daily'][k]['weather'][0]['icon'];
          backgroundImage = weatherData['daily'][k]['weather'][0]['icon'];
          description = weatherData['daily'][k]['weather'][0]['description'];
          humidity = weatherData['daily'][k]['humidity'].toInt();
          windSpeed = (weatherData['daily'][k]['wind_speed'] * 18 / 5)
              .toStringAsFixed(1);
        }
        int dt = weatherData['daily'][k]['dt'];
        int timezone_offset = weatherData['timezone_offset'];
        dayUI =
            DateFormat("EEEE").format(date(dt, timezone_offset)).toUpperCase();
        dateUI = DateFormat("dd-LLL-yyyy")
            .format(date(dt, timezone_offset))
            .toUpperCase();

        minTemp = minT.toInt();
        maxTemp = maxT.toInt();
        //precipitation/rain values are absent in the received data if its value is 0
        //in that case preventing extraction of that field and precipitation to store 0 instead of null.
        if (weatherData['daily'][k]['rain'] == null) {
          precipitation = '0';
        } else {
          precipitation = weatherData['daily'][k]['rain'].toStringAsFixed(1);
        }
      },
    );
  }

  //function to convert unix utc time to the Datetime in timezone of the region.
  DateTime date(int dt, int timezoneOffset) {
    DateTime dd = new DateTime.fromMillisecondsSinceEpoch(
        (dt + timezoneOffset) * 1000,
        isUtc: true);
    return dd;
  }

  //to display the time of forecast in the bottom scrollable cards based on the type of forecast
  String timeOfForecast(int cIndex) {
    if (forecastType == 'daily') {
      return '${DateFormat("E").format(date(widget.locationWeather['daily'][cIndex]['dt'], widget.locationWeather['timezone_offset'])).toUpperCase()}';
    } else if (forecastType == 'hourly') {
      return '${DateFormat("jm").format(date(widget.locationWeather['hourly'][cIndex]['dt'], widget.locationWeather['timezone_offset'])).toUpperCase()}';
    }
  }

  //to display the forecast icon in the bottom scrollable cards based on the type of forecast
  String forecastIcon(int cIndex) {
    if (forecastType == 'daily') {
      return 'images/icons/${widget.locationWeather['daily'][cIndex]['weather'][0]['icon']}.svg';
    } else if (forecastType == 'hourly') {
      return 'images/icons/${widget.locationWeather['hourly'][cIndex]['weather'][0]['icon']}.svg';
    }
  }

  //to display the forecast temperature in the bottom scrollable cards based on the type of forecast
  String forecastTemperature(int cIndex) {
    if (forecastType == 'daily') {
      return '${(widget.locationWeather['daily'][cIndex]['temp']['min'] + widget.locationWeather['daily'][cIndex]['temp']['max']) ~/ 2}°';
    } else if (forecastType == 'hourly') {
      return '${(widget.locationWeather['hourly'][cIndex]['temp']).round()}°';
    }
  }

  //to make the individual cards
  Widget scrollableCard(int i) {
    return Transform.scale(
      scale: i == _index ? 1.05 : 0.9,
      child: Card(
        color: Color(0x00ffffff),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                '${timeOfForecast(i)}',
                style: kScrollableCardDay,
              ),
              SafeArea(
                child: SvgPicture.asset(
                  '${forecastIcon(i)}',
                  width: 30.0,
                  color: Colors.white,
                ),
              ),
              Text(
                '${forecastTemperature(i)}',
                style: kScrollableCardTemp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //controller property of PageView.builder
  //To set the index of onPageChanged.
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.2, keepPage: false);

  //to build the bottom scrollable cards, based on the forecast type the number of cards are determined.
  Widget pageViewBuilder() {
    return PageView.builder(
      itemCount: noOfCards,
      controller: _controller,
      onPageChanged: (ind) {
        setState(() {
          _index = ind;
          updateUI();
        });
      },
      itemBuilder: (context, i) {
        return scrollableCard(i);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$backgroundImage.jpg'),
            //TODO: load image faster or some other efficient method to display bg image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName('/'),
                      );
                    },
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      size: 40.0,
                    ),
                  ),
                  //to change the type of forecast between 'daily' and 'hourly'.
                  PopupMenuButton<String>(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'daily',
                        child: Text(
                          "Daily Forecast",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.grey.shade800),
                        ),
                      ),
                      PopupMenuDivider(
                        height: 0.0,
                      ),
                      PopupMenuItem(
                        value: 'hourly',
                        child: Text(
                          "Hourly Forecast",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.grey.shade800),
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      //setting the index value of onPageChanged to initial page.
                      _controller.jumpToPage(0);
                      setState(() {
                        forecastType = value;
                        updateUI();
                      });
                    },
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    icon: Icon(
                      Icons.more_horiz,
                      size: 40.0,
                    ),
                    offset: Offset(0, 5),
                    color: Color(0xFFFFFFFF),
                  ),
                ],
              ),
              SizedBox(
                height: 60.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '$cityName'.toUpperCase(),
                          style: kCityName,
                        ),
                      ),
                    ),
                    Text('$dayUI, $dateUI $forecastTime', style: kDateText),
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTemperatureText,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            '$minTemp°-$maxTemp°',
                            style: kDescriptionText,
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 05.0),
                                //using svg format so that, icon's size and color can be customized and avoid distortion.
                                child: SvgPicture.asset(
                                  'images/icons/$weatherIcon.svg',
                                  width: 40.0,
                                  height: 40.0,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Text(
                                  '$description'.inCaps,
                                  overflow: TextOverflow.clip,
                                  maxLines: 5,
                                  style: kDescriptionText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1.0,
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Wind',
                              style: kPropertyName,
                            ),
                            Text(
                              '$windSpeed',
                              style: kPropertyValue,
                            ),
                            Text(
                              'Km/h',
                              style: kPropertyUnit,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Precipitation',
                              style: kPropertyName,
                            ),
                            Text(
                              '$precipitation',
                              style: kPropertyValue,
                            ),
                            Text(
                              'mm',
                              style: kPropertyUnit,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Humidity',
                              style: kPropertyName,
                            ),
                            Text(
                              '%$humidity',
                              style: kPropertyValue,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              Center(
                child: SizedBox(
                  height: 130, // card height
                  child: pageViewBuilder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
