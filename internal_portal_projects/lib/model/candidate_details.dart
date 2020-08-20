import 'package:internal_portal_projects/model/employee_details.dart';

class CandidateDetails {
  EmployeeDetails _employee;
  bool _isMatched;
  bool _isApplied;
  bool _isConfirmed;

  CandidateDetails(
      this._employee, this._isMatched, this._isApplied, this._isConfirmed);

  EmployeeDetails get employee => _employee;

  bool get isMatched => _isMatched;

  bool get isApplied => _isApplied;

  bool get isConfirmed => _isConfirmed;

  Map<String, dynamic> toJson() => {
        'employee': _employee,
        'isMatched': _isMatched,
        'isApplied': _isApplied,
        'isConfirmed': _isConfirmed,
      };

  factory CandidateDetails.fromJson(Map<String, dynamic> json) =>
      CandidateDetails(EmployeeDetails.fromJson(json['employee']),
          json['matched'], json['applied'], json['confirmed']);
}
