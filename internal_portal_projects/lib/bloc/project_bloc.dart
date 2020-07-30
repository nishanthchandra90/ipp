import 'dart:async';

import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/service/PMServiceDevice.dart';
import 'package:internal_portal_projects/service/project_manage_service.dart';

class ProjectsBloc {
  ProjectsBloc() {
    getProjects();
  }

  final _projectController = StreamController<List<ProjectDetails>>.broadcast();

  dispose() {
    _projectController.close();
  }

//  getProjects() async {
//    _projectController.sink.add(await PMServiceDevice().getAllProjects());
//  }

  getProjects() async {
    _projectController.sink.add(await ProjectManagementService().getAllProjects());
  }

  get projects => _projectController.stream;

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
