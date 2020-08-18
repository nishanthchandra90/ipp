import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:internal_portal_projects/service/project_manage_service.dart';

class AuthService with ChangeNotifier {
  var currentUser;

  AuthService() {}

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
      return await ProjectManagementService()
          .getUserByEmail(email.toLowerCase());
    } else
      return await ProjectManagementService().getUserById(email.toLowerCase());

    if (StringUtils.equalsIgnoreCase(email, 'Admin') ||
        StringUtils.equalsIgnoreCase(email, 'emp')) {
      this.currentUser = {'email': email};
      notifyListeners();
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }
  }

  Future isNewUser(String emailId) async {
    return await ProjectManagementService().isNewUser(emailId.toLowerCase());
  }

  isRegisteredUser(String emailId) async {
    return await ProjectManagementService().isRegisteredUser(emailId);
  }
}
