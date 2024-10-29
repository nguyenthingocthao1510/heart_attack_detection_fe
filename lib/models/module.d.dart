class Module {
  final int? id;
  final String? name;
  final String? route;
  final String? image;

  Module({this.id, this.name, this.route, this.image});

  factory Module.fromMap(Map<String, dynamic> e) {
    return Module(
        id: e['id'], image: e['image'], name: e['name'], route: e['route']);
  }
}
