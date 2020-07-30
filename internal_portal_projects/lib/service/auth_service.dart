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

  Future loginUser({String email, String password}) async{
    return await ProjectManagementService().getUserByEmailName(email);

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
