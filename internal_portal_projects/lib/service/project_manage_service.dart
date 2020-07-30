import 'dart:convert';

import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/repo/projects_repo.dart';

class ProjectManagementService {
  getMatchedProjects(String skills) async {
//    return await new ProjectsRepo().postMatchRate(skills);
  }

  getAllProjects() async {
    var response = await new ProjectsRepo().getAllProjects();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      return _parseProjects(reply);
    }
    return Iterable.empty();
  }

  List<ProjectDetails> _parseProjects(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ProjectDetails>((json) => ProjectDetails.fromJson(json))
        .toList();
  }
}
