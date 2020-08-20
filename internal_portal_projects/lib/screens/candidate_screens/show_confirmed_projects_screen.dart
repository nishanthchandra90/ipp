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

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _createProjectList());
  }

  _createProjectList() {
    if (projects.isEmpty) {
      return IPPText.simpleText('No Confirmed Projects yet!\n Apply for some!');
    }
    return new ListView.separated(
      padding: const EdgeInsets.all(2),
      itemCount: projects.length,
      itemBuilder: (BuildContext _context, int index) {
        ProjectDetails project = projects[index];
        return Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            child: _createListItem(project),
          ),
        );
      },
      separatorBuilder: (BuildContext _context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  _createListItem(ProjectDetails project) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new ShowProjectScreen(project))),
      leading: IPPText.simpleText(
          project.projectName.toUpperCase() + '\n(' + project.projectId + ')',
          fontSize: 16.0),
      title: IPPText.simpleText(project.currLocation),
    );
  }
}
