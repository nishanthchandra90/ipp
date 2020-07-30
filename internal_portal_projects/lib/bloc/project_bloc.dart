import 'dart:async';

import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/service/PMServiceDevice.dart';
import 'package:internal_portal_projects/service/project_manage_service.dart';

class ProjectsBloc {
  ProjectsBloc() {
    getProjects();
  }

  final _projectController = StreamController<List<ProjectDetails>>.broadcast();

  final _matchedProjectsController =
      StreamController<List<ProjectDetails>>.broadcast();

  get allProjects => _projectController.stream;

  get matchedProjects => _matchedProjectsController.stream;

  dispose() {
    _projectController.close();
    _matchedProjectsController.close();
  }

//  getProjects() async {
//    _projectController.sink.add(await PMServiceDevice().getAllProjects());
//  }

  getProjects() async {
    _projectController.sink
        .add(await ProjectManagementService().getAllProjects());
  }

  getMatchedProjects(String skills) async {
    _matchedProjectsController.sink
        .add(await ProjectManagementService().getMatchedProjects(skills));
  }

  add(ProjectDetails project) {
    PMServiceDevice().newProject(project);
    getProjects();
  }

  edit(ProjectDetails project) {
    PMServiceDevice().updateProject(project);
    getProjects();
  }

  delete(String projectId) {
    PMServiceDevice().deleteProject(projectId);
    getProjects();
  }
}
