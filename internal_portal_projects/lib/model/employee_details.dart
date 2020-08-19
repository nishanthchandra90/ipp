class EmployeeDetails {
  String _employeeId;

  String _password;

  String _email;

  String _empName;

  int _expYears;

  int _expMonths;

  String _currLocation;

  String _building;

  String _platform;

  String _platformName;

  String _secSkills;

  String _certificates;

  bool _isAdmin;

  EmployeeDetails(
      this._employeeId,
      this._password,
      this._email,
      this._empName,
      this._expYears,
      this._expMonths,
      this._currLocation,
      this._building,
      this._platform,
      this._platformName,
      this._secSkills,
      this._certificates,
      this._isAdmin);


  String get employeeId => _employeeId;

  Map<String, dynamic> toJson() => {
        'employeeId': _employeeId,
        'password': _password,
        'email': _email,
        'empName': _empName,
        'expYears': _expYears,
        'expMonths': _expMonths,
        'currLocation': _currLocation,
        'building': _building,
        'platform': _platform,
        'platformName': _platformName,
        'secSkills': _secSkills,
        'certificates': _certificates,
        'isAdmin': _isAdmin,
      };

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) =>
      EmployeeDetails(
          json['employeeId'],
          json['password'],
          json['email'],
          json['empName'],
          json['expYears'],
          json['expMonths'],
          json['currLocation'],
          json['building'],
          json['platform'],
          json['platformName'],
          json['secSkills'],
          json['certificates'],
          json['admin']);

  String get password => _password;

  String get email => _email;

  String get empName => _empName;

  int get expYears => _expYears;

  int get expMonths => _expMonths;

  String get currLocation => _currLocation;

  String get building => _building;

  String get platform => _platform;

  String get platformName => _platformName;

  String get secSkills => _secSkills;

  String get certificates => _certificates;

  bool get isAdmin => _isAdmin;
}
