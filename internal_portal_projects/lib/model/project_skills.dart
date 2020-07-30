class ProjectSkill {
  String field;

  String skillSet;

  ProjectSkill(this.field, this.skillSet);

  Map<String, dynamic> toJson() => {
        'field': field,
        'skillSet': skillSet,
      };

  @override
  String toString() {
    return 'ProjectSkill{field: $field, skillSet: $skillSet}';
  }
}
