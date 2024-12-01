import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/admin/PermissionAuthorization/ListModuleRole/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/PermissionAuthorization/PermissionTableAuthorization/index.dart';

class PermissionAuthorization extends StatefulWidget {
  const PermissionAuthorization({super.key});

  @override
  State<PermissionAuthorization> createState() =>
      _PermissionAuthorizationState();
}

class _PermissionAuthorizationState extends State<PermissionAuthorization> {
  String? selectedRoleId;
  String? selectedModuleId;

  void setFilters(String? roleId, String? moduleId) {
    setState(() {
      selectedRoleId = roleId;
      selectedModuleId = moduleId;
      print('roleId: $roleId');
      print('moduleId: $moduleId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text('Permission Authorization'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: ListModuleRole(
                selectedRoleId: selectedRoleId,
                selectedModuleId: selectedModuleId,
                setFilters: setFilters),
          ),
          Container(
            height: 265,
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Card(
              color: Colors.white,
              child: PermissionTableAuthorization(
                key: ValueKey('$selectedRoleId || $selectedModuleId'),
                roleId: selectedRoleId,
                moduleId: selectedModuleId,
              ),
            ),
          )
        ],
      ),
    );
  }
}
