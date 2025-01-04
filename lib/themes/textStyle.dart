import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle baseStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle style({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    FontStyle? fontStyle,
    double? letterSpacing,
  }) {
    return baseStyle.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
    );
  }
  static TextStyle textStyle1(double? fontSize, Color? color) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold
    );
  }
  static TextStyle textStyle2(double? fontSize, Color? color) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.normal
    );
  }
}
