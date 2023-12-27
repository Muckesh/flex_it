import 'package:flex_it/components/exercise_tile.dart';
import 'package:flex_it/data/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  //  exercise name controller
  final exerciseNameController = TextEditingController();

  //  exercise reps controller
  final repsController = TextEditingController();

  //  exercise sets controller
  final setsController = TextEditingController();
// checkbox

  void onCheckboxTapped(bool? iscompleted, WorkoutData value, int index) {
    setState(() {
      value
          .getRelevantWorkout(widget.workoutName)
          .exercises[index]
          .isCompleted = iscompleted!;
    });
  }

  // on checkbox changed
  void onCheckboxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  // delete

  // create new exercise

  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Exercise"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // exercise name
            TextField(
              controller: exerciseNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Exercise",
                // hintStyle: TextStyle(
                //   color: Colors.white54,
                // ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // number of sets
            TextField(
              controller: setsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Sets",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // number of reps
            TextField(
              controller: repsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Reps",
                // hintStyle: TextStyle(
                //   color: Colors.white54,
                // ),
              ),
            ),
          ],
        ),
        actions: [
          // save
          MaterialButton(
            onPressed: cancel,
            child: const Text("Cancel"),
          ),

          // cancel

          MaterialButton(
            onPressed: save,
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void save() {
    String newExercise = exerciseNameController.text;
    String noOfReps = repsController.text;
    String noOfSets = setsController.text;
    if (newExercise.isNotEmpty && noOfSets.isNotEmpty && noOfReps.isNotEmpty) {
      Provider.of<WorkoutData>(context, listen: false)
          .addExercise(widget.workoutName, newExercise, noOfSets, noOfReps);
    }

    // pop dialog
    Navigator.pop(context);

    // clear controller
    clear();
  }

  // Cancel()
  void cancel() {
    // pop dialog
    Navigator.pop(context);

    // clear controller
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    setsController.clear();
    repsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: Text(widget.workoutName),
          centerTitle: true,
          backgroundColor: Colors.grey.shade200,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              // Cover imae of the workout
              Image.asset(value.getRelevantWorkout(widget.workoutName).img),

              // Exercise Table
              value.numberOfExercisesInWorkout(widget.workoutName) == 0
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Text(
                          " + Add Exercises ",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        // Header Row
                        // Data Rows
                        Column(
                          children: List.generate(
                            value
                                .numberOfExercisesInWorkout(widget.workoutName),
                            (index) => GestureDetector(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Delete Exercise"),
                                    content: const Text("Are you sure ?"),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          Provider.of<WorkoutData>(context,
                                                  listen: false)
                                              .deleteExercise(
                                                  widget.workoutName,
                                                  value
                                                      .getRelevantWorkout(
                                                          widget.workoutName)
                                                      .exercises[index]
                                                      .name);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              onTap: () => onCheckboxChanged(
                                widget.workoutName,
                                value
                                    .getRelevantWorkout(widget.workoutName)
                                    .exercises[index]
                                    .name,
                              ),
                              child: ExerciseTile(
                                exerciseName: value
                                    .getRelevantWorkout(widget.workoutName)
                                    .exercises[index]
                                    .name,
                                sets: value
                                    .getRelevantWorkout(widget.workoutName)
                                    .exercises[index]
                                    .sets,
                                reps: value
                                    .getRelevantWorkout(widget.workoutName)
                                    .exercises[index]
                                    .reps,
                                isCompleted: value
                                    .getRelevantWorkout(widget.workoutName)
                                    .exercises[index]
                                    .isCompleted,
                                onCheckboxChanged: (val) => onCheckboxChanged(
                                  widget.workoutName,
                                  value
                                      .getRelevantWorkout(widget.workoutName)
                                      .exercises[index]
                                      .name,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
