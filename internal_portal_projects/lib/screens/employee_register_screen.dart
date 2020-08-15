import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_inputelements.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/service/auth_service.dart';

import 'candidate_screens/employee_signup_screen.dart';
import 'candidate_screens/reset_password_screen.dart';

class RegisterScreen extends StatefulWidget {
  final bool toRegister;

  RegisterScreen({this.toRegister});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState(toRegister);
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  bool _emailVerificationMsg = false;
  bool _showNextBtn = true;
  bool _showOTPField = false;
  bool _validEmail = false;
  String _verificationMsg = '';
  String _otpVerificationMsg = '';
  bool toRegister;
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  _RegisterScreenState(this.toRegister);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: BackButton(onPressed: () => Navigator.pop(context)),
            title: IPPText.simpleText(
                toRegister ? 'Register' : 'Password Reset',
                fontSize: 22.0,
                fontWeight: FontWeight.bold)),
        body: Center(child: _buildEmailVerificationForm()));
  }

  _buildEmailVerificationForm() {
    return new SingleChildScrollView(
        child: Column(
      children: <Widget>[_emailForm(), _otpForm()],
    ));
  }

  _emailForm() {
    return Form(
        key: _emailFormKey,
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _validEmail
                      ? IPPText.simpleText(emailIdController.text,
                          fontWeight: FontWeight.bold, fontSize: 22.0)
                      : IPPInputs.simpleTextFormField(
                          'Email', 'email id', emailIdController, true, context,
                          keyboardType: TextInputType.emailAddress,
                          charLimit: 30),
                  Visibility(
                      visible: _showNextBtn,
                      child: IPPInputs.formButton("Next", color: Colors.green,
                          onPressed: () {
                        _verifyEmail();
                      })),
                  Visibility(
                    visible: _emailVerificationMsg,
                    child: Text(
                      _verificationMsg,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ])));
  }

  _otpForm() {
    return Form(
        key: _otpFormKey,
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Visibility(
              visible: _showOTPField,
              child: Column(
                children: <Widget>[
                  Divider(),
                  IPPText.simpleText(
                      'Enter 5-Digit OTP sent to the above Email'),
                  IPPInputs.simpleNumberField(
                      'OTP', '', otpController, true, context,
                      charLimit: 5),
                  IPPInputs.formButton("Verify", onPressed: () {
                    _verifyOTP();
                  }),
                  IPPText.simpleText(_otpVerificationMsg),
                ],
              ),
            )));
  }

  _verifyEmail() async {
    final form = _emailFormKey.currentState;
    form.save();
    if (!form.validate()) {
      return;
    }
    String emailId = emailIdController.text;
    bool isValidEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailId);
    if (!isValidEmail) {
      _setVerificationMsg(true, 'Invalid Email Id format');
      return;
    }
    _setVerificationMsg(false, '');
    if (toRegister) {
      _registerNewEmail(emailId);
    } else {
      _resetPassword(emailId);
    }
  }

  _setVerificationMsg(bool showText, String msg) {
    setState(() {
      _verificationMsg = msg;
      _emailVerificationMsg = showText;
    });
  }

  _toggleNextBtn(bool show) {
    setState(() {
      _validEmail = !show;
      _showNextBtn = show;
    });
  }

  _toggleOTPField(bool show) {
    setState(() {
      _showOTPField = show;
    });
  }

  _verifyOTP() async {
    var form = _otpFormKey.currentState;
    form.save();
    if (form.validate()) {
      String otp = otpController.text;
      String email = emailIdController.text;
      await new AuthService().verifyOtp(email, otp).then((validOTP) => {
            if (validOTP)
              {
                _otpVerificationMsg = '',
                toRegister
                    ? _navigateToEmployeeSignUpScreen(email)
                    : _navigateToNewPWDScreen(email)
              }
            else
              {
                setState(() {
                  _otpVerificationMsg = 'invalid otp';
                })
              }
          });
      // call verify email by sending otp
    }
  }

  _navigateToEmployeeSignUpScreen(String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => EmployeeSignUpScreen(email)),
    );
  }

  _navigateToNewPWDScreen(String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => NewPasswordScreen(email)),
    );
  }

  void _registerNewEmail(String emailId) async {
    await AuthService().isNewUser(emailId).then((isNewUser) => {
          if (isNewUser != null)
            {
              if (isNewUser)
                {_toggleNextBtn(false), _toggleOTPField(true)}
              else
                {
                  _setVerificationMsg(true, 'Email is already registered'),
                  _toggleNextBtn(true),
                  _toggleOTPField(false)
                }
            }
        });
  }

  void _resetPassword(String emailId) async {
    await AuthService().isRegisteredUser(emailId).then((isRegisteredUser) => {
          if (isRegisteredUser != null)
            {
              if (isRegisteredUser)
                {_toggleNextBtn(false), _toggleOTPField(true)}
              else
                {
                  _setVerificationMsg(true, 'Email is not registered'),
                  _toggleNextBtn(true),
                  _toggleOTPField(false)
                }
            }
        });
  }
}
