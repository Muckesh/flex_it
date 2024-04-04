import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  // appBarTheme: const AppBarTheme(
  //   centerTitle: true,
  //   scrolledUnderElevation: 0.0,
  //   backgroundColor: Colors.black,
  //   titleTextStyle: TextStyle(
  //     color: Colors.white,
  //     fontSize: 24.0,
  //     fontWeight: FontWeight.w900,
  //   ),
  // ),
  fontFamily: "VarelaRound-Regular",
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey.shade400,
    secondary: Colors.grey.shade900,
    onPrimary: Colors.white,
    tertiary: Colors.grey[600],
  ),
);
