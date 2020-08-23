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

  static formButton(String buttonText,
      {Function() onPressed, color: Colors.green}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
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

  static Widget widgetRow(Widget widget, String errorText, bool validInput,
      List<Widget> dropDownButtons) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: new Column(
        children: <Widget>[
          new ListTile(
            leading: widget,
            title: Row(children: dropDownButtons),
          ),
          SizedBox(height: validInput ? 0.0 : 5.0),
          Text(
            validInput ? '' : errorText,
            style: TextStyle(
                color: Colors.redAccent.shade700,
                fontSize: validInput ? 0.0 : 12.0),
          ),
        ],
      ),
    );
  }

  static Widget dropdown(List menuItems, String field, String hintText,
      BuildContext context, Function function) {
    return Expanded(
        child: new DropdownButton(
      hint: new Text(hintText),
      style: TextStyle(color: Colors.black, fontSize: 18),
      isDense: true,
      isExpanded: true,
      underline: SizedBox(),
      value: field,
      onChanged: (val) => function(val),
      items: dropdownMenuItems(menuItems),
    ));
  }

  static List<DropdownMenuItem> dropdownMenuItems(List options) {
    return options
        .map((val) => new DropdownMenuItem(
              value: '$val',
              child: SizedBox(
                  child: Text(
                '$val',
                softWrap: false,
                textAlign: TextAlign.right,
              )),
            ))
        .toList();
  }
}
