import 'package:internal_portal_projects/db/database.dart';
import 'package:internal_portal_projects/model/project_details.dart';

class ProjectsRepoDevice {
  newProject(ProjectDetails newProject) async {
    final db = await DBProvider.db.database;
    var res = await db.insert("Project", newProject.toJson());
    return res;
  }

  getAllProjects() async {
    final db = await DBProvider.db.database;
    var res = await db.query("Project");
    List<ProjectDetails> list = res.isNotEmpty && res.length > 0
        ? res.map((c) => ProjectDetails.fromJson(c)).toList()
        : [];
    return list;
  }

  updateProject(ProjectDetails project) async {
    final db = await DBProvider.db.database;
    var res = await db.update("Project", project.toJson(),
        where: "id = ?", whereArgs: [project.projectId]);
    return res;
  }

  deleteProject(String id) async {
    final db = await DBProvider.db.database;
    db.delete("Project", where: "id = ?", whereArgs: [id]);
  }
}
