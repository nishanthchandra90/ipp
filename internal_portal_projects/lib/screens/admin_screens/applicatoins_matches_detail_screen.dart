import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/model/project_details.dart';

class ApplicationAndMatchesScreen extends StatefulWidget {
  final PotentialCandidates potentialCandidates;

  ApplicationAndMatchesScreen(this.potentialCandidates);

  @override
  State<StatefulWidget> createState() =>
      ApplicationAndMatchesScreenState(potentialCandidates);
}

class ApplicationAndMatchesScreenState
    extends State<ApplicationAndMatchesScreen> {
  final PotentialCandidates potentialCandidates;

  ApplicationAndMatchesScreenState(this.potentialCandidates);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(onPressed: () => Navigator.pop(context)),
            title: IPPText.simpleText('Potential Candidates',
                fontSize: 22.0, fontWeight: FontWeight.bold)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _createProjectSection(),
            IPPText.simpleText("Applied Candidates",
                color: Colors.blue, fontSize: 20),
            _createCandidateList(potentialCandidates.appliedCandidates),
            IPPText.simpleText("Matched Candidates",
                color: Colors.deepOrange, fontSize: 20),
            _createCandidateList(potentialCandidates.matchedCandidates),
          ],
        ));
  }

  _createCandidateList(List<dynamic> appliedCandidates) {
    List<EmployeeDetails> candidates =
        appliedCandidates.map((i) => EmployeeDetails.fromJson(i)).toList();
    return Expanded(
        child: new ListView.separated(
      itemCount: candidates.length,
      itemBuilder: (BuildContext _context, int index) {
        EmployeeDetails employee = candidates[index];
        return ListTile(
          leading: IPPText.simpleText(employee.email.toLowerCase()),
          title: IPPText.simpleText(employee.empName.toUpperCase()),
          trailing: IconButton(
            icon: Icon(Icons.done),
            iconSize: 25.0,
            onPressed: () => {print('cliked')},
          ),
        );
      },
      separatorBuilder: (BuildContext _context, int index) => const Divider(
        thickness: 1,
      ),
    ));
  }

  _createProjectSection() {
    ProjectDetails project = potentialCandidates.project;
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _createRow("Name", project.projectName.toUpperCase()),
              _createRow("Project Id", project.projectId.toUpperCase()),
              _createRow("Primary Skill", project.platform),
              _createRow("", project.platformName),
              _createRow("Skills", project.skills.join(", ")),
              _createRow("Location", project.currLocation),
              _createRow("", project.building ?? ''),
            ]));
  }

  _createRow(String fieldName, String fieldVal) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IPPText.simpleText(fieldName,
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
            IPPText.simpleText(
              fieldVal,
              fontSize: 16,
            )
          ],
        ));
  }
}
