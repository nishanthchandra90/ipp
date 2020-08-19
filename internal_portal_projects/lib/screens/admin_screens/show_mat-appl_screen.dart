import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/potential_candidates.dart';

class ShowMatchApplication extends StatefulWidget {
  final PotentialCandidates potentialCandidates;

  ShowMatchApplication(this.potentialCandidates);

  @override
  State<StatefulWidget> createState() => ShowProjectState(potentialCandidates);
}

class ShowProjectState extends State<ShowMatchApplication> {
  final PotentialCandidates potentialCandidates;

  ShowProjectState(this.potentialCandidates);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(onPressed: () => Navigator.pop(context)),
            title: IPPText.simpleText('Potential Candidates',
                fontSize: 22.0, fontWeight: FontWeight.bold)),
        body: _displayPotentialCandidates(potentialCandidates));
  }

  Widget _displayPotentialCandidates(PotentialCandidates potentialCandidates) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _createRow("Name", potentialCandidates.projectName.toUpperCase()),
            SizedBox(
              height: 10,
            ),
            _createRow("Project Id", potentialCandidates.projectId),
            SizedBox(
              height: 30,
            ),
            IPPText.simpleText("Applied Candidates",
                color: Colors.blueGrey, fontSize: 20),
            _createCandidateList(potentialCandidates.appliedCandidates),
            IPPText.simpleText("Matched Candidates",
                color: Colors.blueGrey, fontSize: 20),
            _createCandidateList(potentialCandidates.matchedCandidates),
          ],
        ));
  }

  _createCandidateList(List<dynamic> appliedCandidates) {
    List<String> candidateNames = List<String>.from(appliedCandidates);
    return Flexible(
        child: ListView.builder(
            padding: const EdgeInsets.all(2),
            itemCount: candidateNames.length,
            itemBuilder: (BuildContext _context, int index) {
              String employee = candidateNames[index];
              return Container(
                child: InkWell(
                  child: _createListItem(employee),
                ),
              );
            }));
  }

  _createListItem(String employee) {
    return ListTile(
      leading: IPPText.simpleText(employee.toUpperCase(), fontSize: 20.0),
      trailing: IconButton(
        icon: Icon(Icons.done),
        iconSize: 30.0,
        onPressed: () => {print('cliked')},
      ),
    );
  }

  _createRow(String fieldName, String fieldVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IPPText.simpleText(fieldName,
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
        SizedBox(
          width: 50,
        ),
        Expanded(
            child: IPPText.simpleText(
          fieldVal,
          fontSize: 20,
        )),
      ],
    );
  }
}
