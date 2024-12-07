class Gender {
  int? value;
  String? label;

  Gender({this.value, this.label});

  factory Gender.fromMap(Map<String, dynamic> e) {
    return Gender(value: e['value'], label: e['label']);
  }

  static List<Gender> GENDER() {
    return [
      {'value': 0, 'label': 'Male'},
      {'value': 1, 'label': 'Female'},
    ].map((e) => Gender.fromMap(e)).toList();
  }
}
