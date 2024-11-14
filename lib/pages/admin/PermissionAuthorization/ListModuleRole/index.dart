import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/module.d.dart';
import 'package:heart_attack_detection_fe/models/role.dart';
import 'package:heart_attack_detection_fe/services/moduleApi.dart';
import 'package:heart_attack_detection_fe/services/role.dart';

class ListModuleRole extends StatefulWidget {
  final String? selectedRoleId;
  final String? selectedModuleId;
  final Function(String?, String?) setFilters;

  const ListModuleRole(
      {Key? key,
      required this.selectedRoleId,
      required this.selectedModuleId,
      required this.setFilters})
      : super(key: key);

  @override
  State<ListModuleRole> createState() => _ListModuleRoleState();
}

class _ListModuleRoleState extends State<ListModuleRole> {
  List<Module> modules = [];
  List<Role> roles = [];
  String? dropdownRole;
  String? dropdownModule;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getAllRole();
    await getAllModule();
  }

  Future<void> getAllRole() async {
    final response = await RoleAPI.getAllRole();
    setState(() {
      roles = response;
    });
  }

  Future<void> getAllModule() async {
    final response = await ModuleAPI.fetchAllModule();
    setState(() {
      modules = response;
    });
  }

  void onChangeDropDownRole(String? value) {
    setState(() {
      dropdownRole = value;
    });
    widget.setFilters(value, dropdownModule);
  }

  void onChangeDropDownModule(String? value) {
    setState(() {
      dropdownModule = value;
    });
    widget.setFilters(dropdownRole, value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 750,
                  padding: EdgeInsets.only(right: 5),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select role',
                        style: TextStyle(
                            fontSize: 14, color: Theme.of(context).hintColor),
                      ),
                      items: roles.map((Role role) {
                        return DropdownMenuItem<String>(
                          value: role.id.toString(),
                          child: Text(
                            role.name!,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      value: dropdownRole,
                      onChanged: onChangeDropDownRole,
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 40,
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.lightBlueAccent.withOpacity(0.2);
                          }
                          return null;
                        }),
                      ),
                      dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey))),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 750,
                  padding: EdgeInsets.only(left: 5),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select module',
                        style: TextStyle(
                            fontSize: 14, color: Theme.of(context).hintColor),
                      ),
                      items: modules.map((Module module) {
                        return DropdownMenuItem<String>(
                          value: module.id.toString(),
                          child: Text(
                            module.name!,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      value: dropdownModule,
                      onChanged: onChangeDropDownModule,
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 40,
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.lightBlueAccent.withOpacity(0.2);
                          }
                          return null;
                        }),
                      ),
                      dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
