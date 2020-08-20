import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _createProjectList()));
  }

  _createProjectList() {
    if (projects.isEmpty) {
      return IPPText.simpleText('No Matched Projects found!');
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
        trailing: Container(
          height: 30,
          width: 70,
          color: Colors.blue,
          child: FlatButton(
            onPressed: () {},
            child: Text('Apply'),
          ),
        ));
  }
}
