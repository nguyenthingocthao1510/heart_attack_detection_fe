import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/moduleAuthorization.d.dart';
import 'package:heart_attack_detection_fe/pages/admin/ModuleAuthorization/ModuleTableAuthorization/ModuleTable/index.dart';
import 'package:heart_attack_detection_fe/services/moduleAuthorization.dart';

class ModuleTableAuthorization extends StatefulWidget {
  final String? roleId;

  const ModuleTableAuthorization({super.key, required this.roleId});

  @override
  State<ModuleTableAuthorization> createState() =>
      _ModuleTableAuthorizationState();
}

class _ModuleTableAuthorizationState extends State<ModuleTableAuthorization> {
  List<ModuleRole> moduleInRoles = [];
  List<ModuleRole> moduleNotInRoles = [];
  List<int> selectedKeysNotInRole = [];
  List<int> selectedKeysInRole = [];
  ModuleRoleAPI moduleRoleAPI = ModuleRoleAPI();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didUpdateWidget(covariant ModuleTableAuthorization oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.roleId != oldWidget.roleId) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    await getAllModuleNotInRole();
    await getAllModuleInRole();
  }

  Future<void> getAllModuleNotInRole() async {
    final roleId = int.parse(widget.roleId!);
    final response = await moduleRoleAPI.getAllModuleNotInRole(roleId);

    setState(() {
      moduleNotInRoles = response;
    });
  }

  Future<void> getAllModuleInRole() async {
    final roleId = int.parse(widget.roleId!);
    final response = await moduleRoleAPI.getAllModuleInRole(roleId);

    setState(() {
      moduleInRoles = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Module not in role',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 180,
                          child: Expanded(
                            child: ModuleTable(
                              modules: moduleNotInRoles,
                              onSelectedModulesChange: (selectedKey) {
                                setState(() {
                                  selectedKeysNotInRole =
                                      selectedKey.cast<int>();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    height: 180,
                    width: 100,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
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
                                      onPressed: () => onAddModule(
                                        selectedKeysNotInRole,
                                        widget.roleId,
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
                                      onPressed: () => onRemoveModule(
                                        selectedKeysInRole,
                                        int.parse(widget.roleId!),
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
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Module in role',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      child: Expanded(
                        child: ModuleTable(
                          modules: moduleInRoles,
                          onSelectedModulesChange: (selectedKey) {
                            setState(() {
                              selectedKeysInRole = selectedKey.cast<int>();
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  void onAddModule(List<int> selectedModuleIds, String? roleId) async {
    if (selectedModuleIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a module to add.')),
      );
      return;
    }

    final int parsedRoleId = int.parse(roleId!);

    try {
      final response =
          await moduleRoleAPI.addModule(selectedModuleIds, parsedRoleId);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Module added successfully.')),
        );
        await fetchData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add module.')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  void onRemoveModule(List<int> selectedModuleIds, int roleId) async {
    if (selectedModuleIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a module to remove.')),
      );
      return;
    }

    try {
      final response =
          await moduleRoleAPI.removeModule(selectedModuleIds, roleId);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Module remove successfully.')),
        );
        await fetchData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to remove module.')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
