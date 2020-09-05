///Landing/Home Screen
///For redirecting user to the weather forecast screen, based on user's input.
///Implementing text field for user to search a city in the world or
///locating the user, and fetching back the weather forecast.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'loading_screen.dart';
import 'get_city_loading_screen.dart';
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'alert_dialogue_box.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName; // to store the user entered string.

  Random random = new Random();
  int randomNumber;

  //Function to generate a random number from 0 to 11, to display a random
  //background image in the landing/home screen.
  void randomNum() {
    randomNumber = random.nextInt(12);
  }

  @override
  void initState() {
    super.initState();
    randomNum();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg$randomNumber.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            constraints: BoxConstraints.expand(),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 150, 0, 100),
                        child: Container(
                          child: Text(
                            'WEATHER',
                            style: kAppTitle,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: kTextFieldDecoration,
                          onChanged: (value) {
                            cityName = value;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: () {
                              if (cityName == null || cityName.trim() == '') {
                                AlertDialogue(
                                        context,
                                        '',
                                        'Enter a city to get weather!',
                                        AlertType.warning)
                                    .displayAlert();
                              } else {
                                //sending the user entered city name string to get_city_loading_screen.dart
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CityLoadingScreen(
                                        typedData: cityName.trim(),
                                        bgImageNo: randomNumber,
                                      ); //pass cityValue
                                    },
                                  ),
                                );
                              }
                            },
                            color: Color(0x3AFFFFFF),
                            focusColor: Color(0x5AFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                            ),
                            icon: Icon(Icons.wb_sunny),
                            label: Text(
                              'Get Weather',
                              //style: kButtonTextStyle,
                            ),
                          ),
                          FlatButton.icon(
                            color: Color(0x3AFFFFFF),
                            focusColor: Color(0x5AFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                            ),

                            icon: Icon(Icons.location_on), //`Icon` to display
                            label: Text('Locate me'), //`Text` to display

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LoadingScreen(
                                      bgImageNo: randomNumber,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
