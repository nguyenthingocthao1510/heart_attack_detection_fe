class Module {
  final int? id;
  final String? name;
  final String? route;
  final String? image;

  Module({this.id, this.name, this.route, this.image});

  factory Module.fromMap(Map<String, dynamic> e) {
    return Module(name: e['name']);
  }
}
