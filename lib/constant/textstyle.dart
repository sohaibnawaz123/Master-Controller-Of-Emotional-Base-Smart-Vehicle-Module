import 'package:flutter/material.dart';
import 'package:testapp/constant/color.dart';

TextStyle textStyle(
    {String fontFamily = "Poppins-R",
    required double size,
    required Color color}) {
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: size,
    color: color,
  );
}

TextStyle alfaSlabOneOutline({
  String fontFamily = "AlfaSlabOne",
  required double size,
  Color color = subheadingcolor
}) {
  return TextStyle(
    letterSpacing: 1.0,
    fontFamily: fontFamily,
    fontSize: size,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = color,
  );
}

TextStyle alfaSlabOne(
    {String fontFamily = "Poppins-M",
    required double size,
    Color color = headingcolor}) {
  return TextStyle(fontFamily: fontFamily, fontSize: size, color: color
  ,);
}
