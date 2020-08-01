import 'dart:core';

class PotentialCandidates {
  String _projectId;
  String _projectName;
  List<dynamic> _appliedCandidates;
  List<dynamic> _matchedCandidates;

  PotentialCandidates(this._projectId, this._projectName,
      this._appliedCandidates, this._matchedCandidates);

  String get projectId => _projectId;

  factory PotentialCandidates.fromJson(Map<String, dynamic> json) =>
      PotentialCandidates(
        json['projectId'],
        json['projectName'],
        json['appliedCandidates'],
        json['matchedCandidates'],
      );

  String get projectName => _projectName;

  List<dynamic> get appliedCandidates => _appliedCandidates;

  List<dynamic> get matchedCandidates => _matchedCandidates;
}
