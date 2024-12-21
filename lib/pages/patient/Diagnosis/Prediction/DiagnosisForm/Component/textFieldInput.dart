import 'package:flutter/material.dart';

Widget textFieldInput({
  required TextEditingController controller,
  required String label
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
          ),
      ),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color:Colors.black,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color:Color.fromARGB(255, 20, 139, 251),
              width: 4.0,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
      const Padding(padding: EdgeInsets.all(12)),
    ],
  );
}