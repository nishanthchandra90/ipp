import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/project_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/screens/admin_screens/applicatoins_matches_detail_screen.dart';

class MatchedCandidates extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MatchedCandidateState();
}

class _MatchedCandidateState extends State<MatchedCandidates> {
  final bloc = ProjectsBloc();

  @override
  Widget build(BuildContext context) {
    bloc.getApplicationsAndMatches();

    return Scaffold(body: _displayMatchesAndApplications());
  }

  _displayMatchesAndApplications() {
    return Container(
      child: StreamBuilder(
        stream: bloc.potentialCandidates,
        builder: (BuildContext context,
            AsyncSnapshot<List<PotentialCandidates>> snapshot) {
          if (snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
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

  _createProjectList(List<PotentialCandidates> potentialCandidates) {
    return new ListView.separated(
      padding: const EdgeInsets.all(5),
      itemCount: potentialCandidates.length,
      itemBuilder: (BuildContext _context, int index) {
        PotentialCandidates potentialCandidate = potentialCandidates[index];
        return Container(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            child: _createListItem(potentialCandidate),
            onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new ShowMatchApplication(potentialCandidate))),
          ),
        );
      },
      separatorBuilder: (BuildContext _context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  Widget _createListItem(PotentialCandidates potentialCandidate) {
    Widget projId = IPPText.simpleText(
        'Project ' + potentialCandidate.project.projectId,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.blue);
    Widget projLoc = IPPText.simpleText(potentialCandidate.project.currLocation,
        fontSize: 15);
    Widget matched = IPPText.simpleText(
        'Matched: ' + potentialCandidate.matchedCandidates.length.toString(),
        fontWeight: FontWeight.bold,
        color: Colors.green);
    Widget applied = IPPText.simpleText(
        'Applied: ' + potentialCandidate.appliedCandidates.length.toString(),
        fontWeight: FontWeight.bold,
        color: Colors.orange);
    Widget skills = Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: IPPText.simpleText(
            'Primary Skill: ' +
                potentialCandidate.project.platform +
                ' (' +
                potentialCandidate.project.platformName +
                ')',
            fontWeight: FontWeight.bold,
            fontSize: 15));
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _createList(projId, projLoc),
          _createRow([skills]),
          _createRow([matched, applied])
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
