class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  factory Role.fromMap(Map<String, dynamic> e) {
    return Role(id: e['id'], name: e['name']);
  }
}
