import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/project_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/project_details.dart';

import '../show_project_details_screen.dart';

class ShowAppliedProjects extends StatefulWidget {
  final String empId;

  const ShowAppliedProjects(this.empId);

  @override
  State<StatefulWidget> createState() => ShowAppliedProjectsState(empId);
}

class ShowAppliedProjectsState extends State<ShowAppliedProjects> {
  final bloc = ProjectsBloc();
  String empId;

  ShowAppliedProjectsState(this.empId);

  @override
  Widget build(BuildContext context) {
    bloc.getAppliedProjects(empId);
    return Scaffold(body: _buildScreen());
  }

  _buildScreen() {
    return Container(
      child: StreamBuilder(
        stream: bloc.appliedProjects,
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
      leading:
          IPPText.simpleText(project.projectName.toUpperCase(), fontSize: 20.0),
      title: Container(width: 40, child: Text(project.skills.toString())),
      trailing: Container(
        color: Colors.red,
        child: FlatButton(
          onPressed: () {
            bloc.deleteAppliedProject(project);
          },
          child: Text("Withdraw"),
        ),
      ),
    );
  }
}
