import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_dialogs.dart';
import 'package:internal_portal_projects/common_components/ipp_inputelements.dart';
import 'package:internal_portal_projects/common_components/ipp_snackbar.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/repo/employees_repo.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen();

  @override
  State<StatefulWidget> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _employeeFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<State> globalStateKey = new GlobalKey<State>();
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  String _pwdError = '';

  _NewPasswordScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: IPPText.simpleText('Set New Password',
            fontWeight: FontWeight.bold, fontSize: 22.0),
      ),
      body: SingleChildScrollView(child: _form()),
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
                IPPInputs.simpleTextFormField(
                    "Employee Id", '', empIdController, true, context),
                IPPInputs.simpleTextFormField(
                    "new password", '', newPasswordController, true, context,
                    obscureText: true),
                IPPInputs.simpleTextFormField("Repeat Password", '',
                    repeatPasswordController, true, context,
                    obscureText: true),
                IPPText.simpleText(_pwdError, color: Colors.red),
                ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () {
                          _saveEmployee();
                        },
                        child: Text('Submit')),
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
    if (!formState.validate()) {
      return;
    }
    String newPwd = newPasswordController.text;
    String repPwd = repeatPasswordController.text;
    if (newPwd != repPwd) {
      setState(() {
        _pwdError = 'Passwords do not match!';
      });
      return;
    }
    new EmployeesRepo().updatePWD(empIdController.text, newPwd);
    try {
      Dialogs.showProgressDialog(context, globalStateKey, "Please wait...!");
      await new Future.delayed(const Duration(seconds: 1));
      _displaySnackBar('Password Changed Successfully!', color: Colors.green);
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
    newPasswordController.clear();
    repeatPasswordController.clear();
    setState(() {
      _pwdError = '';
    });
  }
}
