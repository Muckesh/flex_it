import 'package:flex_it/data/hive_database.dart';
import 'package:flex_it/datetime/date_time.dart';
import 'package:flex_it/models/exercise.dart';
import 'package:flex_it/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();
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
  // if there are workouts already in database, then get that workout list,

  void initializeWorkoutList() {
    if (db.prevDataExists()) {
      workoutList = db.readFromDatabase();
    } else {
      //  otherwise use default list
      db.saveToDatabase(workoutList);
    }
    // load heat map
    loadHeatMap();

    // clear the checkbox at the start of each day
    clearCompletedExercises();
  }

  // clear the checkbox at the start of each day
  void clearCompletedExercises() {
    DateTime currentDate = DateTime.now();
    String currentDateString = convertDateTimeToYYYYMMDD(currentDate);
    for (var workout in workoutList) {
      for (var exercise in workout.exercises) {
        // String exerciseDateString = db.getExerciseDate(exercise.name);
        int status = db.getCompletionStatus(currentDateString);
        if (status == 0) {
          exercise.isCompleted = false;
        }
      }
    }

    db.saveToDatabase(workoutList);
  }

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

    // save to db
    db.saveToDatabase(workoutList);
  }

  // add a new exercise to a workout
  void addExercise(
      String workoutName, String exerciseName, String sets, String reps) {
    // fetching the correct workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises
        .add(Exercise(name: exerciseName, reps: reps, sets: sets));
    notifyListeners();
    // save to db
    db.saveToDatabase(workoutList);
  }

  // delete an exercise
  void deleteExercise(String workoutName, String exerciseName) {
    Workout selectedWorkout = getRelevantWorkout(workoutName);
    selectedWorkout.exercises
        .removeWhere((exercise) => exercise.name == exerciseName);

    notifyListeners();

    // Save to the database after deleting the exercise
    db.saveToDatabase(workoutList);
    // calculate
    calculatePercentage();

    // Load heat map after deleting the exercise
    loadHeatMap();
  }

  // check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    // fetch correct workout and exercise
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    // checking off boolean to indicate completion status
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();

    // save to db
    db.saveToDatabase(workoutList);
    // calculate
    calculatePercentage();
    // load heat map
    loadHeatMap();
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

  // get start date
  String getStartDate() {
    return db.getStartDate();
  }

  // calculate
  void calculatePercentage() {
    int totalExercises = 0, completedExercises = 0;
    for (var workout in workoutList) {
      // print(workout);
      totalExercises += workout.exercises.length;

      completedExercises +=
          workout.exercises.where((exercise) => exercise.isCompleted).length;
    }
    // print(totalExercises);
    // print(completedExercises);
    String percent = totalExercises == 0
        ? '0.0'
        : (completedExercises / totalExercises).toStringAsFixed(1);
    db.savePercent(percent);
  }
  // Heat Map

  Map<DateTime, int> heatMapDataSet = {};

  // load Heat Mao
  void loadHeatMap() {
    // Calculate exerciseCompletedPercentage for each workout and update heatMapDataSet
    // print(workoutList.toList());

    DateTime startDate = createDateTimeObject(getStartDate());
    // print("$exerciseCompletedPercentage percent");
    // count the no of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to roday and add each completion status to dataset
    // COMPLETION_STATUS_yyyymmdd will be key in database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd =
          convertDateTimeToYYYYMMDD(startDate.add(Duration(days: i)));
      // completion status = 0 or 1
      // int completionStatus = db.getCompletionStatus(yyyymmdd);
      // int strengthForDay = completionStatus == 0 ? 0 : strength;
      // strength
      // print(db.getPercent(yyyymmdd));
      // int strength = (double.parse(db.getPercent(yyyymmdd))).toInt();
      // print(strength);
      double strength = double.parse(db.getPercent(yyyymmdd));

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strength).toInt(),
      };
      // print(percentForEachDay);

      // add to heat map dataset
      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
  // print("$totalExercises total");
}
