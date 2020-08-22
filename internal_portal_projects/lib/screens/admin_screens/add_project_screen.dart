import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/project_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_dialogs.dart';
import 'package:internal_portal_projects/common_components/ipp_inputelements.dart';
import 'package:internal_portal_projects/common_components/ipp_snackbar.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/primary_skill_details.dart';
import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/service/location_service.dart';
import 'package:internal_portal_projects/service/project_manage_service.dart';

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
    citiesFuture = LocationService.getAllLocations();
    buildingsFuture = LocationService.getAllBuildings();
    platforms = ProjectManagementService.getPrimaryPlatforms();
  }

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<State> globalStateKey = new GlobalKey<State>();
  TextEditingController projectNameTextEditor = new TextEditingController();
  TextEditingController projectIdTextEditor = new TextEditingController();
  TextEditingController projectManagerTextEditor = new TextEditingController();
  TextEditingController projectDescTextEditor = new TextEditingController();
  String locErrorText = '';
  String buildingErrorText = '';
  String platformErrorText = '';
  String platformNameErrorText = '';
  var citiesFuture;
  var buildingsFuture;
  var platforms;
  String _locationSelected;
  String _buildingSelected;
  String _platformSelected;
  String _platformNameSelected;
  String _tenureSelected;
  List<String> platformNames = [];
  String _expertiseSelected;
  List<String> expertiseOptions = [
    'Design & Implementation',
    'Migration Expert',
    'Project Management',
    'Solution Architect'
  ];

  List<String> tenureOptions = [
    '1-3 Months',
    '3-6 Months',
    '6-12 Months',
    '1-2 Years',
    '2 Years & More'
  ];
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
        'Account Name', 'account name', projectNameTextEditor, true, context,
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

    Widget locDropDownRow = IPPInputs.widgetRow(IPPText.simpleText('Location'),
        locErrorText, true, [workLocationDropdown()]);

    Widget buildingDropDownRow = IPPInputs.widgetRow(
        IPPText.simpleText('Building'),
        buildingErrorText,
        true,
        [workBuildingDropdown()]);

    Widget platformDropDownRow = IPPInputs.widgetRow(
        IPPText.simpleText('Platform'),
        platformErrorText,
        true,
        [platformDropdown()]);

    Widget expertiseDropDown = IPPInputs.dropdown(
        expertiseOptions, _expertiseSelected, 'Select', context,
        (String newVal) {
      setState(() {
        _expertiseSelected = newVal;
      });
    });

    Widget expertiseDownRow = IPPInputs.widgetRow(
        IPPText.simpleText('Expertise'),
        platformErrorText,
        true,
        [expertiseDropDown]);

    Widget tenureDropDown = IPPInputs.dropdown(
        tenureOptions, _tenureSelected, 'Select', context, (String newVal) {
      setState(() {
        _tenureSelected = newVal;
      });
    });

    Widget tenureDownRow = IPPInputs.widgetRow(IPPText.simpleText('Tenure'),
        platformErrorText, true, [tenureDropDown]);

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
              padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
              child: IPPText.simpleText(_screenHeading,
                  fontSize: 22.0, fontWeight: FontWeight.bold))
        ],
      ),
      projectIdTextField,
      projectNameTextField,
      managerFieldTextBox,
      descriptionTextField,
      locDropDownRow,
      buildingDropDownRow,
      platformDropDownRow,
      platformSkillsDropdown(),
      expertiseDownRow,
      tenureDownRow,
      formButtonRow,
    ];
    return depositFormWidgets;
  }

  void saveForm() {
    var formState = _formKey.currentState;
    formState.validate();
    formState.save();
    bool validSelects = validateSelects();
    if (!formState.validate() || !validSelects) {
      return;
    }
    String projectId = projectIdTextEditor.text;
    String projectName = projectNameTextEditor.text;
    String projectManager = projectManagerTextEditor.text ?? '';
    String projectDesc = projectDescTextEditor.text ?? '';
    var projectDetails = new ProjectDetails(
        projectName,
        projectId,
        projectManager,
        projectDesc,
        _locationSelected,
        _buildingSelected,
        _platformSelected,
        _platformNameSelected,
        _expertiseSelected,
        _tenureSelected);
    _handleSubmit(context, projectDetails);
  }

  Future<void> _handleSubmit(
      BuildContext context, ProjectDetails projectDetails) async {
    try {
      Dialogs.showProgressDialog(context, globalStateKey, "Please wait...!");
      await new Future.delayed(const Duration(seconds: 1));
      if (project == null) {
        await ProjectsBloc().add(projectDetails);
        resetForm();
      } else {
        await ProjectsBloc().edit(projectDetails);
      }
      _displaySnackBar('Project details saved Successfully!');
      Navigator.of(_scaffoldKey.currentContext, rootNavigator: false)
          .pop(); //close the dialogue
    } catch (error) {
      Navigator.pop(context);
      _displaySnackBar("Something Went Wrong! Try again.", color: Colors.red);
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
    projectDescTextEditor.clear();
    setState(() {
      _locationSelected = null;
      _buildingSelected = null;
      _platformSelected = null;
      _platformNameSelected = null;
      _expertiseSelected = '';
      _tenureSelected = '';
      locErrorText = '';
      buildingErrorText = '';
      platformErrorText = '';
      platformNameErrorText = '';
    });
  }

  _displaySnackBar(String message, {MaterialColor color}) {
    final snackBar = IPPSnackBar.formSavingSnackBar(message, bgColor: color);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void populateForm(ProjectDetails project) {
    projectNameTextEditor.text = project.projectName;
    projectIdTextEditor.text = project.projectId;
    projectManagerTextEditor.text = project.managerName;
    projectDescTextEditor.text = project.description;
    _locationSelected = project.currLocation;
    _buildingSelected = project.building;
    _platformSelected = project.platform;
    _platformNameSelected = project.platformName;
    _tenureSelected = project.tenure;
    _expertiseSelected = project.expertise;
  }

  Widget workLocationDropdown() {
    return FutureBuilder(
        future: citiesFuture,
        builder: (context, snapshot) {
          List<String> cities = snapshot.hasData ? snapshot.data : [];
          return DropdownButton<String>(
            value: _locationSelected,
            onChanged: (String newValue) {
              _changeWorkLocation(newValue);
            },
            hint: new Text('Select'),
            items: cities.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Container(
                  width: 200,
                  child: IPPText.simpleText(value, overflow: TextOverflow.clip),
                ),
              );
            }).toList(),
          );
        });
  }

  _changeWorkLocation(String value) {
    setState(() {
      _locationSelected = value;
    });
  }

  Widget workBuildingDropdown() {
    return FutureBuilder(
        future: buildingsFuture,
        builder: (context, snapshot) {
          List<String> buildings = snapshot.hasData ? snapshot.data : [];
          return DropdownButton<String>(
            value: _buildingSelected,
            onChanged: (String newValue) {
              _changeWorkBuilding(newValue);
            },
            hint: new Text('Select'),
            items: buildings.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Container(
                  width: 200,
                  child: IPPText.simpleText(value, overflow: TextOverflow.clip),
                ),
              );
            }).toList(),
          );
        });
  }

  _changeWorkBuilding(String value) {
    setState(() {
      _buildingSelected = value;
    });
  }

  Widget platformDropdown() {
    return FutureBuilder(
        future: platforms,
        builder: (context, snapshot) {
          List<PrimarySkill> platforms = snapshot.hasData ? snapshot.data : [];
          return DropdownButton<String>(
            value: _platformSelected,
            onChanged: (String newValue) {
              _changePlatform(platforms, newValue);
            },
            hint: new Text('Select'),
            items: platforms
                .map((e) => e.platformName)
                .toList()
                .map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Container(
                  width: 200,
                  child: IPPText.simpleText(value, overflow: TextOverflow.clip),
                ),
              );
            }).toList(),
          );
        });
  }

  _changePlatform(List<PrimarySkill> platform, String newValue) {
    setState(() {
      _platformSelected = newValue;
      platformNames = [];
      _platformNameSelected = null;
      platformNames = List<String>.from(platform
          .singleWhere((element) =>
              StringUtils.equalsIgnoreCase(element.platformName, newValue))
          .types);
    });
  }

  Widget platformSkillsDropdown() {
    return DropdownButton<String>(
      value: _platformNameSelected,
      onChanged: (String newValue) {
        _changePlatformType(newValue);
      },
      hint: new Text('Select'),
      items: platformNames.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Container(
            width: 200,
            child: IPPText.simpleText(value, overflow: TextOverflow.clip),
          ),
        );
      }).toList(),
    );
  }

  _changePlatformType(String value) {
    setState(() {
      _platformNameSelected = value;
    });
  }

  validateSelects() {
    setState(() {
      locErrorText = _locationSelected == null ? 'Please select Location' : '';
      buildingErrorText =
          _buildingSelected == null ? 'Please select Building' : '';
      platformErrorText =
          _platformSelected == null ? 'Please select Platform' : '';
      platformNameErrorText =
          _platformNameSelected == null ? 'Please select Platform Type' : '';
    });
    if (locErrorText.isNotEmpty ||
        buildingErrorText.isNotEmpty ||
        platformNameErrorText.isNotEmpty ||
        platformErrorText.isNotEmpty ||
        _tenureSelected.isEmpty ||
        _expertiseSelected.isEmpty) {
      return false;
    }
    return true;
  }
}
