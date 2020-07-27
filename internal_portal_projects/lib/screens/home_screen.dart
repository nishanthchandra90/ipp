import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/screens/projects.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            bottom: new PreferredSize(
                preferredSize: new Size(30.0, 30.0),
                child: new Container(
                    height: 50,
                    child: new TabBar(
                      indicatorColor: Colors.black,
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.book,
                            size: 20,
                          ),
                          text: 'Projects',
                        ),
                        Tab(
                          icon: Icon(
                            Icons.assignment_ind,
                            size: 20,
                          ),
                          text: 'Matches',
                        ),
                      ],
                    ))),
            title: IPPText.simpleText("Manage Projects",
                fontSize: 22.0, align: TextAlign.right)),
        body: TabBarView(
          children: [
            Projects(),
            MatchedCandidates(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Menu 1"),
                trailing: Icon(Icons.arrow_forward),
              ),
              ListTile(
                title: Text("Menu 2"),
                trailing: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
