import 'package:flex_it/models/exercise.dart';
import 'package:flex_it/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutData extends ChangeNotifier {
  // list of workouts

  List<Workout> workoutList = [
    Workout(
      name: "Abs",
      img: "assets/images/abs.png",
      exercises: [
        Exercise(
          name: "Crunches",
          sets: "3",
          reps: "10",
        ),
        Exercise(
          name: "Russian Twists",
          sets: "3",
          reps: "12",
        ),
      ],
    ),
    Workout(
      name: "Back",
      img: "assets/images/back.png",
      exercises: [
        Exercise(
          name: "Diamond Pushups",
          sets: "3",
          reps: "12",
        ),
        Exercise(
          name: "Wide Pushups",
          sets: "3",
          reps: "12",
        ),
      ],
    ),
    Workout(
      name: "Biceps",
      img: "assets/images/biceps.png",
      exercises: [],
    ),
    Workout(
      name: "Glutes",
      img: "assets/images/glutes.png",
      exercises: [
        Exercise(
          name: "Diamond Pushups",
          sets: "3",
          reps: "12",
        ),
        Exercise(
          name: "Wide Pushups",
          sets: "3",
          reps: "12",
        ),
      ],
    ),
    Workout(
      name: "Hamstrings",
      img: "assets/images/hamstrings.png",
      exercises: [
        Exercise(
          name: "Diamond Pushups",
          sets: "3",
          reps: "12",
        ),
        Exercise(
          name: "Wide Pushups",
          sets: "3",
          reps: "12",
        ),
      ],
    ),
    Workout(
      name: "Lower Back",
      img: "assets/images/lower_back.png",
      exercises: [
        Exercise(
          name: "Diamond Pushups",
          sets: "3",
          reps: "12",
        ),
        Exercise(
          name: "Wide Pushups",
          sets: "3",
          reps: "12",
        ),
      ],
    ),
    Workout(
      name: "Quadriceps",
      img: "assets/images/quadriceps.png",
      exercises: [
        Exercise(
          name: "Diamond Pushups",
          sets: "3",
          reps: "12",
        ),
        Exercise(
          name: "Wide Pushups",
          sets: "3",
          reps: "12",
        ),
      ],
    ),
    Workout(
      name: "Shoulders",
      img: "assets/images/shoulders.png",
      exercises: [
        Exercise(
          name: "Diamond Pushups",
          sets: "3",
          reps: "12",
        ),
        Exercise(
          name: "Wide Pushups",
          sets: "3",
          reps: "12",
        ),
      ],
    ),
    Workout(
      name: "Triceps",
      img: "assets/images/triceps.png",
      exercises: [
        Exercise(
          name: "Diamond Pushups",
          sets: "3",
          reps: "12",
        ),
        Exercise(
          name: "Wide Pushups",
          sets: "3",
          reps: "12",
        ),
      ],
    ),
    Workout(
      name: "Chest",
      img: "assets/images/chest.png",
      exercises: [
        Exercise(
          name: "Diamond Pushups",
          sets: "3",
          reps: "12",
        ),
        Exercise(
          name: "Wide Pushups",
          sets: "3",
          reps: "12",
        ),
      ],
    ),
  ];

  // get list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // get length of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  // add a workout
  void addWorkout(String name, String img) {
    workoutList.add(Workout(name: name, img: img, exercises: []));
    notifyListeners();
  }

  // add a new exercise to a workout
  void addExercise(
      String workoutName, String exerciseName, String sets, String reps) {
    // fetching the correct workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises
        .add(Exercise(name: exerciseName, reps: reps, sets: sets));
    notifyListeners();
  }

  // check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    // fetch correct workout and exercise
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    // checking off boolean to indicate completion status
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

  // return relevant workout object from a given workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  // return relevant workout object from a given workout name and exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    // find relevant workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    // find relevant exercise
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
}
