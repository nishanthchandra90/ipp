import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/project_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_widget.dart';
import 'package:internal_portal_projects/model/candidate_details.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/screens/admin_screens/admin_employees_tab_screen.dart';
import 'package:internal_portal_projects/screens/admin_screens/admin_projects_tab_screen.dart';
import 'package:internal_portal_projects/screens/candidate_screens/show_confirmed_projects_screen.dart';
import 'package:internal_portal_projects/screens/candidate_screens/show_matched_projects_screen.dart';

import 'admin_screens/admin_matches_tab.dart';
import 'candidate_screens/show_applied_projects_screen.dart';

class MyHomePage extends StatelessWidget {
  final EmployeeDetails employee;
  DateTime currentBackPressTime;

  MyHomePage({Key key, this.title, this.employee}) : super(key: key);

  final String title;

  final bloc = ProjectsBloc();

  @override
  Widget build(BuildContext context) {
    bloc.getProjectApplications();
    var tabs = employee.isAdmin
        ? IPPWidget.createAdminTabs()
        : IPPWidget.createEmployeeTabs();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: IPPWidget.appBar(tabs),
        body: WillPopScope(
            onWillPop: onWillPop,
            child: StreamBuilder(
              stream: bloc.projectApplications,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProjectApplications>> snapshot) {
                List<ProjectApplications> projectApplications = snapshot.data;
                if (snapshot.hasData) {
                  String empId = employee.employeeId;
                  var matchedProjects =
                      _createMatchedProjects(projectApplications, empId);
                  var appliedProjects =
                      _createAppliedProjects(projectApplications, empId);
                  var confirmedProjects =
                      _createConfirmedProjects(projectApplications, empId);
                  return TabBarView(
                    children: employee.isAdmin
                        ? [
                            ProjectsTabScreen(),
                            MatchesTabScreen(projectApplications),
                            EmployeesTabScreen()
                          ]
                        : [
                            ShowMatchedProjects(matchedProjects),
                            ShowAppliedProjects(appliedProjects),
                            ShowConfirmedProjects(
                                confirmedProjects) //13,24,22,12,01
                          ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )),
        drawer: IPPWidget.createDrawer(context, employee),
      ),
    );
  }

  _createMatchedProjects(
      List<ProjectApplications> projectApplications, String empId) {
    List<ProjectDetails> matchedProjects = [];
    projectApplications.forEach((element) {
      _dynamicToClass(element.matchedCandidates).forEach((candidateDetail) {
        if (candidateDetail.employee.employeeId == empId) {
          matchedProjects.add(element.project);
        }
      });
    });
    return matchedProjects;
  }

  _createAppliedProjects(
      List<ProjectApplications> projectApplications, String empId) {
    List<ProjectDetails> appliedProjects = [];
    projectApplications.forEach((element) {
      _dynamicToClass(element.appliedCandidates).forEach((candidateDetail) {
        if (candidateDetail.employee.employeeId == empId) {
          appliedProjects.add(element.project);
        }
      });
    });
    return appliedProjects;
  }

  _createConfirmedProjects(
      List<ProjectApplications> projectApplications, String empId) {
    List<ProjectDetails> confirmedProjects = [];
    projectApplications.forEach((element) {
      _dynamicToClass(element.confirmedCandidates).forEach((candidateDetail) {
        if (candidateDetail.employee.employeeId == empId) {
          confirmedProjects.add(element.project);
        }
      });
    });
    return confirmedProjects;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
  }
}

List<CandidateDetails> _dynamicToClass(List<dynamic> dynamics) {
  return dynamics.map((i) => CandidateDetails.fromJson(i)).toList();
}
