import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/candidate_details.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

import 'applied_candidates.dart';
import 'matched_candidates.dart';

class ApplicationAndMatchesScreen extends StatefulWidget {
  final ProjectApplications potentialCandidates;

  ApplicationAndMatchesScreen(this.potentialCandidates);

  @override
  State<StatefulWidget> createState() =>
      ApplicationAndMatchesScreenState(potentialCandidates);
}

class ApplicationAndMatchesScreenState
    extends State<ApplicationAndMatchesScreen> {
  final ProjectApplications potentialCandidates;
  final _currentPageNotifier = ValueNotifier<int>(0);

  ApplicationAndMatchesScreenState(this.potentialCandidates);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(onPressed: () => Navigator.pop(context)),
            title: IPPText.simpleText('Applications and Matches',
                fontSize: 22.0, fontWeight: FontWeight.bold)),
        body: _buildPageBar());
  }

  _buildPageBar() {
    String projectId = potentialCandidates.project.projectId;
    List<CandidateDetails> appliedCandidates = potentialCandidates
        .appliedCandidates
        .map((i) => CandidateDetails.fromJson(i))
        .toList();
    List<CandidateDetails> matchedCandidates = potentialCandidates
        .matchedCandidates
        .map((i) => CandidateDetails.fromJson(i))
        .toList();
    return new Column(
      children: <Widget>[
        _createProjectSection(),
        Expanded(
            child: new PageView(
          children: <Widget>[
            ShowAppliedScreen(projectId, appliedCandidates),
            ShowMatchedScreen(projectId, matchedCandidates),
          ],
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          },
        )),
        _pageViewIndicators(),
      ],
    );
  }

  _pageViewIndicators() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 10),
      child: CirclePageIndicator(
        itemCount: 2,
        selectedDotColor: Colors.deepOrangeAccent,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }

  _createProjectSection() {
    ProjectDetails project = potentialCandidates.project;
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _createRow("Project Id", project.projectId.toUpperCase()),
              _createRow("Primary Skill", project.platform),
              _createRow("Location", project.currLocation),
              _createRow("", project.building ?? ''),
            ]));
  }

  _createRow(String fieldName, String fieldVal) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IPPText.simpleText(fieldName,
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
            IPPText.simpleText(
              fieldVal,
            )
          ],
        ));
  }
}
