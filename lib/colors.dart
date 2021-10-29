import 'package:flutter/material.dart'; // to use the Color class

// This file holds all colors constant, so I can reference them
// without explicitly typing out the color every time.

// Theme colors
final appTheme = new ThemeData(
  fontFamily: 'Bebas',
  textTheme: TextTheme(
    headline1: TextStyle(
        fontSize: 30.0, fontWeight: FontWeight.bold, color: textColorMain),
    bodyText1: TextStyle(
        fontSize: 26.0, fontWeight: FontWeight.bold, color: textColorMain),
    bodyText2: TextStyle(
        fontSize: 25.0, fontWeight: FontWeight.bold, color: textColorMain),
    subtitle1: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.normal, color: textColorMain),
    subtitle2: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w100, color: textColorMain),
  ),
);

// Foreground colors:
const Color foregroundColorInner = Color(0xFFFFFFFF);
const Color foregroundColorDark = Color(0xFF9d50bb);

// Text colors
const Color textColorMain = Color(0xFFEDF5E1);

// Gradients
const Color gradientBottom = Color(0xFF9d50bb);
const Color gradientTop = Color(0xFF6e48aa);
