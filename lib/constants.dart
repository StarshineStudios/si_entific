import 'package:flutter/material.dart';

const mediumTeal = Color.fromARGB(255, 33, 139, 130);
const lightTeal = Color.fromARGB(255, 152, 212, 187);
const darkTeal = Color.fromARGB(255, 7, 71, 65);

// Define a custom TextTheme with Nunito font
const TextTheme nunitoTextTheme = TextTheme(
  displayLarge: TextStyle(fontFamily: 'Nunito', fontSize: 96.0, fontWeight: FontWeight.w300),
  displayMedium: TextStyle(fontFamily: 'Nunito', fontSize: 60.0, fontWeight: FontWeight.w300),
  displaySmall: TextStyle(fontFamily: 'Nunito', fontSize: 48.0, fontWeight: FontWeight.w400),
  headlineMedium: TextStyle(fontFamily: 'Nunito', fontSize: 34.0, fontWeight: FontWeight.w400),
  headlineSmall: TextStyle(fontFamily: 'Nunito', fontSize: 24.0, fontWeight: FontWeight.w400),
  titleLarge: TextStyle(fontFamily: 'Nunito', fontSize: 20.0, fontWeight: FontWeight.w500),
  titleMedium: TextStyle(fontFamily: 'Nunito', fontSize: 16.0, fontWeight: FontWeight.w400),
  titleSmall: TextStyle(fontFamily: 'Nunito', fontSize: 14.0, fontWeight: FontWeight.w500),
  bodyLarge: TextStyle(fontFamily: 'Nunito', fontSize: 16.0, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontFamily: 'Nunito', fontSize: 14.0, fontWeight: FontWeight.w400),
  labelLarge: TextStyle(fontFamily: 'Nunito', fontSize: 14.0, fontWeight: FontWeight.w700),
  bodySmall: TextStyle(fontFamily: 'Nunito', fontSize: 12.0, fontWeight: FontWeight.w400),
  labelSmall: TextStyle(fontFamily: 'Nunito', fontSize: 10.0, fontWeight: FontWeight.w400),
);
