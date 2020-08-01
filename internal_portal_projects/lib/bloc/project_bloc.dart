import 'dart:async';

import 'package:internal_portal_projects/model/potential_candidates.dart';
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

  final _appliedProjectsController =
      StreamController<List<ProjectDetails>>.broadcast();

  final _applicationsAndMatchesController =
      StreamController<List<PotentialCandidates>>.broadcast();

  get allProjects => _projectController.stream;

  get matchedProjects => _matchedProjectsController.stream;

  get appliedProjects => _appliedProjectsController.stream;

  get potentialCandidates => _applicationsAndMatchesController.stream;

  dispose() {
    _projectController.close();
    _matchedProjectsController.close();
    _appliedProjectsController.close();
    _applicationsAndMatchesController.close();
  }

  getProjects() async {
    _projectController.sink
        .add(await ProjectManagementService().getAllProjects());
  }

  getMatchedProjects(String empId) async {
    _matchedProjectsController.sink
        .add(await ProjectManagementService().getMatchedProjects(empId));
  }

  getAppliedProjects(String empId) async {
    _appliedProjectsController.sink
        .add(await ProjectManagementService().getAppliedProjects(empId));
  }

  getApplicationsAndMatches() async {
    _applicationsAndMatchesController.sink
        .add(await ProjectManagementService().getApplicationsAndMatches());
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

  deleteAppliedProject(ProjectDetails project) {
//     appliedProjects.
  }
}
