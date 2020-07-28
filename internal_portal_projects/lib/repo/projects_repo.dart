import 'package:internal_portal_projects/db/database.dart';
import 'package:internal_portal_projects/model/project_details.dart';

class ProjectsRepo {
  newProject(ProjectDetails newProject) async {
    final db = await DBProvider.db.database;
    var res = await db.insert("Project", newProject.toJson());
    return res;
  }
}
