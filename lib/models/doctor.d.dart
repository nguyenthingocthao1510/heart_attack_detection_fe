class Doctor {
  int? account_id;
  int? id;
  String? name;

  Doctor({this.id, this.account_id, this.name});

  factory Doctor.fromMap(Map<String, dynamic> e) {
    return Doctor(
      account_id: e['account_id'],
      id: e['id'],
      name: e['name'],
    );
  }
}
