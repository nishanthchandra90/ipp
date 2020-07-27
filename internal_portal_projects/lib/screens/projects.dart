import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_actionbutton.dart';

import 'add_project_screen.dart';


class Projects extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ProjectState();

}

class _ProjectState extends State<Projects>{
  @override
  Widget build(BuildContext context) {
    Function onAddBtnPressed = () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => AddProjectScreen(),
        )).then((value) {
      setState(() {

      });
    });
    return Scaffold(body: _buildScreen(),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: IPPActionButton.floatingAddButton(
          onAddBtnPressed,
          'Project',
        ));
  }

  _buildScreen(){
    return Container();
  }

}