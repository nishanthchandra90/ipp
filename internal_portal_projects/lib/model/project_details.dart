import 'dart:convert';

class ProjectDetails {
  String _projectName;
  String _projectId;
  String _managerName;
  String _description;
  List<dynamic> _requiredSkills;
  String _tenure;

  ProjectDetails(this._projectName, this._projectId, this._managerName,
      this._description, this._requiredSkills, this._tenure);

  String get tenure => _tenure;

  List<dynamic> get skills => _requiredSkills;

  String get description => _description;

  String get managerName => _managerName;

  String get projectId => _projectId;

  String get projectName => _projectName;

  Map<String, dynamic> toJson() => {
        'projectName': _projectName,
        'projectId': _projectId,
        'managerName': _managerName,
        'description': _description,
        'requiredSkills': _requiredSkills,
        'tenure': _tenure,
      };

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
      json['projectName'],
      json['projectId'],
      json['managerName'],
      json['description'],
      json['requiredSkills'],
      json['tenure']);

  ProjectDetails projectFromJson(String str) {
    final jsonData = json.decode(str);
    return ProjectDetails.fromJson(jsonData);
  }

  String projectToJson(ProjectDetails data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }
}
