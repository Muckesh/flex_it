import 'package:flex_it/components/custom_heat_map.dart';
import 'package:flex_it/components/workout_card.dart';
import 'package:flex_it/data/workout_data.dart';
import 'package:flex_it/pages/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // got to workout page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: workoutName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: const Text("F L E X I T"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: ListView.builder(
            itemCount: value.getWorkoutList().length,
            itemBuilder: (context, index) => InkWell(
              onTap: () => goToWorkoutPage(value.getWorkoutList()[index].name),
              child: WorkoutCard(
                img: value.getWorkoutList()[index].img,
                noOfExercises: value.getWorkoutList()[index].exercises.length,
                workout: value.getWorkoutList()[index].name,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
