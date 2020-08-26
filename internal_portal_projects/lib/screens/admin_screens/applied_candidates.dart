import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/candidate_details.dart';
import 'package:internal_portal_projects/repo/projects_repo.dart';

class ShowAppliedScreen extends StatefulWidget {
  final List<CandidateDetails> appliedCandidates;
  final String projectId;

  const ShowAppliedScreen(this.projectId, this.appliedCandidates);

  @override
  State<StatefulWidget> createState() =>
      ShowAppliedScreenState(projectId, appliedCandidates);
}

class ShowAppliedScreenState extends State<ShowAppliedScreen> {
  final List<CandidateDetails> appliedCandidates;
  final String projectId;

  ShowAppliedScreenState(this.projectId, this.appliedCandidates);

  double column1Width;
  double column2Width;
  double column3Width;

  @override
  Widget build(BuildContext context) {
    column1Width = MediaQuery.of(context).size.width * 0.5;
    column2Width = MediaQuery.of(context).size.width * 0.15;
    column3Width = MediaQuery.of(context).size.width * 0.15;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IPPText.simpleText("Applied Candidates",
              color: Colors.blue, fontSize: 20),
          ListTile(
            leading: Container(
                width: column1Width,
                child: IPPText.simpleText("Employee",
                    fontSize: 18, fontWeight: FontWeight.bold)),
            title: Container(
                width: column2Width,
                child: IPPText.simpleText("Match",
                    fontSize: 17, fontWeight: FontWeight.bold)),
            trailing: Container(
                width: column3Width,
                child: IPPText.simpleText("Status",
                    fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          _createCandidateList(appliedCandidates),
        ],
      ),
    ));
  }

  _createCandidateList(List<CandidateDetails> candidates) {
    return Expanded(
        child: new ListView.separated(
      itemCount: candidates.length,
      itemBuilder: (BuildContext _context, int index) {
        CandidateDetails candidate = candidates[index];
        return _displayCandidateItem(candidate);
      },
      separatorBuilder: (BuildContext _context, int index) => const Divider(
        thickness: 1,
      ),
    ));
  }

  Widget _displayCandidateItem(CandidateDetails candidate) {
    return ListTile(
        leading: Container(
          width: column1Width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IPPText.simpleText(candidate.employee.empName.toUpperCase(),
                  color: Colors.blue),
              IPPText.simpleText(candidate.employee.email, color: Colors.blue)
            ],
          ),
        ),
        title: Container(width: column2Width, child: IPPText.simpleText('70%')),
        trailing: Container(
          width: column3Width,
          child: IconButton(
            icon: Icon(Icons.done),
            color: candidate.isConfirmed ? Colors.green : Colors.grey,
            iconSize: 25.0,
            onPressed: () => {
              new ProjectsRepo()
                  .confirmCandidate(projectId, candidate.employee.employeeId)
            },
          ),
        ));
  }
}
