import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_inputelements.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/service/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  bool _emailVerificationMsg = false;
  bool _showNextBtn = true;
  bool _showOTPField = false;
  bool _validEmail = false;
  String _verificationMsg = '';
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(onPressed: () => Navigator.pop(context)),
            title: IPPText.simpleText('Register',
                fontSize: 22.0, fontWeight: FontWeight.bold)),
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
                          keyboardType: TextInputType.emailAddress),
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
                  IPPText.simpleText('Enter the OTP sent to the above Email'),
                  IPPInputs.simpleNumberField(
                      'OTP', '', otpController, true, context),
                  IPPInputs.formButton("Verify", onPressed: () {
                    _verifyOTP();
                  }),
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
    await AuthService().isNewUser(emailId).then((value) => {
          if (value != null)
            {
              if (value)
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
      await new AuthService().verifyOtp(otp);
      // call verify email by sending otp
    }
  }
}
