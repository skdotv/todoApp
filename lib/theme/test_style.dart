import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CommonTextStyle {
  static TextStyle titleStyle() => TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );
  static TextStyle subTitleStyle() => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade700,
      );
  static TextStyle normalTextStyle(
          {Color color, FontWeight fontWeight = FontWeight.normal}) =>
      TextStyle(
        fontSize: 16,
        fontWeight: fontWeight,
        color: color,
      );
}
