import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/admin/ModuleAuthorization/ListRole/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/ModuleAuthorization/ModuleTableAuthorization/index.dart';

class ModuleAuthorization extends StatefulWidget {
  const ModuleAuthorization({super.key});

  @override
  State<ModuleAuthorization> createState() => _ModuleAuthorizationState();
}

class _ModuleAuthorizationState extends State<ModuleAuthorization> {
  String? selectedRoleId;

  void setFilters(String? roleId) {
    setState(() {
      selectedRoleId = roleId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        title: Text('Module Authorization'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Column(
              children: [
                ListRole(
                  selectedRoleId: selectedRoleId,
                  setFilters: setFilters,
                ),
              ],
            ),
          ),
          Expanded(
            child: ModuleTableAuthorization(
              key: ValueKey(selectedRoleId),
              roleId: selectedRoleId,
            ),
          ),
        ],
      ),
    );
  }
}
