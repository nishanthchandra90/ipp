import 'dart:async';

import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/repo/projects_repo.dart';

class ProjectsBloc {
  ProjectsBloc() {
    getProjects();
  }

  final _projectController = StreamController<List<ProjectDetails>>.broadcast();

  dispose() {
    _projectController.close();
  }

  getProjects() async {
    _projectController.sink.add(await ProjectsRepo().getAllProjects());
  }

  get projects => _projectController.stream;

  add(ProjectDetails project) {
    ProjectsRepo().newProject(project);
    getProjects();
  }

  edit(ProjectDetails project) {
    ProjectsRepo().updateProject(project);
    getProjects();
  }

  delete(String projectId) {
    ProjectsRepo().deleteProject(projectId);
    getProjects();
  }
}
