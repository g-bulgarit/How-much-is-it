import 'package:flutter/material.dart'; // to use the Color class

// This file holds all colors constant, so I can reference them
// without explicitly typing out the color every time.
// Maybe later I will move these to the :constants.dart: file.

// Theme

final appTheme = new ThemeData(
      fontFamily: 'Bebas',
      textTheme: TextTheme(
        title: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: textColorMain),
        body1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: textColorMain),
        body2: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: textColorMain),
        subtitle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: textColorMain),
        ),
      );

// Background colors:
const Color backgroundColorAccent = Color(0xFF379683);
const Color backgroundColorMain = Color(0xFF5CDB95);
const Color backgroundGradientBottom = Color(0xFF11998e);
const Color backgroundGradientTop = Color(0xFF38ef7d);

// Foreground colors:
const Color foregroundColorMain = Color(0xFF8EE4AF);
const Color foregroundColorDark = Color(0xFF1ca3ff);
const Color foregroundColorInner = Color(0xFF2ad6e8);
const Color foregroundAccent = Color(0xFF6feda8);

// Text colors
const Color textColorMain = Color(0xFFEDF5E1);
const Color textColorHint = Color(0xFF379683);


// Gradients
const Color gradientBottom = Color(0xFF1FA2FF);
const Color gradientCenter = Color(0xFF12D8FA);
const Color gradientTop = Color(0xFFA6FFCB);

// Color reference taken from some of these:
// https://visme.co/blog/wp-content/uploads/2016/09/website25-1024x512.jpg