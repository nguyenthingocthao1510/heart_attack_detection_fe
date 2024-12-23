import 'package:flutter/material.dart';

class CustomDivider {
  static Divider divider1(BuildContext context) {
    return Divider(
      height: MediaQuery.of(context).size.height * 0.1,
      thickness: 1,
      indent: MediaQuery.of(context).size.width * 0.05,
      endIndent: MediaQuery.of(context).size.width * 0.05,
      color: Colors.white,
    );
  }

  static Divider divider2(BuildContext context, height) {
    return Divider(
      height: MediaQuery.of(context).size.height * height,
      thickness: 2,
      color: const Color.fromARGB(255, 238, 238, 238),
    );
  }
}