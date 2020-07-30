import 'dart:convert';

import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/repo/employees_repo.dart';
import 'package:internal_portal_projects/repo/projects_repo.dart';

class ProjectManagementService {
  getMatchedProjects(String skills) async {
    var response = await new ProjectsRepo().getMatchedProjects(skills);
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      print(reply);
      final decoded = _decodeResponse(reply);
      return decoded
          .map<ProjectDetails>((json) => ProjectDetails.fromJson(json))
          .toList();
    }
    return <ProjectDetails>[];
  }

  getAllProjects() async {
    var response = await new ProjectsRepo().getAllProjects();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      final decoded = _decodeResponse(reply);
      return decoded
          .map<ProjectDetails>((json) => ProjectDetails.fromJson(json))
          .toList();
    }
    return <ProjectDetails>[];
  }

  _decodeResponse(String responseBody) {
    return json.decode(responseBody).cast<Map<String, dynamic>>();
  }

  getAllUsers() async {
    var response = await new EmployeesRepo().getAllUsers();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      final decoded = _decodeResponse(reply);
      return decoded
          .map<EmployeeDetails>((j) => EmployeeDetails.fromJson(j))
          .toList();
    }
    return <EmployeeDetails>[];
  }

  getUserByEmailName(String emailOrName) async {
    var response = await new EmployeesRepo().getUserByEmailName(emailOrName);
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      if (reply.isNotEmpty) {
        var json = jsonDecode(reply);
        return EmployeeDetails.fromJson(json);
      }
    }
    return null;
  }
}
