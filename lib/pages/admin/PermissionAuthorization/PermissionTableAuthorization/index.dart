import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/permissionAuthorization.dart';
import 'package:heart_attack_detection_fe/pages/admin/PermissionAuthorization/PermissionTableAuthorization/PermisisonTable/index.dart';
import 'package:heart_attack_detection_fe/services/permissionAuthorization.dart';

class PermissionTableAuthorization extends StatefulWidget {
  final String? roleId;
  final String? moduleId;

  const PermissionTableAuthorization(
      {super.key, required this.roleId, required this.moduleId});

  @override
  State<PermissionTableAuthorization> createState() =>
      _PermissionTableAuthorizationState();
}

class _PermissionTableAuthorizationState
    extends State<PermissionTableAuthorization> {
  List<PermissionAuthorization> permissionNotInRoleModule = [];
  List<int> selectedPermissionNotInRole = [];
  List<PermissionAuthorization> permissionInRoleModule = [];
  List<int> selectedPermissionInRole = [];
  PermissionAuthorizationAPI permissionAuthorizationAPI = PermissionAuthorizationAPI();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant PermissionTableAuthorization oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.roleId != oldWidget.roleId ||
        widget.moduleId != oldWidget.moduleId) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    await getAllPermissionNotInModuleRole();
    await getAllPermissionInModuleRole();
  }

  Future<void> getAllPermissionNotInModuleRole() async {
    final roleId = int.parse(widget.roleId!);
    final moduleId = int.parse(widget.moduleId!);
    final response =
        await permissionAuthorizationAPI.getAllPermissionNotInModuleRole(
            roleId, moduleId);
    setState(() {
      permissionNotInRoleModule = response;
    });
  }

  Future<void> getAllPermissionInModuleRole() async {
    final roleId = int.parse(widget.roleId!);
    final moduleId = int.parse(widget.moduleId!);
    final response =
        await permissionAuthorizationAPI.getAllPermissionInModuleRole(
            roleId, moduleId);
    setState(() {
      permissionInRoleModule = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 8),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Permission not in role',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        child: Expanded(
                            child: PermissionTable(
                                permissions: permissionNotInRoleModule,
                                onSelectedPermissionChange: (selectedKey) {
                                  setState(() {
                                    selectedPermissionNotInRole =
                                        selectedKey.cast<int>();
                                  });
                                })),
                      )
                    ],
                  ),
                )),
                SizedBox(
                    height: 180,
                    width: 80,
                    child: Padding(
                      padding: EdgeInsets.only(top: 22.5),
                      child: Table(
                        border: TableBorder.all(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        children: [
                          TableRow(
                              decoration:
                                  BoxDecoration(color: Colors.blue[200]),
                              children: [
                                SizedBox(
                                  height: 35.5,
                                  width: 50,
                                  child: Column(children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 3),
                                      child: SizedBox(
                                        height: 30,
                                        width: 45,
                                        child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .transparent)))),
                                          onPressed: () => () {},
                                          child: Icon(
                                            Icons.swap_horiz,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              ]),
                          TableRow(children: [
                            SizedBox(
                              height: 145,
                              width: 50,
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 10),
                                  child: SizedBox(
                                    height: 40,
                                    width: 45,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.blue),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  side: BorderSide(
                                                      color: Colors
                                                          .transparent)))),
                                      onPressed: () => onAddPermission(
                                        selectedPermissionNotInRole,
                                        int.parse(widget.roleId!),
                                        int.parse(widget.moduleId!),
                                      ),
                                      child: Icon(
                                        Icons.keyboard_double_arrow_right,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: SizedBox(
                                    height: 40,
                                    width: 45,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.red),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  side: BorderSide(
                                                      color: Colors
                                                          .transparent)))),
                                      onPressed: () => onRemovePermission(
                                        selectedPermissionInRole,
                                        int.parse(widget.roleId!),
                                        int.parse(widget.moduleId!),
                                      ),
                                      child: Icon(
                                        Icons.keyboard_double_arrow_left,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ]),
                        ],
                      ),
                    )),
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Permission in role',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        child: Expanded(
                            child: PermissionTable(
                                permissions: permissionInRoleModule,
                                onSelectedPermissionChange: (selectedKey) {
                                  setState(() {
                                    selectedPermissionInRole =
                                        selectedKey.cast<int>();
                                  });
                                })),
                      )
                    ],
                  ),
                )),
              ],
            )),
      );
    });
  }

  void onAddPermission(
      List<int> selectedPermissionIds, int roleId, int moduleId) async {
    if (selectedPermissionIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a permisison to add')));
      return;
    }
    try {
      final response = await permissionAuthorizationAPI.addPermission(
          selectedPermissionIds, roleId, moduleId);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Permission add successfully')));
        await fetchData();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Permission add failed')));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void onRemovePermission(
      List<int> selectedPermissionIds, int roleId, int moduleId) async {
    if (selectedPermissionIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a permisison to remove')));
      return;
    }
    try {
      final response = await permissionAuthorizationAPI.removePermission(
          selectedPermissionIds, roleId, moduleId);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Permission remove successfully')));
        await fetchData();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Permission remove failed')));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
