import 'package:flutter/material.dart';

class RoleProvider with ChangeNotifier {
  String? _roleId;

  String? get roleId => _roleId;

  void setRoleId(String? roleId) {
    _roleId = roleId;
    notifyListeners();
  }
}
