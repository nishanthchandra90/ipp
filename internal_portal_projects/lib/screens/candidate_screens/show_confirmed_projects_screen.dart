import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/project_details.dart';

import '../show_project_details_screen.dart';

class ShowConfirmedProjects extends StatefulWidget {
  final List<ProjectDetails> confirmedProjects;

  const ShowConfirmedProjects(this.confirmedProjects);

  @override
  State<StatefulWidget> createState() =>
      ShowConfirmedProjectsState(confirmedProjects);
}

class ShowConfirmedProjectsState extends State<ShowConfirmedProjects> {
  List<ProjectDetails> projects;

  ShowConfirmedProjectsState(this.projects);

  double column1Width;
  double column2Width;
  double column3Width;

  @override
  Widget build(BuildContext context) {
    column1Width = MediaQuery.of(context).size.width * 0.25;
    column2Width = MediaQuery.of(context).size.width * 0.4;
    column3Width = MediaQuery.of(context).size.width * 0.25;
    return Scaffold(body: _buildScreen());
  }

  _buildScreen() {
    if (projects.isEmpty) {
      return Center(
          child: IPPText.simpleText(
              'No Confirmed Projects yet!\n Apply for some!'));
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ListTile(
            leading: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: IPPText.simpleText("Project Id",
                    fontSize: 18, fontWeight: FontWeight.bold)),
            title: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                child: IPPText.simpleText("Location",
                    fontSize: 17, fontWeight: FontWeight.bold)),
          ),
          new Expanded(child: _createProjectList(projects)),
        ]);
  }

  _createProjectList(List<ProjectDetails> projects) {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: new ListView.separated(
          itemCount: projects.length,
          itemBuilder: (BuildContext _context, int index) {
            ProjectDetails project = projects[index];
            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ShowProjectScreen(project))),
              child: _displayProjectItem(project),
            );
          },
          separatorBuilder: (BuildContext _context, int index) => const Divider(
            thickness: 1,
          ),
        ));
  }

  Widget _displayProjectItem(ProjectDetails project) {
    return ListTile(
      leading: Container(
          width: column1Width,
          child: IPPText.simpleText(project.projectId,
              fontWeight: FontWeight.bold, color: Colors.blue)),
      title: Container(
          width: column2Width, child: IPPText.simpleText(project.currLocation)),
    );
  }
}
