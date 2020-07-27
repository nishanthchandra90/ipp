import 'package:flutter/cupertino.dart';

class IPPText {
  static simpleText(String textVal,
      {double fontSize: 16.0,
      align: TextAlign.left,
      fontWeight: FontWeight.normal}) {
    return Text(
      textVal,
      textAlign: align,
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }
}
