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

  Future loginUser({String email, String password}) async {
    return await EmployeeService.getUserById(email.toLowerCase());
  }

  Future isNewUser(String emailId) async {
    return await EmployeeService.isNewUser(emailId.toLowerCase());
  }

  isRegisteredUser(String emailId) async {
    return await EmployeeService.isRegisteredUser(emailId);
  }
}
