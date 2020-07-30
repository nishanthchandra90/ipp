import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/employee_details.dart';

class ShowEmployeeScreen extends StatefulWidget {
  final EmployeeDetails employee;

  ShowEmployeeScreen(this.employee);

  @override
  State<StatefulWidget> createState() => ShowEmployeeState(employee);
}

class ShowEmployeeState extends State<ShowEmployeeScreen> {
  final EmployeeDetails employee;

  ShowEmployeeState(this.employee);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(onPressed: () => Navigator.pop(context)),
            title: IPPText.simpleText('Employee Details',
                fontSize: 22.0, fontWeight: FontWeight.bold)),
        body: _displayEmployeeDetails(employee));
  }

  Widget _displayEmployeeDetails(EmployeeDetails employee) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 70, 10, 0),
      child: new SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            _createRow("Name", employee.employeeName.toUpperCase()),
            SizedBox(
              height: 30,
            ),
            _createRow("Employee Id", employee.employeeId.toUpperCase()),
            SizedBox(
              height: 30,
            ),
            _createRow("Manager", employee.email),
            SizedBox(
              height: 30,
            ),
            _createRow("Admin", employee.isAdmin ? 'Yes' : 'No'),
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
