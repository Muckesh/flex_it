import 'package:flex_it/components/custom_heat_map.dart';
import 'package:flex_it/components/heading_text.dart';
import 'package:flex_it/components/workout_card.dart';
import 'package:flex_it/data/workout_data.dart';
import 'package:flex_it/pages/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }

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
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: const Text("F L E X I T"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              // Activity
              const HeadingText(
                text: "Your Progress",
              ),
              CustomHeatMap(
                startDateYYYYMMDD: value.getStartDate(),
                datasets: value.heatMapDataSet,
              ),
              const HeadingText(
                text: "Muscle Groups",
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.getWorkoutList().length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () =>
                      goToWorkoutPage(value.getWorkoutList()[index].name),
                  child: WorkoutCard(
                    img: value.getWorkoutList()[index].img,
                    noOfExercises:
                        value.getWorkoutList()[index].exercises.length,
                    workout: value.getWorkoutList()[index].name,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
