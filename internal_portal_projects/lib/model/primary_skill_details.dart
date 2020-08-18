class PrimarySkill {
  String _platform;
  List<dynamic> _platformTypes;

  PrimarySkill(this._platform, this._platformTypes);

  List<dynamic> get types => _platformTypes;

  String get platformName => _platform;

  Map<String, dynamic> toJson() =>
      {'platform': _platform, 'platformTypes': _platformTypes};

  factory PrimarySkill.fromJson(Map<String, dynamic> json) =>
      PrimarySkill(json['platform'], json['platformTypes']);
}
