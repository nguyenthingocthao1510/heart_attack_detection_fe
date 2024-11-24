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

class Permission {
  String? moduleName;
  String? permissionName;

  Permission(this.moduleName, this.permissionName);

  factory Permission.fromJson(dynamic json) {
    return Permission(
        json['moduleName'] as String, json['permissionName'] as String);
  }
}

class PermissionModule {
  Map<String, List<String>>? permissions;
  int? roleId;

  PermissionModule(this.roleId, [this.permissions]);

  factory PermissionModule.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>> permissions = {};

    if (json['permission'] != null) {
      var permissionMap = json['permission'] as Map<String, dynamic>;
      permissionMap.forEach((key, value) {
        permissions[key] =
            List<String>.from(value); // Convert value thành List<String>
      });
    }

    return PermissionModule(
      json['roleId'] as int,
      permissions,
    );
  }
}
