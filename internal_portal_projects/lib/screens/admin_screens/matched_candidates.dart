import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/employee_details.dart';

class ShowMatchedScreen extends StatefulWidget {
  final List<EmployeeDetails> matchedCandidates;

  const ShowMatchedScreen(this.matchedCandidates);

  @override
  State<StatefulWidget> createState() =>
      ShowMatchedScreenState(matchedCandidates);
}

class ShowMatchedScreenState extends State<ShowMatchedScreen> {
  final List<EmployeeDetails> appliedCandidates;

  ShowMatchedScreenState(this.appliedCandidates);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          IPPText.simpleText("Matched Candidates",
              color: Colors.blue, fontSize: 20),
          _createCandidateList(appliedCandidates),
        ],
      ),
    );
  }

  _createCandidateList(List<EmployeeDetails> candidates) {
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
}
