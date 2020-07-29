import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';

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

  Future loginUser({String email, String password}) {
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
}
