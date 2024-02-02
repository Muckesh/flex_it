import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade300,
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.black),),
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade300,
    primary: Colors.black54,
    secondary: Colors.white,
  ),
);
