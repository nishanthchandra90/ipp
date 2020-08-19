import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/common_components/ipp_dialogs.dart';
import 'package:internal_portal_projects/common_components/ipp_inputelements.dart';
import 'package:internal_portal_projects/common_components/ipp_snackbar.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/model/primary_skill_details.dart';
import 'package:internal_portal_projects/repo/employees_repo.dart';
import 'package:internal_portal_projects/service/project_manage_service.dart';

class EmployeeSignUpScreen extends StatefulWidget {
  const EmployeeSignUpScreen();

  @override
  State<StatefulWidget> createState() => _EmployeeSignUpScreenState();
}

class _EmployeeSignUpScreenState extends State<EmployeeSignUpScreen> {
  final _employeeFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<State> globalStateKey = new GlobalKey<State>();
  final TextEditingController empIdEditCntrlr = TextEditingController();
  final TextEditingController empEmailEditCntrlr = TextEditingController();
  final TextEditingController nameEditCntrlr = TextEditingController();
  final TextEditingController pwdEditCntrlr = TextEditingController();
  final TextEditingController skillsEditCntrlr = TextEditingController();
  final TextEditingController certsEditCntrlr = TextEditingController();
  String experienceErrorText = '';
  String locErrorText = '';
  String buildingErrorText = '';
  String platformErrorText = '';
  String platformNameErrorText = '';
  bool validExperiencePeriod = false;
  String _yearsSelected = '0';
  String _monthsSelected = '0';
  var citiesFuture;
  var buildingsFuture;
  var platforms;
  String _locationSelected;
  String _buildingSelected;
  String _platformSelected;
  String _platformNameSelected;
  List<String> platformNames = [];

  _EmployeeSignUpScreenState();

