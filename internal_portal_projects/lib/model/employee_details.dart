class EmployeeDetails {
  String _employeeId;

  String _empFName;

  String _empLName;

  String _password;

  String _email;

  bool _isAdmin;

  EmployeeDetails(this._employeeId, this._empFName, this._empLName, this._email,
      this._password, this._isAdmin);

  bool get isAdmin => _isAdmin;

  String get email => _email;

  String get empFName => _empFName;

  String get empLName => _empLName;

  String get password => _password;

  String get employeeId => _employeeId;

  Map<String, dynamic> toJson() => {
        'employeeId': _employeeId,
        'employeeName': _empFName,
        'empFName': _empFName,
        'empLName': _empLName,
        'email': _email,
        'password': _password,
        'isAdmin': _isAdmin,
      };

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) =>
      EmployeeDetails(json['employeeId'], json['empFName'], json['empLName'],
          json['email'], json['password'], json['admin']);
}
