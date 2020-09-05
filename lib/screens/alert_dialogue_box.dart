//class to implement function to display alert messages using rflutter_alert package.

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weatherapp/utilities/constants.dart';

class AlertDialogue{
  AlertDialogue(this.contextName, this.title, this.desc, this.alertType);
  final BuildContext contextName;
  final String title;
  final String desc;
  final AlertType alertType;
  void displayAlert(){
    Alert(
      style: alertStyle,
      context: contextName,
      type: alertType,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: kDialogueButtonText,
          ),
          onPressed: () => Navigator.popUntil(
            contextName,
            ModalRoute.withName('/'),
          ),
          width: 120,
          color: Color.fromRGBO(0, 129, 124, 1.0),
          radius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
      ],
    ).show();
  }

}