  @override
  void initState() {
    super.initState();
    citiesFuture = new ProjectManagementService().getAllLocations();
    buildingsFuture = new ProjectManagementService().getAllBuildings();
    platforms = new ProjectManagementService().getPrimaryPlatforms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: IPPText.simpleText('New Candidate',
              fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: _form(),
          ),
        ));
  }

  _form() {
    Widget headingText = IPPText.simpleText(
        'Please fill out this form to complete the registration',
        color: Colors.blue);
    Widget empIdTextBox = IPPInputs.simpleTextFormField(
        "Employee Id", "emp id", empIdEditCntrlr, true, context,
        charLimit: 20);
    Widget passwordTextBox = IPPInputs.simpleTextFormField(
        "Password", "password", pwdEditCntrlr, true, context,
        charLimit: 20, obscureText: true);
    Widget emailTextBox = IPPInputs.simpleTextFormField(
        "Employee Email", "abc.xyz.tcs.com", empEmailEditCntrlr, true, context,
        charLimit: 20);
    Widget empNameTextBox = IPPInputs.simpleTextFormField(
        "Name", "first name, last name", nameEditCntrlr, true, context,
        charLimit: 20);
    var yearsPickerInput = Dialogs.numberPickerDialog(
        _yearsSelected,
        'Please Select number of years of experience',
        0,
        0,
        25,
        (newValue) => setState(() => {
              _yearsSelected =
                  newValue != null ? newValue.toString() : _yearsSelected,
            }),
        context,
        labelText: 'Years');
    var monthsPickerInput = Dialogs.numberPickerDialog(
        _monthsSelected,
        "Please select months of Experience",
        0,
        0,
        11,
        (newValue) => setState(() => _monthsSelected =
            newValue != null ? newValue.toString() : _monthsSelected),
        context,
        labelText: "Months");
    Widget experienceDropDownRow = IPPInputs.widgetRow(
        IPPText.simpleText('Experience'),
        experienceErrorText,
        validExperiencePeriod,
        [yearsPickerInput, monthsPickerInput]);

    Widget locDropDownRow = IPPInputs.widgetRow(IPPText.simpleText('Location'),
        locErrorText, validExperiencePeriod, [workLocationDropdown()]);

    Widget buildingDropDownRow = IPPInputs.widgetRow(
        IPPText.simpleText('Building'),
        buildingErrorText,
        validExperiencePeriod,
        [workBuildingDropdown()]);

    Widget platformDropDownRow = IPPInputs.widgetRow(
        IPPText.simpleText('Platform'),
        platformErrorText,
        validExperiencePeriod,
        [platformDropdown()]);

    Widget skillsTextBox = IPPInputs.simpleTextFormField(
        "Secondary Skills", "skills", skillsEditCntrlr, true, context,
        charLimit: 100);
    Widget certificationsTextBox = IPPInputs.simpleTextFormField(
        "Certifications", "certification", certsEditCntrlr, false, context,
        charLimit: 100);
    return Form(
        key: _employeeFormKey,
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                headingText,
                empIdTextBox,
                passwordTextBox,
                emailTextBox,
                empNameTextBox,
                experienceDropDownRow,
                locDropDownRow,
                buildingDropDownRow,
                platformDropDownRow,
                platformSkillsDropdown(),
                skillsTextBox,
                certificationsTextBox,
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () {
                          _saveEmployee();
                        },
                        child: Text('Sing Up')),
                    RaisedButton(
                        onPressed: () {
                          _resetForm();
                        },
                        child: Text('Reset')),
                  ],
                )
              ],
            )));
  }

  Future<void> _saveEmployee() async {
    var formState = _employeeFormKey.currentState;
    formState.save();
    int yearsSelected = int.parse(_yearsSelected);
    int monthsSelected = int.parse(_monthsSelected);
    bool validSelects = validateSelects(yearsSelected, monthsSelected);
    if (!formState.validate() || !validSelects) {
      return;
    }
    String _employeeId = empIdEditCntrlr.text;
    String email = empEmailEditCntrlr.text;
    String _empName = nameEditCntrlr.text;
    String password = pwdEditCntrlr.text;
    String _empcerts = certsEditCntrlr.text;
    String skills = skillsEditCntrlr.text;
    EmployeeDetails employee = new EmployeeDetails(
        _employeeId,
        password,
        email,
        _empName,
        yearsSelected,
        monthsSelected,
        _locationSelected,
        _buildingSelected,
        _platformSelected,
        _platformNameSelected,
        skills,
        _empcerts,
        false);
    new EmployeesRepo().newUser(employee);
    try {
      Dialogs.showProgressDialog(context, globalStateKey, "Please wait...!");
      await new Future.delayed(const Duration(seconds: 1));
      _displaySnackBar('Employee details saved Successfully!',
          color: Colors.green);
      Navigator.of(_scaffoldKey.currentContext, rootNavigator: true)
          .pop(); //close the dialogue
      _resetForm();
      await new Future.delayed(const Duration(seconds: 1));
      Navigator.of(_scaffoldKey.currentContext, rootNavigator: true)
          .pushNamed('/login');
    } catch (error) {
      Navigator.pop(context);
      _displaySnackBar("Something Went Wrong! Try again.", color: Colors.red);
    }
  }

  _displaySnackBar(String message, {MaterialColor color}) {
    final snackBar = IPPSnackBar.formSavingSnackBar(message, bgColor: color);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _resetForm() {
    var formState = _employeeFormKey.currentState;
    formState.reset();
    empIdEditCntrlr.clear();
    nameEditCntrlr.clear();
    empIdEditCntrlr.clear();
    pwdEditCntrlr.clear();
    skillsEditCntrlr.clear();
    certsEditCntrlr.clear();
    setState(() {
      _yearsSelected = '0';
      _monthsSelected = '0';
      _locationSelected = null;
      _buildingSelected = null;
      _platformSelected = null;
      _platformNameSelected = null;
      experienceErrorText = '';
      locErrorText = '';
      buildingErrorText = '';
      platformErrorText = '';
      platformNameErrorText = '';
    });
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

  validateSelects(int yearsSelected, int monthsSelected) {
    setState(() {
      experienceErrorText = yearsSelected + monthsSelected < 1
          ? 'Please enter your Experience'
          : '';
      locErrorText = _locationSelected == null ? 'Please select Location' : '';
      buildingErrorText =
          _buildingSelected == null ? 'Please select Building' : '';
      platformErrorText =
          _platformSelected == null ? 'Please select Platform' : '';
      platformNameErrorText =
          _platformNameSelected == null ? 'Please select Platform Type' : '';
    });
    if (experienceErrorText.isNotEmpty ||
        locErrorText.isNotEmpty ||
        buildingErrorText.isNotEmpty ||
        platformNameErrorText.isNotEmpty ||
        platformErrorText.isNotEmpty) {
      return false;
    }
    return true;
  }
}
