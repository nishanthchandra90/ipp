import 'dart:convert';

import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/repo/employees_repo.dart';
import 'package:internal_portal_projects/repo/projects_repo.dart';

class ProjectManagementService {
  getAppliedProjects(String empId) async {
    var response = await new ProjectsRepo().getAppliedProjects(empId);
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      final decoded = _decodeResponse(reply);
      return decoded
          .map<ProjectDetails>((json) => ProjectDetails.fromJson(json))
          .toList();
    }
    return <ProjectDetails>[];
  }

  getMatchedProjects(String empId) async {
    var response = await new ProjectsRepo().getMatchedProjects(empId);
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
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

  getUserByEmail(String email) async {
    var response = await new EmployeesRepo().getUserByEmail(email);
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      if (reply.isNotEmpty) {
        var json = jsonDecode(reply);
        return EmployeeDetails.fromJson(json);
      }
    }
    return null;
  }

  getUserByName(String name) async {
    var response = await new EmployeesRepo().getUserByName(name);
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      if (reply.isNotEmpty) {
        var json = jsonDecode(reply);
        return EmployeeDetails.fromJson(json);
      }
    }
    return null;
  }

  getApplicationsAndMatches() async {
    var response = await new ProjectsRepo().getApplicationsAndMatches();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      final decoded = _decodeResponse(reply);
      return decoded
          .map<PotentialCandidates>((j) => PotentialCandidates.fromJson(j))
          .toList();
    }
    return <PotentialCandidates>[];
  }

  newProject(ProjectDetails project) async {
    await new ProjectsRepo().newProject(project);
  }

  updateProject(ProjectDetails project) async {
    await new ProjectsRepo().updateProject(project);
  }

  deleteProject(String projectId) async {
    await new ProjectsRepo().deleteProject(projectId);
  }
}
