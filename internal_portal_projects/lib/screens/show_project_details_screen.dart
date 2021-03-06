import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/project_details.dart';

class ShowProjectScreen extends StatefulWidget {
  final ProjectDetails project;

  ShowProjectScreen(this.project);

  @override
  State<StatefulWidget> createState() => ShowProjectState(project);
}

class ShowProjectState extends State<ShowProjectScreen> {
  final ProjectDetails project;

  ShowProjectState(this.project);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: BackButton(onPressed: () => Navigator.pop(context)),
            title: IPPText.simpleText('Project Details',
                fontSize: 22.0, fontWeight: FontWeight.bold)),
        body: _displayProjectDetails(project));
  }

  Widget _displayProjectDetails(ProjectDetails project) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 50, 2, 0),
      child: new SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            _createRow("Account", project.projectName.toUpperCase()),
            SizedBox(
              height: 20,
            ),
            _createRow("Project Id", project.projectId.toUpperCase()),
            SizedBox(
              height: 20,
            ),
            _createRow("Manager", project.managerName.toUpperCase()),
            SizedBox(
              height: 20,
            ),
            _createRow("Description", project.description, tooLong: true),
            SizedBox(
              height: 20,
            ),
            _createRow("Primary Skill", project.platform),
            _createRow("", project.platformName),
            SizedBox(
              height: 20,
            ),
            _createRow("Expertise", project.expertise),
            SizedBox(
              height: 20,
            ),
            _createRow("Duration", project.tenure),
            SizedBox(
              height: 20,
            ),
            _createRow("Location", project.currLocation),
            _createRow("", project.building ?? ''),
          ])),
    );
  }

  _createRow(String fieldName, String fieldVal, {tooLong: false}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: IPPText.simpleText(fieldName,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue)),
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              child: IPPText.simpleText(fieldVal,
                  fontSize: 16,
                  overflow: tooLong ? TextOverflow.fade : TextOverflow.visible),
            )
          ],
        ));
  }
}
