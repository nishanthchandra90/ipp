import 'package:flutter/material.dart';

class IPPSnackBar {
  static formSavingSnackBar(String message) {
    return SnackBar(
      content: Container(
        height: 50.0,
        child: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
  }
}
