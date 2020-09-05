//Constants file to style textfield, texts, alert dialogue boxes.

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0x3AFFFFFF),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0),),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0x5FFFFFFF), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0),),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0x5FFFFFFF), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0),),
  ),
  icon: Icon(
    Icons.location_city,
    color: Color(0xFFFFFFFF),
  ),
  hintText: 'City',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
);

const kPropertyName = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 15.0,
);
const kPropertyValue = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
  fontSize: 20.0,
);
const kPropertyUnit = TextStyle(
  fontSize: 10.0,
  fontFamily: 'Montserrat',
);

const kTemperatureText = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
  fontSize: 120,
);
const kDescriptionText = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 16,
  fontWeight: FontWeight.w400,
);
const kCityName = TextStyle(
    fontFamily: 'Montserrat', fontWeight: FontWeight.w900, fontSize: 36);

const kDateText = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w400,
);

const kScrollableCardDay = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w800,
  fontSize: 12.0,
);

const kScrollableCardTemp = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w800,
  fontSize: 16.0,
);

const kAppTitle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 36,
  fontWeight: FontWeight.w300,
  letterSpacing: 8.0,
);

const kDialogueButtonText = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w400,
  fontSize: 16.0,
);

var alertStyle = AlertStyle(
  overlayColor: Color(0x9F000000),
  backgroundColor: Color(0x39FFFFFF),
  animationType: AnimationType.fromBottom,
  isCloseButton: true,
  isOverlayTapDismiss: true,
  descStyle: TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
  ),
  animationDuration: Duration(milliseconds: 300),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 24.0,
  ),
);
