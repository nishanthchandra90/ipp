import 'package:flutter/cupertino.dart';

import 'employee_service.dart';

class AuthService with ChangeNotifier {
  var currentUser;

  AuthService();

  Future getUser() {
    return Future.value(currentUser);
  }

  Future logout() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  Future createUser(
      {String firstName,
      String lastName,
      String email,
      String password}) async {}

  Future loginUser({String email, String password}) async {
    bool isEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (isEmail) {
      return await EmployeeService.getUserByEmail(email.toLowerCase());
    } else
      return await EmployeeService.getUserById(email.toLowerCase());
  }

  Future isNewUser(String emailId) async {
    return await EmployeeService.isNewUser(emailId.toLowerCase());
  }

  isRegisteredUser(String emailId) async {
    return await EmployeeService.isRegisteredUser(emailId);
  }
}
