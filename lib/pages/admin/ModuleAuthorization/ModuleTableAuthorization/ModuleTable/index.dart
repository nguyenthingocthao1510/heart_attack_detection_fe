import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/moduleAuthorization.d.dart';

class ModuleTable extends StatefulWidget {
  final List<ModuleRole> modules;
  final Function(List<int>) onSelectedModulesChange;

  const ModuleTable({
    required this.modules,
    required this.onSelectedModulesChange,
    super.key,
  });

  @override
  State<ModuleTable> createState() => _ModuleTableState();
}

class _ModuleTableState extends State<ModuleTable> {
  List<int> selectedModules = [];
  List<ModuleRole> module = [];

  void onChecked(bool? value, int moduleId) {
    setState(() {
      if (value == true) {
        selectedModules.add(moduleId);
      } else {
        selectedModules.remove(moduleId);
      }
      widget.onSelectedModulesChange(selectedModules);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
      headingRowColor: MaterialStateProperty.all(Colors.blue[200]),
      headingTextStyle: TextStyle(color: Colors.black),
      dataRowColor: MaterialStateProperty.all(Colors.white),
      border: TableBorder.all(
        color: Colors.grey,
      ),
      minWidth: 600,
      headingRowHeight: 35,
      columns: [
        DataColumn2(fixedWidth: 20, label: Center(child: Text(''))),
        DataColumn2(
            label: SizedBox(
          width: 300,
          child: Text(
            'Name',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        DataColumn2(
            label: SizedBox(
          width: 300,
          child: Text(
            'Route',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
      ],
      rows: widget.modules
          .map((module) => DataRow2(
                specificRowHeight: 50,
                cells: [
                  DataCell(
                    Center(
                      child: Checkbox(
                        value: selectedModules.contains(module.id),
                        onChanged: (bool? value) =>
                            onChecked(value, module.id!),
                      ),
                    ),
                  ),
                  DataCell(SizedBox(
                    child: Text(module.name!),
                  )),
                  DataCell(SizedBox(
                    child: Text(module.route ?? 'No route'),
                  )),
                ],
              ))
          .toList(),
    );
  }
}
