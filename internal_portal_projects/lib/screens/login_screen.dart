import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/screens/employee_register_screen.dart';
import 'package:internal_portal_projects/screens/home_screen.dart';
import 'package:internal_portal_projects/service/auth_service.dart';

import '../common_components/ipp_inputelements.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _loginFailed = false;
  EmployeeDetails employee;
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Form(
                // <= NEW
                key: _formKey,
                child: new SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Text(
                        "TCS Internal Projects",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20.0),
                      IPPInputs.simpleTextFormField("Email or Username", '',
                          emailEditingController, true, context,
                          keyboardType: TextInputType.emailAddress),
                      IPPInputs.simpleTextFormField("Password", '',
                          passwordEditingController, true, context,
                          obscureText: true),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: Colors.blue,
                          child: Text("Login"),
                          onPressed: () => _saveLoginForm()),
                      Visibility(
                        visible: _loginFailed,
                        child: Text(
                          'Invalid Credentials',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      RaisedButton(
                          color: Colors.green,
                          child: Text("Register"),
                          onPressed: () {
                            _navigateToRegisterScreen();
                          })
                    ],
                  ),
                ))));
  }

  _saveLoginForm() async {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      await AuthService()
          .loginUser(
              email: emailEditingController.text,
              password: passwordEditingController.text)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      employee = value;
                    }),
                    _navigateToHomeScreen()
                  }
                else
                  {
                    setState(() {
                      _loginFailed = true;
                    })
                  }
              });
    }
  }

  _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          settings: RouteSettings(name: "/home"),
          builder: (BuildContext context) => MyHomePage(employee: employee)),
    );
  }

  _navigateToRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          settings: RouteSettings(name: "/register"),
          builder: (BuildContext context) => RegisterScreen()),
    );
  }
}
