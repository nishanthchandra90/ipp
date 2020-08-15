import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
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
            child: Center(
                child: Form(
                    // <= NEW
                    key: _formKey,
                    child: new SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Text(
                            "TCS Internal Projects",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20.0),
                          IPPInputs.simpleTextFormField("Email or Username", '',
                              emailEditingController, true, context,
                              keyboardType: TextInputType.emailAddress,
                              charLimit: 30),
                          IPPInputs.simpleTextFormField("Password", '',
                              passwordEditingController, true, context,
                              obscureText: true),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                  color: Colors.blue,
                                  child: IPPText.simpleText("Login",
                                      fontSize: 18.0),
                                  onPressed: () => _saveLoginForm()),
                              SizedBox(
                                width: 20.0,
                              ),
                              new InkWell(
                                  child: IPPText.simpleText('Forgot Password?',
                                      color: Colors.blue),
                                  onTap: () =>
                                      _navigateToRegisterScreen(false)),
                            ],
                          ),
                          Visibility(
                            visible: _loginFailed,
                            child: IPPText.simpleText('Invalid Credentials',
                                color: Colors.red),
                          ),
                          Divider(
                            color: Colors.green,
                            thickness: 2.0,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Column(
                              children: <Widget>[
                                IPPText.simpleText('OR', fontSize: 22.0),
                                IPPText.simpleText('Create your account now.'),
                                SizedBox(height: 20.0),
                                RaisedButton(
                                    color: Colors.green,
                                    child: IPPText.simpleText("Register",
                                        fontSize: 18.0),
                                    onPressed: () {
                                      _navigateToRegisterScreen(true);
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                    )))));
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

  _navigateToRegisterScreen(bool toRegister) {
    Navigator.push(
      context,
      MaterialPageRoute(
          settings: RouteSettings(name: "/register"),
          builder: (BuildContext context) => RegisterScreen(
                toRegister: toRegister,
              )),
    );
  }
}
