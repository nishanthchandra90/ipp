import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_inputelements.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';

class EmployeeSignUpScreen extends StatefulWidget {
  final String email;

  const EmployeeSignUpScreen(this.email);

  @override
  State<StatefulWidget> createState() => _EmployeeSignUpScreenState(email);
}

class _EmployeeSignUpScreenState extends State<EmployeeSignUpScreen> {
  final _employeeFormKey = GlobalKey<FormState>();
  final String email;
  final TextEditingController fNameEditCntrlr = TextEditingController();
  final TextEditingController lNameEditCntrlr = TextEditingController();

  _EmployeeSignUpScreenState(this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: IPPText.simpleText('New Candidate',
            fontWeight: FontWeight.bold, fontSize: 22.0),
      ),
      body: _buildEmployeeForm(),
    );
  }

  _buildEmployeeForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IPPText.simpleText(email,
              fontSize: 22.0, fontWeight: FontWeight.bold),
          Divider(
            thickness: 2.0,
          ),
          _form(),
        ],
      ),
    );
  }

  _form() {
    return Form(
        key: _employeeFormKey,
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IPPText.simpleText(
                    'Please fill out this form to complete the registration',
                    color: Colors.blue),
                IPPInputs.simpleTextFormField(
                    "Name", "first name", fNameEditCntrlr, true, context,
                    charLimit: 20),
                IPPInputs.simpleTextFormField(
                    "Name", "last name", lNameEditCntrlr, true, context,
                    charLimit: 20),
                ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RaisedButton(onPressed: () {}, child: Text('Sing Up')),
                    RaisedButton(onPressed: () {}, child: Text('Reset')),
                  ],
                )
              ],
            )));
  }
}
