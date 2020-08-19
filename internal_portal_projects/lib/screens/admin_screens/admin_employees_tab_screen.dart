import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/employee_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/screens/admin_screens/show_employee_detail.dart';

class EmployeesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  final bloc = EmployeeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
    );
  }

  _buildScreen() {
    return Container(
      child: StreamBuilder(
        stream: bloc.employees,
        builder: (BuildContext context,
            AsyncSnapshot<List<EmployeeDetails>> snapshot) {
          if (snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Expanded(child: _createEmployeeList(snapshot.data)),
                ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  _createEmployeeList(List<EmployeeDetails> employees) {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        child: new ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: employees.length,
          itemBuilder: (BuildContext _context, int index) {
            EmployeeDetails employee = employees[index];
            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ShowEmployeeScreen(employee))),
              child: _displayEmployees(employee),
            );
          },
          separatorBuilder: (BuildContext _context, int index) => const Divider(
            thickness: 1,
          ),
        ));
  }

  Widget _displayEmployees(EmployeeDetails employeeDetails) {
    if (employeeDetails.employeeId == 'admin') {
      return Container();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _createRow(
            employeeDetails.empName.toUpperCase(), employeeDetails.employeeId),
        SizedBox(
          height: 10,
        ),
        _createRow('', employeeDetails.currLocation.toUpperCase()),
      ],
    );
  }

  _createRow(String fieldName, String fieldVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IPPText.simpleText(fieldName,
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
        SizedBox(
          width: 30,
        ),
        IPPText.simpleText(
          fieldVal,
        ),
      ],
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
