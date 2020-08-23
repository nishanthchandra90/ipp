import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/employee_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/screens/admin_screens/show_employee_detail.dart';

class EmployeesTabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployeesTabScreenState();
}

class _EmployeesTabScreenState extends State<EmployeesTabScreen> {
  final bloc = EmployeeBloc();
  double column1Width;
  double column2Width;
  double column3Width;

  @override
  Widget build(BuildContext context) {
    column1Width = MediaQuery.of(context).size.width * 0.25;
    column2Width = MediaQuery.of(context).size.width * 0.4;
    column3Width = MediaQuery.of(context).size.width * 0.25;
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
                  ListTile(
                    leading: Container(
                        width: column1Width,
                        child: IPPText.simpleText("Name",
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    title: Container(
                        width: column2Width,
                        child: IPPText.simpleText("Emp Id",
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    trailing: Container(
                        width: column3Width,
                        child: IPPText.simpleText("Location",
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
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
        width: MediaQuery.of(context).size.width,
        child: new ListView.separated(
          itemCount: employees.length,
          itemBuilder: (BuildContext _context, int index) {
            EmployeeDetails employee = employees[index];
            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ShowEmployeeScreen(employee))),
              child: _displayEmployeeItem(employee),
            );
          },
          separatorBuilder: (BuildContext _context, int index) => const Divider(
            thickness: 1,
          ),
        ));
  }

  Widget _displayEmployeeItem(EmployeeDetails employeeDetails) {
    if (employeeDetails.isAdmin) {
      return SizedBox();
    }
    return ListTile(
      leading: Container(
          width: column1Width,
          child: IPPText.simpleText(employeeDetails.empName.toUpperCase(),
              color: Colors.blue)),
      title: Container(
          width: column2Width,
          child: IPPText.simpleText(employeeDetails.employeeId,
              fontSize: 15, overflow: TextOverflow.fade)),
      trailing: Container(
          width: column3Width,
          child:
              IPPText.simpleText(employeeDetails.currLocation, fontSize: 15)),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
