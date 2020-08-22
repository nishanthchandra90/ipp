import 'dart:convert';

class ProjectDetails {
  String _projectName;
  String _projectId;
  String _managerName;
  String _description;

  String _currLocation;

  String _building;

  String _platform;

  String _platformName;

  String _expertise;
  String _tenure;

  ProjectDetails(
      this._projectName,
      this._projectId,
      this._managerName,
      this._description,
      this._currLocation,
      this._building,
      this._platform,
      this._platformName,
      this._expertise,
      this._tenure);

  String get tenure => _tenure;

  String get expertise => _expertise;

  String get description => _description;

  String get managerName => _managerName;

  String get projectId => _projectId;

  String get projectName => _projectName;

  String get currLocation => _currLocation;

  String get building => _building;

  String get platform => _platform;

  String get platformName => _platformName;

  Map<String, dynamic> toJson() => {
        'projectName': _projectName,
        'projectId': _projectId,
        'managerName': _managerName,
        'description': _description,
        'projLocation': _currLocation,
        'building': _building,
        'platform': _platform,
        'platformName': _platformName,
        'expertise': _expertise,
        'tenure': _tenure,
      };

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
      json['projectName'],
      json['projectId'],
      json['managerName'],
      json['description'],
      json['projLocation'],
      json['building'],
      json['platform'],
      json['platformName'],
      json['expertise'],
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
