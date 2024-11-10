class PermissionAuthorization {
  int? id;
  String? name;

  PermissionAuthorization({this.id, this.name});

  factory PermissionAuthorization.fromMap(Map<String, dynamic> e) {
    return PermissionAuthorization(
      id: e['id'],
      name: e['name'],
    );
  }
}
