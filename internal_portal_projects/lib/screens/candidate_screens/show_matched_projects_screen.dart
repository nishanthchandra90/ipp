import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_inputelements.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/project_details.dart';

import '../show_project_details_screen.dart';

class ShowMatchedProjects extends StatefulWidget {
  final List<ProjectDetails> matchedProjects;

  const ShowMatchedProjects(this.matchedProjects);

  @override
  State<StatefulWidget> createState() =>
      ShowMatchedProjectsState(matchedProjects);
}

class ShowMatchedProjectsState extends State<ShowMatchedProjects> {
  var projects;

  ShowMatchedProjectsState(this.projects);

  double column1Width;
  double column2Width;
  double column3Width;

  @override
  Widget build(BuildContext context) {
    column1Width = MediaQuery.of(context).size.width * 0.25;
    column2Width = MediaQuery.of(context).size.width * 0.4;
    column3Width = MediaQuery.of(context).size.width * 0.25;
    return Scaffold(body: Center(child: _buildScreen()));
  }

  _buildScreen() {
    if (projects.isEmpty) {
      return IPPText.simpleText('No Matched Projects found!');
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ListTile(
              leading: Container(
                  width: column1Width,
                  child: IPPText.simpleText("Project Id",
                      fontSize: 18, fontWeight: FontWeight.bold)),
              title: Container(
                  width: column2Width,
                  child: IPPText.simpleText("Location",
                      fontSize: 17, fontWeight: FontWeight.bold)),
              trailing: Container(
                  width: column3Width,
                  child: IPPText.simpleText("Actions",
                      fontSize: 18, fontWeight: FontWeight.bold))),
          new Expanded(child: _createProjectList(projects)),
        ]);
  }

  _createProjectList(List<ProjectDetails> projects) {
    return Container(
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
            width: column2Width,
            child: IPPText.simpleText(project.currLocation)),
        trailing: Container(
          width: column3Width,
          child: IPPInputs.formButton('Apply',
              color: Colors.blue, onPressed: () => {}),
        ));
  }
}
