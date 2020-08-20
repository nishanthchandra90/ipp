import 'dart:convert';

import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/repo/employees_repo.dart';

class EmployeeService {
  static isNewUser(String emailId) async {
    var response = await new EmployeesRepo().isNewUser(emailId);
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      if (reply.isNotEmpty) {
        var json = jsonDecode(reply);
        return json['newUser'];
      }
    }
    return false;
  }

  static isRegisteredUser(String emailId) async {
    var response = await new EmployeesRepo().isRegisteredUser(emailId);
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      if (reply.isNotEmpty) {
        var json = jsonDecode(reply);
        return json['registeredUser'];
      }
    }
    return false;
  }

  static getAllUsers() async {
    var response = await new EmployeesRepo().getAllUsers();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      if (reply.length < 5) {
        return [];
      }
      final decoded = _decodeResponse(reply);
      return decoded
          .map<EmployeeDetails>((j) => EmployeeDetails.fromJson(j))
          .toList();
    }
    return <EmployeeDetails>[];
  }

  static getUserByEmail(String email) async {
    var response = await new EmployeesRepo().getUserByEmail(email);
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      if (reply.length < 5) {
        return [];
      }
      if (reply.isNotEmpty) {
        var json = jsonDecode(reply);
        return EmployeeDetails.fromJson(json);
      }
    }
    return null;
  }

  static getUserById(String id) async {
    var response = await new EmployeesRepo().getUserById(id);
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      if (reply.length < 5) {
        return null;
      }
      if (reply.isNotEmpty) {
        var json = jsonDecode(reply);
        return EmployeeDetails.fromJson(json);
      }
    }
    return null;
  }

  static _decodeResponse(String responseBody) {
    return json.decode(responseBody).cast<Map<String, dynamic>>();
  }
}
