import 'package:flutter/material.dart';

Widget textFieldInput({
  required BuildContext context,
  required TextEditingController controller,
  required String label
}) {
  return Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
  ),
  padding: const EdgeInsets.all(24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
          ),
      ),
      const SizedBox(height: 24),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusColor: Color.fromARGB(255, 20, 139, 251),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(24),
          //   borderSide: const BorderSide(
          //     color:Colors.black,
          //     width: 2.0,
          //   ),
          // ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 20, 139, 251),
              width: 4.0,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    ],
  )
  );
}