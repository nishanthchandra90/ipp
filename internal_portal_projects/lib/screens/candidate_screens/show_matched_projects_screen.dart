import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/project_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/project_details.dart';

import '../show_project_details_screen.dart';

class ShowMatchedProjects extends StatefulWidget {
  final String empId;

  const ShowMatchedProjects(this.empId);

  @override
  State<StatefulWidget> createState() => ShowMatchedProjectsState(empId);
}

class ShowMatchedProjectsState extends State<ShowMatchedProjects> {
  final bloc = ProjectsBloc();
  String empId;

  ShowMatchedProjectsState(this.empId);

  @override
  Widget build(BuildContext context) {
    bloc.getMatchedProjects(empId);
    return Scaffold(body: _buildScreen());
  }

  _buildScreen() {
    return Container(
      child: StreamBuilder(
        stream: bloc.matchedProjects,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProjectDetails>> snapshot) {
          if (snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Expanded(child: _createProjectList(snapshot.data)),
                ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  _createProjectList(List<ProjectDetails> projects) {
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
