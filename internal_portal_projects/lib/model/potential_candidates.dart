import 'dart:core';

import 'package:internal_portal_projects/model/project_details.dart';

class ProjectApplications {
  ProjectDetails _project;
  List<dynamic> _appliedCandidates;
  List<dynamic> _matchedCandidates;
  List<dynamic> _confirmedCandidates;

  ProjectApplications(this._project, this._appliedCandidates,
      this._matchedCandidates, this._confirmedCandidates);

  ProjectDetails get project => _project;

  List<dynamic> get appliedCandidates => _appliedCandidates;

  List<dynamic> get matchedCandidates => _matchedCandidates;

  List<dynamic> get confirmedCandidates => _confirmedCandidates;

  factory ProjectApplications.fromJson(Map<String, dynamic> parsedJson) {
    return ProjectApplications(
      ProjectDetails.fromJson(parsedJson['project']),
      parsedJson["appliedCandidates"] =
          (parsedJson['appliedCandidates'] as List)
              ?.map((e) => e == null ? null : Map<String, dynamic>.from(e))
              ?.toList(),
      parsedJson["matchedCandidates"] =
          (parsedJson['matchedCandidates'] as List)
              ?.map((e) => e == null ? null : Map<String, dynamic>.from(e))
              ?.toList(),
      parsedJson["confirmedCandidates"] =
          (parsedJson['confirmedCandidates'] as List)
              ?.map((e) => e == null ? null : Map<String, dynamic>.from(e))
              ?.toList(),
    );
  }
}
