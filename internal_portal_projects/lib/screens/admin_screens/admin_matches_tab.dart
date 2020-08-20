import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/project_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/screens/admin_screens/applicatoins_matches_detail_screen.dart';

class MatchesTabScreen extends StatefulWidget {
  final List<ProjectApplications> projectApplications;

  const MatchesTabScreen(this.projectApplications);

  @override
  State<StatefulWidget> createState() =>
      _MatchesTabScreenState(projectApplications);
}

class _MatchesTabScreenState extends State<MatchesTabScreen> {
  final List<ProjectApplications> projectApplications;
  final bloc = ProjectsBloc();

  _MatchesTabScreenState(this.projectApplications);

  @override
  Widget build(BuildContext context) {
    bloc.getProjectApplications();

    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          new Expanded(child: _createProjectList()),
        ]));
  }

  _createProjectList() {
    return new ListView.separated(
      padding: const EdgeInsets.all(5),
      itemCount: projectApplications.length,
      itemBuilder: (BuildContext _context, int index) {
        ProjectApplications projectApplication = projectApplications[index];
        return Container(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            child: _createListItem(projectApplication),
            onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new ApplicationAndMatchesScreen(projectApplication))),
          ),
        );
      },
      separatorBuilder: (BuildContext _context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  Widget _createListItem(ProjectApplications projectApplication) {
    Widget projId = IPPText.simpleText(
        'Project ' + projectApplication.project.projectId,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.blue);
    Widget projLoc = IPPText.simpleText(projectApplication.project.currLocation,
        fontSize: 15);
    Widget matched = IPPText.simpleText(
        'Matched: ' + projectApplication.matchedCandidates.length.toString(),
        fontWeight: FontWeight.bold,
        color: Colors.green);
    Widget applied = IPPText.simpleText(
        'Applied: ' + projectApplication.appliedCandidates.length.toString(),
        fontWeight: FontWeight.bold,
        color: Colors.orange);
    Widget skills = Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: IPPText.simpleText(
            'Primary Skill: ' +
                projectApplication.project.platform +
                ' (' +
                projectApplication.project.platformName +
                ')',
            fontWeight: FontWeight.bold,
            fontSize: 15));
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _createList(projId, projLoc),
          _createRow([skills]),
          _createRow([applied, matched])
        ]);
  }

  _createList(Widget projId, Widget projLoc) {
    return Container(
      height: 50,
      child: ListTile(
        leading: projId,
        title: projLoc,
      ),
    );
  }

  _createRow(List<Widget> widgets) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widgets,
        ));
  }
}
