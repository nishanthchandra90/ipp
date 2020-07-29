import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/screens/projects.dart';
import 'package:internal_portal_projects/service/auth_service.dart';

import 'login_screen.dart';
import 'matched_candidates.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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
    Widget tab1 = _createTab(Icons.book, 'Projects');
    Widget tab2 = _createTab(
      Icons.assignment_ind,
      'Matches',
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            bottom: new PreferredSize(
                preferredSize: new Size(30.0, 30.0),
                child: _createTabBar([tab1, tab2])),
            title: IPPText.simpleText("Manage Projects",
                fontSize: 20.0, align: TextAlign.right, color: Colors.white)),
        body: TabBarView(
          children: [
            Projects(),
            MatchedCandidates(),
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
          height: MediaQuery.of(context).size.width * 0.4,
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
