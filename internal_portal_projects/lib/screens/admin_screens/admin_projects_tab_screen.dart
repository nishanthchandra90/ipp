import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/project_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_actionbutton.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/screens/show_project_details_screen.dart';

import 'add_project_screen.dart';

class ProjectsTabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProjectsTabScreenState();
}

class _ProjectsTabScreenState extends State<ProjectsTabScreen> {
  final bloc = ProjectsBloc();

  @override
  Widget build(BuildContext context) {
    Function onAddBtnPressed = () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddProjectScreen(),
            )).then((value) {
          setState(() {
            ProjectsBloc().getProjects();
          });
        });
    return Scaffold(
        body: _buildScreen(),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: IPPActionButton.floatingAddButton(
          onAddBtnPressed,
          'Project',
        ));
  }

  _buildScreen() {
    return Container(
      child: StreamBuilder(
        stream: bloc.allProjects,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProjectDetails>> snapshot) {
          if (snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      onLongPress: () => _bottomSheet(context, project),
      onTap: () => Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new ShowProjectScreen(project))),
      leading: IPPText.simpleText(
          'ProjectId: ' + project.projectId.toUpperCase(),
          fontSize: 18.0),
      title: Container(width: 40, child: Text(project.currLocation.toString())),
    );
  }

  _bottomSheet(BuildContext context, ProjectDetails project) {
    showModalBottomSheet(
        enableDrag: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _editProjectIcon(project),
                  _deleteProjectIcon(project),
                ],
              ));
        });
  }

  _editProjectIcon(ProjectDetails project) {
    return new IconButton(
      icon: Icon(Icons.edit),
      color: Colors.blue,
      onPressed: () => {
        setState(() {}),
        Navigator.pop(context),
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new AddProjectScreen(
                      projectDetails: project,
                    ))).then((value) {
          setState(() {
            ProjectsBloc().getProjects();
          });
        }),
      },
    );
  }

  _deleteProjectIcon(ProjectDetails project) {
    return new IconButton(
      icon: Icon(Icons.delete),
      color: Colors.blue,
      onPressed: () => {
        Navigator.pop(context),
        ProjectsBloc().delete(project.projectId),
        setState(() {
          ProjectsBloc().getProjects();
        }),
      },
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
