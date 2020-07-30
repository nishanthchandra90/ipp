class EmployeeDetails {
  String _employeeId;

  String _employeeName;

  String _email;

  bool _isAdmin;

  EmployeeDetails(
      this._employeeId, this._employeeName, this._email, this._isAdmin);

  bool get isAdmin => _isAdmin;

  String get email => _email;

  String get employeeName => _employeeName;

  String get employeeId => _employeeId;

  Map<String, dynamic> toJson() => {
        'employeeId': _employeeId,
        'employeeName': _employeeName,
        'email': _email,
        'isAdmin': _isAdmin,
      };

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) =>
      EmployeeDetails(json['employeeId'], json['employeeName'], json['email'],
          json['admin']);
}
