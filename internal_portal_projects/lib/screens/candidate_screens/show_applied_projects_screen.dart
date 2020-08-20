import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/project_details.dart';

import '../show_project_details_screen.dart';

class ShowAppliedProjects extends StatefulWidget {
  final List<ProjectDetails> appliedProjects;

  const ShowAppliedProjects(this.appliedProjects);

  @override
  State<StatefulWidget> createState() =>
      ShowAppliedProjectsState(appliedProjects);
}

class ShowAppliedProjectsState extends State<ShowAppliedProjects> {
  List<ProjectDetails> projects;

  ShowAppliedProjectsState(this.projects);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _createProjectList());
  }

  _createProjectList() {
    if (projects.isEmpty) {
      return Center(child: IPPText.simpleText('No applications found!'));
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
          color: Colors.red,
          child: FlatButton(
            onPressed: () {
              setState(() {
                projects.remove(project);
              });
            },
            child: Text('Withdraw'),
          ),
        ));
  }
}
