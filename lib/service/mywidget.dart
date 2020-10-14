import 'package:flutter/material.dart';

class Mywidget{

  static void showInSnackBar(String value, Stcolor, _scaffoldKey, bgcolor, seconds) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      content: Text(
        value,
        style: TextStyle(color: Stcolor),
      ),
      backgroundColor: bgcolor,
      duration: Duration(seconds: seconds),
    ));
  }
}