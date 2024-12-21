import 'package:flutter/material.dart';

Widget radioInput<T>({
  required List<T> options,
  required T groupValue,
  required ValueChanged<T> onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: options.map((option) {
      return Row(
        children: [
          Radio<T>(
            value: option,
            groupValue: groupValue,
            activeColor: const Color.fromARGB(255, 20, 139, 251),
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
          Text(option.toString()),
        ],
      );
    }).toList(),
  );
}
