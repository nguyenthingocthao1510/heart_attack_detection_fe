import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';

class SnackBarComponent {
  static SnackBar createSnackBar({
    required String content,
    required String type,
  }) {
    Color? backgroundColor = _changeColor(type);
    return SnackBar(
      content: Text(
        content,
        style: CustomTextStyle.textStyle2(16, Colors.white),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        top: 50,
        left: 10,
        right: 10,
        bottom: 700
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }

  static Color? _changeColor(String type) {
    switch (type) {
      case "success":
        return Colors.green;
      case "error":
        return Colors.red;
      default:
        return null;
    }
  }
}
