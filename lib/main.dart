import 'package:flex_it/data/workout_data.dart';
import 'package:flex_it/pages/home_page.dart';
import 'package:flex_it/theme/dark_theme.dart';
import 'package:flex_it/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  // init hive
  await Hive.initFlutter();

  // open hive box
  await Hive.openBox("workout_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
