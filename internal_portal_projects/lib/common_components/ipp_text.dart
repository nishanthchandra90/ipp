import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IPPText {
  static simpleText(String textVal,
      {double fontSize: 16.0,
      align: TextAlign.left,
      fontWeight: FontWeight.normal,
      overflow: TextOverflow.visible,
      color: Colors.black}) {
    return Text(
      textVal,
      textAlign: align,
      style: TextStyle(fontSize: fontSize, color: color),
      overflow: overflow,
    );
  }
}
