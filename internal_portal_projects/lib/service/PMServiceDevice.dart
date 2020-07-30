import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/repo/projects_repo_device.dart';

class PMServiceDevice {
  PMServiceDevice() {}

  getAllProjects() async {
    print("Device Service");
    return await ProjectsRepoDevice().getAllProjects();
  }

  newProject(ProjectDetails newProject) async {
    return await ProjectsRepoDevice().newProject(newProject);
  }

  updateProject(ProjectDetails project) async {
    return await ProjectsRepoDevice().updateProject(project);
  }

  deleteProject(String id) async {
    return await ProjectsRepoDevice().deleteProject(id);
  }
}
