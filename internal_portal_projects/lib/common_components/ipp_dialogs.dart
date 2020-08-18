import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Dialogs {
  static Future<void> showProgressDialog(
      BuildContext context, GlobalKey key, String text) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          text,
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }

  static numberPickerDialog(
      String initialText,
      String dialogTitle,
      int initialValue,
      int minVal,
      int maxVal,
      Function onChanged,
      BuildContext context,
      {double width: 70,
        String labelText: ''}) {
    return new GestureDetector(
      child: SizedBox(
          width: width,
          child: InputDecorator(
            child: Text(
              initialText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            decoration: InputDecoration(
              labelText: labelText,
            ),
          )),
      onTap: () {
        showDialog<int>(
            context: context,
            builder: (BuildContext context) {
              return new NumberPickerDialog.integer(
                minValue: minVal,
                maxValue: maxVal,
                title: new Text(dialogTitle),
                initialIntegerValue: initialValue,
              );
            }).then((value) => {onChanged(value)});
      },
    );
  }
}
