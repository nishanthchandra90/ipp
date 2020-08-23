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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IPPText.simpleText("Applied Candidates",
              color: Colors.blue, fontSize: 20),
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
        return ListTile(
          leading: IPPText.simpleText(candidate.employee.email.toLowerCase()),
          title: IPPText.simpleText(candidate.employee.empName.toUpperCase()),
          trailing: IconButton(
            icon: Icon(Icons.done),
            color: candidate.isConfirmed ? Colors.green : Colors.grey,
            iconSize: 25.0,
            onPressed: () => {
              new ProjectsRepo()
                  .confirmCandidate(projectId, candidate.employee.employeeId)
            },
          ),
        );
      },
      separatorBuilder: (BuildContext _context, int index) => const Divider(
        thickness: 1,
      ),
    ));
  }
}
