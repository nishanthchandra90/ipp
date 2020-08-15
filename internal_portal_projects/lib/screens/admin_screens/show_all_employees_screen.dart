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
    return new ListView.separated(
      padding: const EdgeInsets.all(2),
      itemCount: employees.length,
      itemBuilder: (BuildContext _context, int index) {
        EmployeeDetails employee = employees[index];
        return Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            child: _createListItem(employee),
          ),
        );
      },
      separatorBuilder: (BuildContext _context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  _createListItem(EmployeeDetails employee) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new ShowEmployeeScreen(employee))),
      leading: IPPText.simpleText(
          employee.empFName.toUpperCase() + employee.empLName.toUpperCase(),
          fontSize: 20.0),
      title: Container(width: 40, child: Text(employee.employeeId)),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
