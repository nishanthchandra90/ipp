import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IPPInputs {
  static simpleTextAreaField(
      String labelText,
      String hintText,
      TextEditingController textEditCntrlr,
      bool requiredField,
      BuildContext context,
      {Function onChanged}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 40, 0),
        child: new TextFormField(
          maxLines: 5,
          validator: (value) {
            return formValidator(requiredField, value, hintText);
          },
          controller: textEditCntrlr,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ));
  }

  static simpleTextFormField(
    String labelText,
    String hintText,
    TextEditingController textEditCntrlr,
    bool requiredField,
    BuildContext context, {
    Function onChanged,
    int charLimit: 20,
    keyboardType: TextInputType.text,
    obscureText: false,
  }) {
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 40, 0),
        child: new TextFormField(
          validator: (value) {
            return formValidator(requiredField, value, labelText);
          },
          controller: textEditCntrlr,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
          ),
          obscureText: obscureText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          inputFormatters: [
            new LengthLimitingTextInputFormatter(charLimit),
          ],
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ));
  }

  static simpleNumberField(
      String labelText,
      String hintText,
      TextEditingController textEditCntrlr,
      bool requiredField,
      BuildContext context, {
        Function onChanged,
        int charLimit: 20,
        keyboardType: TextInputType.number,
        obscureText: false,
      }){
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 40, 0),
        child: new TextFormField(
          validator: (value) {
            return formValidator(requiredField, value, labelText);
          },
          controller: textEditCntrlr,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
          ),
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          inputFormatters: [
            new LengthLimitingTextInputFormatter(charLimit),
          ],
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ));
  }

  static formValidator(requiredField, value, hintText) {
    if (requiredField && (value == null || value.isEmpty)) {
      return "Please enter valid " + hintText;
    }
    return null;
  }

  static formButton(String buttonText, {Function() onPressed, color:Colors.green}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: RaisedButton(
          color: color,
          onPressed: () => onPressed(),
          child: Text(buttonText),
        ));
  }

  static formButtonRow(Widget saveButton, Widget resetButton) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 75.0),
      child: new Row(
        children: <Widget>[
          saveButton,
          new SizedBox(
            width: 10,
          ),
          resetButton
        ],
      ),
    );
  }
}
