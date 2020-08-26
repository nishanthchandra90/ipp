import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/screens/candidate_screens/employee_signup_screen.dart';
import 'package:internal_portal_projects/screens/login_screen.dart';
import 'package:internal_portal_projects/service/auth_service.dart';

class IPPWidget {
  static createDrawer(BuildContext context, EmployeeDetails employee) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Center(
                    child: IPPText.simpleText(employee.empName),
                  ),
                ),
                FlatButton(
                  child: IPPText.simpleText('Edit Profile', fontWeight: 20.0),
                  onPressed: () async => {
                    await AuthService().logout(),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          settings: RouteSettings(name: "register"),
                          builder: (BuildContext context) =>
                              EmployeeSignUpScreen(employee: employee)),
                    )
                  },
                )
              ]),
        ),
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

  static createAdminTabs() {
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

  static createEmployeeTabs() {
    Widget tab1 = _createTab(Icons.book, 'Matched');
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

  static _createTab(IconData icon, String text) {
    return Tab(
      icon: Icon(
        icon,
        size: 20,
      ),
      text: text,
    );
  }

  static createTabBar(List<Widget> tabs) {
    return new Container(
        height: 60,
        child: new TabBar(
          indicatorColor: Colors.black,
          tabs: tabs,
        ));
  }

  static appBar(List<Widget> tabs, String title) {
    return AppBar(
        centerTitle: true,
        bottom: tabs.length > 0
            ? new PreferredSize(
                preferredSize: new Size(30.0, 50.0),
                child: IPPWidget.createTabBar(tabs))
            : new PreferredSize(
                preferredSize: new Size(0, 0), child: Container()),
        title: IPPText.simpleText(title,
            fontSize: 20.0, align: TextAlign.right, color: Colors.white));
  }
}
