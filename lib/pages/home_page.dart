import 'package:flex_it/components/custom_heat_map.dart';
import 'package:flex_it/components/workout_card.dart';
import 'package:flex_it/data/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("F L E X I T"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: ListView.builder(
            itemCount: value.getWorkoutList().length,
            itemBuilder: (context, index) => WorkoutCard(
              img: value.getWorkoutList()[index].img,
              noOfExercises: value.getWorkoutList()[index].exercises.length,
              workout: value.getWorkoutList()[index].name,
            ),
          ),
        ),
      ),
    );
  }
}
