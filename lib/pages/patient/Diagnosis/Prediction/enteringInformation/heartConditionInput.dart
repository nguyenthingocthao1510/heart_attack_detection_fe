import 'package:flutter/material.dart';

Widget heartConditionInput(
  TextEditingController textController
  ) {
  return TextField(
    controller: textController,
    decoration:  InputDecoration(
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
          width: 2.0,
        ),
      ),
    ),
    keyboardType: TextInputType.number,
  );
}