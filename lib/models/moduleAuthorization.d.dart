class ModuleRole {
  int? id;
  String? image;
  String? name;
  String? route;

  ModuleRole({this.id, this.name, this.image, this.route});

  factory ModuleRole.fromMap(Map<String, dynamic> e) {
    return ModuleRole(
      id: e['id'],
      image: e['image'],
      name: e['name'],
      route: e['route'],
    );
  }
}
