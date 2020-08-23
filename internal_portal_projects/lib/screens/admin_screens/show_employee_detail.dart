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
            centerTitle: true,
            leading: BackButton(onPressed: () => Navigator.pop(context)),
            title: IPPText.simpleText('Employee Details',
                fontSize: 22.0, fontWeight: FontWeight.bold)),
        body: _displayEmployeeDetails(employee));
  }

  Widget _displayEmployeeDetails(EmployeeDetails employee) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 50, 2, 0),
      child: new SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            _createRow(
              "Name",
              employee.empName.toUpperCase(),
            ),
            SizedBox(
              height: 20,
            ),
            _createRow("Employee Id", employee.employeeId.toUpperCase()),
            SizedBox(
              height: 20,
            ),
            _createRow("Email", employee.email),
            SizedBox(
              height: 20,
            ),
            _createRow(
                "Experience",
                employee.expYears.toString() +
                    ' Yr(s), ' +
                    employee.expMonths.toString() +
                    ' Mn(s)'),
            SizedBox(
              height: 20,
            ),
            _createRow("Current Location",
                employee.building + '\n' + employee.currLocation),
            SizedBox(
              height: 20,
            ),
            _createRow("Primary Skills",
                employee.platform + '-' + employee.platformName),
            SizedBox(
              height: 20,
            ),
            _createRow("Expertise", employee.expertise),
            SizedBox(
              height: 20,
            ),
            _createRow(
                "Certificates",
                employee.certificates.isEmpty
                    ? '- - - '
                    : employee.certificates),
          ])),
    );
  }

  _createRow(String fieldName, String fieldVal) {
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
                child: IPPText.simpleText(
                  fieldVal,
                  fontSize: 16,
                ))
          ],
        ));
  }
}
