import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/account.d.dart';
import 'package:heart_attack_detection_fe/services/AccountApi.dart';
import 'package:heart_attack_detection_fe/services/role.dart';

class ListRole extends StatefulWidget {
  final String? selectedRoleId;
  final Function(String?) setFilters;

  const ListRole({
    Key? key,
    required this.selectedRoleId,
    required this.setFilters,
  }) : super(key: key);

  @override
  State<ListRole> createState() => _ListRoleState();
}

class _ListRoleState extends State<ListRole> {
  List<Account> accounts = [];
  String? dropdownValue;
  String? accountName;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchAllAccount();
  }

  Future<void> fetchAllAccount() async {
    final response = await AccountAPI.fetchAccount();
    setState(() {
      accounts = response;
    });
  }

  Future<void> getRoleByAccount(int accountId) async {
    final response = await RoleAPI.getRoleByAccount(accountId);
    setState(() {
      accountName = response?['name'] ?? 'No role';
    });
    final roleId = response?['id'];
    print('RoleId-listRole: $roleId');
    widget.setFilters(roleId);
  }

  void onChangeDropDown(String? value) {
    setState(() {
      dropdownValue = value;
      if (value != null) {
        final selectedAccountId =
            accounts.firstWhere((account) => account.id.toString() == value).id;
        getRoleByAccount(selectedAccountId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4, left: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select Item',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: accounts.map((Account account) {
                return DropdownMenuItem<String>(
                  value: account.id.toString(),
                  child: Text(
                    account.username!,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              value: dropdownValue,
              onChanged: onChangeDropDown,
              buttonStyleData: ButtonStyleData(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 42,
                width: 140,
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
                  },
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 170,
          height: 50,
          child: Card(
            color: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.grey),
            ),
            child: ListTile(
                title: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  accountName ?? 'No role',
                  textAlign: TextAlign.center,
                ),
              ),
            )),
          ),
        ),
      ],
    );
  }
}
