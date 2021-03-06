import 'dart:async';

import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/service/employee_service.dart';

class EmployeeBloc {
  EmployeeBloc() {
    getEmployees();
  }

  final _employeesController =
      StreamController<List<EmployeeDetails>>.broadcast();

  dispose() {
    _employeesController.close();
  }

  getEmployees() async {
    _employeesController.sink.add(await EmployeeService.getAllUsers());
  }

  get employees => _employeesController.stream;
}
