import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_dialogs.dart';
import 'package:internal_portal_projects/common_components/ipp_inputelements.dart';
import 'package:internal_portal_projects/common_components/ipp_snackbar.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/db/database.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/repo/projects_repo.dart';

class AddProjectScreen extends StatefulWidget {
  final ProjectDetails projectDetails;

  AddProjectScreen({this.projectDetails});

  @override
  State<StatefulWidget> createState() => _NewProjectScreenState(projectDetails);
}

class _NewProjectScreenState extends State<AddProjectScreen> {
  @override
  void initState() {
    super.initState();
    if (project != null) {
      populateForm(project);
      setState(() {
        _saveBtnText = 'Update';
        _screenHeading = 'Update Project';
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<State> globalStateKey = new GlobalKey<State>();
  TextEditingController projectNameTextEditor = new TextEditingController();
  TextEditingController projectIdTextEditor = new TextEditingController();
  TextEditingController projectManagerTextEditor = new TextEditingController();
  TextEditingController projectDescTextEditor = new TextEditingController();
  TextEditingController skillSetsTextEditor = new TextEditingController();
  TextEditingController tenureTextEditor = new TextEditingController();
  ProjectDetails project;
  String _saveBtnText = 'Save';
  String _screenHeading = 'New Project';

  _NewProjectScreenState(this.project);

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey, body: SafeArea(child: _buildScreen()));
  }

  _buildScreen() {
    return _buildAddAccountForm();
  }

  _buildAddAccountForm() {
    return new SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _accountFormWidgets(context),
                ))));
  }

  _accountFormWidgets(BuildContext _context) {
    Widget projectNameTextField = IPPInputs.simpleTextFormField(
        'Name', 'project name', projectNameTextEditor, true, context,
        charLimit: 22);

    Widget projectIdTextField = IPPInputs.simpleTextFormField(
        'Id', 'project id', projectIdTextEditor, true, context,
        charLimit: 10);

    Widget managerFieldTextBox = IPPInputs.simpleTextFormField(
        'Manager', 'project manager', projectManagerTextEditor, true, context,
        charLimit: 15);

    Widget descriptionTextField = IPPInputs.simpleTextFormField('Description',
        'project description', projectDescTextEditor, true, context,
        charLimit: 20);

    Widget skillsTextField = IPPInputs.simpleTextAreaField(
        'Skill Sets', 'skills', skillSetsTextEditor, true, context);

    Widget tenureTextField = IPPInputs.simpleTextFormField(
        'Tenure', 'project duration', tenureTextEditor, false, context,
        charLimit: 40);

    Widget saveButton = IPPInputs.formButton(_saveBtnText, onPressed: () {
      saveForm();
    });

    Widget resetButton = IPPInputs.formButton('Reset', onPressed: () {
      resetForm();
    });

    Widget formButtonRow = IPPInputs.formButtonRow(saveButton, resetButton);
    List<Widget> depositFormWidgets = [
      new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BackButton(onPressed: () => Navigator.pop(context)),
          Padding(
              padding: EdgeInsets.fromLTRB(60,0,0,0),
              child: IPPText.simpleText(_screenHeading,
                  fontSize: 22.0, fontWeight: FontWeight.bold))
        ],
      ),
      projectIdTextField,
      projectNameTextField,
      managerFieldTextBox,
      descriptionTextField,
      skillsTextField,
      tenureTextField,
      formButtonRow,
    ];
    return depositFormWidgets;
  }

  void saveForm() {
//    _addDummyProjects(2);
    _formKey.currentState.validate();
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    String id = project == null ? UniqueKey().toString() : project.id;
    String projectId = projectIdTextEditor.text;
    String projectName = projectNameTextEditor.text;
    String projectManager = projectManagerTextEditor.text ?? '';
    String projectDesc = projectDescTextEditor.text ?? '';
    String skills = skillSetsTextEditor.text ?? '';
    String tenure = tenureTextEditor.text ?? '';
    var projectDetails = new ProjectDetails(id, projectId, projectName,
        projectManager, projectDesc, skills, tenure);
    _handleSubmit(context, projectDetails);
  }

  Future<void> _handleSubmit(
      BuildContext context, ProjectDetails projectDetails) async {
    try {
      Dialogs.showProgressDialog(context, globalStateKey, "Please wait...!");
      await new Future.delayed(const Duration(seconds: 1)); //invoking login
      if (project == null) {
        await ProjectsRepo().newProject(projectDetails);
        resetForm();
      } else {
//        await AccountBloc().updateAccount(projectDetails);
      }
      _displaySnackBar('Project details saved Successfully!');
      Navigator.of(_scaffoldKey.currentContext, rootNavigator: false)
          .pop(); //close the dialogue
    } catch (error) {
      Navigator.pop(context);
      _displaySnackBar("Something Went Wrong! Try again.", color:Colors.red);
    }
  }

  @override
  void dispose() {
    // other dispose methods
    super.dispose();
  }

  void resetForm() {
    _formKey.currentState.reset();
    projectManagerTextEditor.clear();
    projectNameTextEditor.clear();
    projectIdTextEditor.clear();
    skillSetsTextEditor.clear();
    projectDescTextEditor.clear();
    tenureTextEditor.clear();
  }


  _displaySnackBar(String message, {MaterialColor color}) {
    final snackBar = IPPSnackBar.formSavingSnackBar(message,bgColor: color);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _addDummyProjects(int d) {
    new ProjectDetails(UniqueKey().toString(), "Project A", "PR-1234",
        "Manager", 'descr', "java, #net", "1 year");
    new ProjectDetails(UniqueKey().toString(), "Project B", "PR-12798",
        "Manager", 'descr', "python, java, #net", "2 year");
  }

  void populateForm(ProjectDetails project) {
    projectNameTextEditor.text = project.projectName;
    projectIdTextEditor.text = project.projectId;
    projectManagerTextEditor.text = project.managerName;
    projectDescTextEditor.text = project.description;
    skillSetsTextEditor.text = project.skills;
    tenureTextEditor.text = project.tenure;
  }
}
