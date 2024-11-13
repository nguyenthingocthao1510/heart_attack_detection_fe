import 'package:flutter/material.dart';

Widget radioInput({
  required String label,
  required dynamic value,
  required dynamic groupValue,
  required ValueChanged<dynamic> onChanged,
}) {
  return Row(
    children: [
      Radio<dynamic>(
        value: value,
        groupValue: groupValue,
        activeColor: const Color.fromARGB(255, 20, 139, 251),
        onChanged: (newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
      Text(label),
    ],
  );
}
