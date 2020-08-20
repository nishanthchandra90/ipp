import 'dart:async';

import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/service/project_manage_service.dart';

class ProjectsBloc {
  ProjectsBloc() {
    getProjects();
  }

  final _projectController = StreamController<List<ProjectDetails>>.broadcast();

  final _projectApplicationsController =
      StreamController<List<ProjectApplications>>.broadcast();

  get allProjects => _projectController.stream;

  get projectApplications => _projectApplicationsController.stream;

  dispose() {
    _projectController.close();
    _projectApplicationsController.close();
  }

  getProjects() async {
    _projectController.sink
        .add(await ProjectManagementService.getAllProjects());
  }

  getProjectApplications() async {
    _projectApplicationsController.sink
        .add(await ProjectManagementService.getProjectApplications());
  }

  add(ProjectDetails project) {
    ProjectManagementService.newProject(project);
    getProjects();
  }

  edit(ProjectDetails project) {
    ProjectManagementService.updateProject(project);
    getProjects();
  }

  delete(String projectId) {
    ProjectManagementService.deleteProject(projectId);
    getProjects();
  }

  deleteAppliedProject(ProjectDetails project) {
//     appliedProjects.
  }
}
