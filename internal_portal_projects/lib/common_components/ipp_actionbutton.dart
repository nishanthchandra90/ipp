import 'package:flutter/material.dart';

class IPPActionButton {
  static floatingAddButton(Function onPressed, toolTipText) {
    return new FloatingActionButton(
      mini: true,
      onPressed: onPressed,
      tooltip: 'Click to add new ' + toolTipText,
      child: Icon(Icons.add),
    );
  }
}