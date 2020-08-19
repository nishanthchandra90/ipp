import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/screens/admin_screens/show_all_employees_screen.dart';
import 'package:internal_portal_projects/screens/admin_screens/show_all_projects.dart';
import 'package:internal_portal_projects/screens/candidate_screens/show_matched_projects_screen.dart';
import 'package:internal_portal_projects/service/auth_service.dart';

import 'admin_screens/show_matched_candidates.dart';
import 'candidate_screens/show_applied_projects_screen.dart';
import 'login_screen.dart';

class MyHomePage extends StatelessWidget {
  final EmployeeDetails employee;

  MyHomePage({Key key, this.title, this.employee}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    var tabs = employee.isAdmin ? _createAdminTabs() : _createEmployeeTabs();
    return DefaultTabController(
      length: employee.isAdmin ? 3 : 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            bottom: new PreferredSize(
                preferredSize: new Size(30.0, 30.0),
                child: _createTabBar(tabs)),
            title: IPPText.simpleText("Manage Projects",
                fontSize: 20.0, align: TextAlign.right, color: Colors.white)),
        body: TabBarView(
          children: employee.isAdmin
              ? [Projects(), MatchedCandidates(), EmployeesScreen()]
              : [
                  ShowMatchedProjects(employee.employeeId),
                  ShowAppliedProjects(employee.employeeId),
                ],
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
              child: IPPText.simpleText(employee.empName.toUpperCase(),
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
    return [tab1, tab2];
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
}
