import 'dart:core';

import 'package:internal_portal_projects/model/project_details.dart';

class PotentialCandidates {
  ProjectDetails _project;
  List<dynamic> _appliedCandidates;
  List<dynamic> _matchedCandidates;
  List<dynamic> _confirmedCandidates;

  PotentialCandidates(this._project, this._appliedCandidates,
      this._matchedCandidates, this._confirmedCandidates);

  ProjectDetails get project => _project;

  List<dynamic> get appliedCandidates => _appliedCandidates;

  List<dynamic> get matchedCandidates => _matchedCandidates;

  List<dynamic> get confirmedCandidates => _confirmedCandidates;

  factory PotentialCandidates.fromJson(Map<String, dynamic> parsedJson) {
    return PotentialCandidates(
      ProjectDetails.fromJson(parsedJson['project']),
      parsedJson["appliedEmployees"] =
          (parsedJson['appliedEmployees'] as List)
              ?.map((e) => e == null ? null : Map<String, dynamic>.from(e))
              ?.toList(),
      parsedJson["matchedEmployees"] =
          (parsedJson['matchedEmployees'] as List)
              ?.map((e) => e == null ? null : Map<String, dynamic>.from(e))
              ?.toList(),
      parsedJson["confirmedEmployees"] =
          (parsedJson['confirmedEmployees'] as List)
              ?.map((e) => e == null ? null : Map<String, dynamic>.from(e))
              ?.toList(),
    );
  }
}
