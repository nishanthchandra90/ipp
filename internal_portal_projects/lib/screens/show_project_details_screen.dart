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
            leading: BackButton(onPressed: () => Navigator.pop(context)),
            title: IPPText.simpleText('Project Details',
                fontSize: 22.0, fontWeight: FontWeight.bold)),
        body: _displayProjectDetails(project));
  }

  Widget _displayProjectDetails(ProjectDetails project) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 70, 10, 0),
      child: new SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            _createRow("Name", project.projectName.toUpperCase()),
            SizedBox(
              height: 30,
            ),
            _createRow("Project Id", project.projectId.toUpperCase()),
            SizedBox(
              height: 30,
            ),
            _createRow("Manager", project.managerName.toUpperCase()),
            SizedBox(
              height: 30,
            ),
            _createRow("Description", project.description),
            SizedBox(
              height: 30,
            ),
            _createRow("Skill Sets", project.skills.toString()),
            SizedBox(
              height: 30,
            ),
            _createRow("Duration", project.tenure)
          ])),
    );
  }
}

_createRow(String fieldName, String fieldVal) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IPPText.simpleText(fieldName,
          fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue),
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
