import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/permissionAuthorization.dart';

class PermissionProvider with ChangeNotifier {
  Map<String, List<String>> _permissions = {};
  int? _roleId;

  Map<String, List<String>> get permissions => _permissions;

  int? get roleId => _roleId;

  void updatePermissionsFromApi(PermissionModule permissionModule) {
    _roleId = permissionModule.roleId;
    _permissions = permissionModule.permissions ?? {};
    notifyListeners();
  }

  void clearPermissions() {
    _roleId = null;
    _permissions = {};
    notifyListeners();
  }
}
