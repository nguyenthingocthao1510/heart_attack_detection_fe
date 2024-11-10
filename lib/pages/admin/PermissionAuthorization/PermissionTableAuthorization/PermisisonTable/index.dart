import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/permissionAuthorization.dart';

class PermissionTable extends StatefulWidget {
  final List<PermissionAuthorization> permissions;
  final Function(List<int>) onSelectedPermissionChange;

  const PermissionTable(
      {super.key,
      required this.permissions,
      required this.onSelectedPermissionChange});

  @override
  State<PermissionTable> createState() => _PermissionTableState();
}

class _PermissionTableState extends State<PermissionTable> {
  List<int> selectedPermission = [];
  List<PermissionAuthorization> permissions = [];

  void onChecked(bool? value, int permissionId) {
    setState(() {
      if (value == true) {
        selectedPermission.add(permissionId);
      } else {
        selectedPermission.remove(permissionId);
      }
      widget.onSelectedPermissionChange(selectedPermission);
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
      border: TableBorder.all(color: Colors.grey),
      minWidth: 600,
      headingRowHeight: 35,
      columns: [
        DataColumn2(
            fixedWidth: 50,
            label: Center(
              child: Icon(Icons.check_box_outline_blank, color: Colors.black),
            )),
        DataColumn2(
            label: SizedBox(
          width: 300,
          child: Text(
            'Name',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ))
      ],
      rows: widget.permissions
          .map((permission) => DataRow2(specificRowHeight: 50, cells: [
                DataCell(SizedBox(
                  child: Center(
                    child: Checkbox(
                      value: selectedPermission.contains(permission.id),
                      onChanged: (bool? value) =>
                          onChecked(value, permission.id!),
                    ),
                  ),
                )),
                DataCell(SizedBox(
                  child: Text(permission.name!),
                ))
              ]))
          .toList(),
    );
  }
}
