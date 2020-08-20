import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/project_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/candidate_details.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/model/potential_candidates.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/screens/admin_screens/admin_employees_tab_screen.dart';
import 'package:internal_portal_projects/screens/admin_screens/admin_projects_tab_screen.dart';
import 'package:internal_portal_projects/screens/candidate_screens/show_confirmed_projects_screen.dart';
import 'package:internal_portal_projects/screens/candidate_screens/show_matched_projects_screen.dart';
import 'package:internal_portal_projects/service/auth_service.dart';

import 'admin_screens/admin_matches_tab.dart';
import 'candidate_screens/show_applied_projects_screen.dart';
import 'login_screen.dart';

class MyHomePage extends StatelessWidget {
  final EmployeeDetails employee;

  MyHomePage({Key key, this.title, this.employee}) : super(key: key);

  final String title;

  final bloc = ProjectsBloc();

  @override
  Widget build(BuildContext context) {
    bloc.getProjectApplications();
    var tabs = employee.isAdmin ? _createAdminTabs() : _createEmployeeTabs();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            bottom: new PreferredSize(
                preferredSize: new Size(30.0, 30.0),
                child: _createTabBar(tabs)),
            title: IPPText.simpleText("Manage Projects",
                fontSize: 20.0, align: TextAlign.right, color: Colors.white)),
        body: StreamBuilder(
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
        ),
        drawer: _createDrawer(context),
      ),
    );
  }

  _createDrawer(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
            color: Colors.indigo,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.4,
            child: Center(
              child: IPPText.simpleText(
                  employee.empName.toUpperCase() +
                      '\n(' +
                      employee.employeeId +
                      ')',
                  fontSize: 22.0),
            )),
        Row(
          children: <Widget>[
            Icon(Icons.power_settings_new),
            FlatButton(
              textColor: Colors.blue,
              child: Text('Logout'),
              onPressed: () async => {
                await AuthService().logout(),
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      settings: RouteSettings(name: "LoginPage"),
                      builder: (BuildContext context) => LoginPage()),
                )
              },
            )
          ],
        ),
      ],
    ));
  }

  _createAdminTabs() {
    Widget tab1 = _createTab(Icons.book, 'Projects');
    Widget tab2 = _createTab(
      Icons.assignment_ind,
      'Matches',
    );
    Widget tab3 = _createTab(
      Icons.group,
      'Employees',
    );
    return [tab1, tab2, tab3];
  }

  _createEmployeeTabs() {
    Widget tab1 = _createTab(Icons.book, 'Matched Projects');
    Widget tab2 = _createTab(
      Icons.assignment_ind,
      'Applied',
    );
    Widget tab3 = _createTab(
      Icons.done,
      'Confirmed',
    );
    return [tab1, tab2, tab3];
  }

  _createTabBar(List<Widget> tabs) {
    return new Container(
        height: 60,
        child: new TabBar(
          indicatorColor: Colors.black,
          tabs: tabs,
        ));
  }

  _createTab(IconData icon, String text) {
    return Tab(
      icon: Icon(
        icon,
        size: 20,
      ),
      text: text,
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
}

List<CandidateDetails> _dynamicToClass(List<dynamic> dynamics) {
  return dynamics.map((i) => CandidateDetails.fromJson(i)).toList();
}
