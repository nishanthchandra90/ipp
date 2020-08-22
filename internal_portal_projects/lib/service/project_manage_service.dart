import 'dart:convert';

import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/model/primary_skill_details.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/repo/projects_repo.dart';

class ProjectManagementService {
  static getAllProjects() async {
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

  static newProject(ProjectDetails project) async {
    await new ProjectsRepo().newProject(project);
  }

  static updateProject(ProjectDetails project) async {
    await new ProjectsRepo().updateProject(project);
  }

  static deleteProject(String projectId) async {
    await new ProjectsRepo().deleteProject(projectId);
  }

  static getProjectApplications() async {
    var response = await new ProjectsRepo().getProjectApplications();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      if (reply.length < 5) {
        return [];
      }
      final decoded = _decodeResponse(reply);
      return decoded
          .map<ProjectApplications>((j) => ProjectApplications.fromJson(j))
          .toList();
    }
    return <ProjectApplications>[];
  }

  static getPrimaryPlatforms() async {
    var response = await new ProjectsRepo().getPrimaryPlatforms();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      if (reply.isEmpty) {
        return [];
      }
      final decoded = _decodeResponse(reply);
      return decoded
          .map<PrimarySkill>((json) => PrimarySkill.fromJson(json))
          .toList();
    }
    return [];
  }

  static _decodeResponse(String responseBody) {
    return json.decode(responseBody).cast<Map<String, dynamic>>();
  }
}
