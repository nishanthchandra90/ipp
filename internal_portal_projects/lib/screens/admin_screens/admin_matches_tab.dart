import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/candidate_details.dart';
import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/screens/admin_screens/applicatoins_matches_detail_screen.dart';
import 'package:internal_portal_projects/screens/admin_screens/matched_candidates.dart';

import 'applied_candidates.dart';

class MatchesTabScreen extends StatefulWidget {
  final List<ProjectApplications> projectApplications;

  const MatchesTabScreen(this.projectApplications);

  @override
  State<StatefulWidget> createState() =>
      _MatchesTabScreenState(projectApplications);
}

class _MatchesTabScreenState extends State<MatchesTabScreen> {
  final List<ProjectApplications> projectApplications;

  _MatchesTabScreenState(this.projectApplications);

  @override
  Widget build(BuildContext context) {
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
        ProjectDetails project = projectApplication.project;
        List<CandidateDetails> appliedCandidates = projectApplication
            .appliedCandidates
            .map((i) => CandidateDetails.fromJson(i))
            .toList();
        List<CandidateDetails> matchedCandidates = projectApplication
            .matchedCandidates
            .map((i) => CandidateDetails.fromJson(i))
            .toList();
        var applicationAndMatchesScreen = ApplicationAndMatchesScreen(
            project, appliedCandidates, matchedCandidates);
        return Container(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
              child: _createListItem(
                  project, matchedCandidates, appliedCandidates),
              onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => applicationAndMatchesScreen))),
        );
      },
      separatorBuilder: (BuildContext _context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  Widget _createListItem(
      ProjectDetails project,
      List<CandidateDetails> appliedCandidates,
      List<CandidateDetails> matchedCandidates) {
    String projectId = project.projectId;
    var matchedScreen = new ShowMatchedScreen(projectId, matchedCandidates);
    var showAppliedScreen = new ShowAppliedScreen(projectId, appliedCandidates);
    Widget projId = IPPText.simpleText('Project ' + projectId,
        fontWeight: FontWeight.bold, color: Colors.blue);
    Widget projLoc = IPPText.simpleText(project.currLocation, fontSize: 15);
    Widget matched = _clickableText(
        'Matched: ' + matchedCandidates.length.toString(),
        Colors.green,
        matchedScreen);
    Widget applied = _clickableText(
        'Applied: ' + appliedCandidates.length.toString(),
        Colors.deepOrange,
        showAppliedScreen);
    Widget skills = Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: IPPText.simpleText(
            'Primary Skill: ' +
                project.platform +
                ' (' +
                project.platformName +
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

  _clickableText(String text, Color textColor, var screen) {
    return InkWell(
        onTap: () => Navigator.push(
            context, new MaterialPageRoute(builder: (context) => screen)),
        child: IPPText.simpleText(text,
            fontWeight: FontWeight.bold, color: textColor));
  }

  _createList(Widget projId, Widget projLoc) {
    return Container(
      height: 50,
      child: ListTile(
        leading: projId,
        trailing: projLoc,
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
