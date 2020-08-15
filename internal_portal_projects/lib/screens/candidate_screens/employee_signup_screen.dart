import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_dialogs.dart';
import 'package:internal_portal_projects/common_components/ipp_inputelements.dart';
import 'package:internal_portal_projects/common_components/ipp_snackbar.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/repo/employees_repo.dart';

class EmployeeSignUpScreen extends StatefulWidget {
  final String email;

  const EmployeeSignUpScreen(this.email);

  @override
  State<StatefulWidget> createState() => _EmployeeSignUpScreenState(email);
}

class _EmployeeSignUpScreenState extends State<EmployeeSignUpScreen> {
  final _employeeFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<State> globalStateKey = new GlobalKey<State>();
  final String email;
  final TextEditingController empIdEditCntrlr = TextEditingController();
  final TextEditingController fNameEditCntrlr = TextEditingController();
  final TextEditingController lNameEditCntrlr = TextEditingController();
  final TextEditingController pwdEditCntrlr = TextEditingController();
  final TextEditingController skillsEditCntrlr = TextEditingController();

  _EmployeeSignUpScreenState(this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    "Employee Id", "emp id", empIdEditCntrlr, true, context,
                    charLimit: 20),
                IPPInputs.simpleTextFormField(
                    "First Name", "first name", fNameEditCntrlr, true, context,
                    charLimit: 20),
                IPPInputs.simpleTextFormField(
                    "Last Name", "last name", lNameEditCntrlr, true, context,
                    charLimit: 20),
                IPPInputs.simpleTextFormField(
                    "Password", "password", pwdEditCntrlr, true, context,
                    charLimit: 20, obscureText: true),
                IPPInputs.simpleTextFormField(
                    "Skills", "skills", skillsEditCntrlr, true, context,
                    charLimit: 20),
                ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () {
                          _saveEmployee();
                        },
                        child: Text('Sing Up')),
                    RaisedButton(
                        onPressed: () {
                          _resetForm();
                        },
                        child: Text('Reset')),
                  ],
                )
              ],
            )));
  }

  Future<void> _saveEmployee() async {
    var formState = _employeeFormKey.currentState;
    formState.save();
    formState.validate();
    String _employeeId = empIdEditCntrlr.text;
    String _empFName = fNameEditCntrlr.text;
    String _empLName = lNameEditCntrlr.text;
    String password = pwdEditCntrlr.text;
    EmployeeDetails employee = new EmployeeDetails(
        _employeeId, _empFName, _empLName, email, password, false);
    new EmployeesRepo().newUser(employee);
    try {
      Dialogs.showProgressDialog(context, globalStateKey, "Please wait...!");
      await new Future.delayed(const Duration(seconds: 1));
      _displaySnackBar('Employee details saved Successfully!',
          color: Colors.green);
      Navigator.of(_scaffoldKey.currentContext, rootNavigator: true)
          .pop(); //close the dialogue
      _resetForm();
      await new Future.delayed(const Duration(seconds: 1));
      Navigator.of(_scaffoldKey.currentContext, rootNavigator: true)
          .pushNamed('/login');
    } catch (error) {
      Navigator.pop(context);
      _displaySnackBar("Something Went Wrong! Try again.", color: Colors.red);
    }
  }

  _displaySnackBar(String message, {MaterialColor color}) {
    final snackBar = IPPSnackBar.formSavingSnackBar(message, bgColor: color);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _resetForm() {
    var formState = _employeeFormKey.currentState;
    formState.reset();
    empIdEditCntrlr.clear();
    fNameEditCntrlr.clear();
    lNameEditCntrlr.clear();
    empIdEditCntrlr.clear();
    pwdEditCntrlr.clear();
    skillsEditCntrlr.clear();
  }
}
