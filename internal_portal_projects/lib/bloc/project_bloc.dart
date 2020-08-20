import 'dart:async';

import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/service/project_manage_service.dart';

class ProjectsBloc {
  ProjectsBloc() {
    getProjects();
  }

  final _projectController = StreamController<List<ProjectDetails>>.broadcast();

  final _matchedProjectsController =
      StreamController<List<ProjectDetails>>.broadcast();

  final _appliedProjectsController =
      StreamController<List<ProjectDetails>>.broadcast();

  final _confirmedProjectsController =
      StreamController<List<ProjectDetails>>.broadcast();

  final _projectApplicationsController =
      StreamController<List<ProjectApplications>>.broadcast();

  get allProjects => _projectController.stream;

  get matchedProjects => _matchedProjectsController.stream;

  get appliedProjects => _appliedProjectsController.stream;

  get confirmedProjects => _confirmedProjectsController.stream;

  get projectApplications => _projectApplicationsController.stream;

  dispose() {
    _projectController.close();
    _matchedProjectsController.close();
    _appliedProjectsController.close();
    _projectApplicationsController.close();
    _confirmedProjectsController.close();
  }

  getProjects() async {
    _projectController.sink
        .add(await ProjectManagementService.getAllProjects());
  }

  getMatchedProjects(String empId) async {
    _matchedProjectsController.sink
        .add(await ProjectManagementService.getMatchedProjects(empId));
  }

  getAppliedProjects(String empId) async {
    _appliedProjectsController.sink
        .add(await ProjectManagementService.getAppliedProjects(empId));
  }

  getConfirmedProjects(String empId) async {
    _confirmedProjectsController.sink
        .add(await ProjectManagementService.getConfirmedProjects(empId));
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
