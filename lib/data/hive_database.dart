import 'package:hive/hive.dart';
import 'package:flex_it/datetime/date_time.dart';
import 'package:flex_it/models/exercise.dart';
import 'package:flex_it/models/workout.dart';

class HiveDatabase {
  //  refer our hive box

  final _mybox = Hive.box("workout_database");

  //  check if data already exists, if not record start date

  bool prevDataExists() {
    if (_mybox.isEmpty) {
      // print("No previous data");
      _mybox.put("START_DATE", todaysDateYYYYMMDD());
      return false;
    } else {
      // print("Previous data does exist");
      return true;
    }
  }

  //  return start date as yyyymmdd
  String getStartDate() {
    return _mybox.get("START_DATE");
  }

  // save percent
  void savePercent(String percent) {
    _mybox.put("PERCENTAGE_SUMMARY_${todaysDateYYYYMMDD()}", percent);
  }

  // get percent
  String getPercent(String yyyymmdd) {
    return _mybox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? '0.0';
  }
  // write data

  void saveToDatabase(List<Workout> workouts) {
    // convert workout objs to list of strings to save in HIVE
    final workoutList = convertObjToWorkoutList(workouts);
    final exerciseList = convertObjToExerciseList(workouts);

    // check if exercise done
    if (exerciseComplete(workouts)) {
      _mybox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}", 1);
    } else {
      _mybox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}", 0);
    }

    // save into HIVE
    _mybox.put("WORKOUTS", workoutList);
    _mybox.put("EXERCISES", exerciseList);
  }

  // read data, and return a list of workouts
  List<Workout> readFromDatabase() {
    List<Workout> mySavedWorkouts = [];

    List<String> workoutNames = _mybox.get("WORKOUTS");
    final exerciseDetails = _mybox.get("EXERCISES");

    // create workout objects
    for (int i = 0; i < workoutNames.length; i++) {
      // each workout can have multiple exercises
      List<Exercise> exercisesInEachWorkout = [];

      for (int j = 0; j < exerciseDetails[i].length; j++) {
        // add each exercise into a List
        exercisesInEachWorkout.add(
          Exercise(
            name: exerciseDetails[i][j][0],
            sets: exerciseDetails[i][j][1],
            reps: exerciseDetails[i][j][2],
            isCompleted: exerciseDetails[i][j][3] == "true" ? true : false,
          ),
        );
      }
      // create individual workout
      Workout workout = Workout(
        name: workoutNames[i],
        img: workoutNames[i] == "Lower Back"
            ? "assets/images/lower_back.png"
            : "assets/images/${workoutNames[i].toLowerCase()}.png",
        exercises: exercisesInEachWorkout,
      );

      // add individual workout to database
      mySavedWorkouts.add(workout);
    }
    return mySavedWorkouts;
  }

  // check if any exercises have been done in

  bool exerciseComplete(List<Workout> workouts) {
    // loop thru each workout
    for (var workout in workouts) {
      // go thru each exercise in workout
      for (var exercise in workout.exercises) {
        if (exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }

  // return completion status of a given date yyyymmdd
  int getCompletionStatus(String yyyymmdd) {
    // returns 0 or 1, if null then return 0
    int completionStatus = _mybox.get("COMPLETION_STATUS_$yyyymmdd") ?? 0;
    return completionStatus;
  }
}

// convert workout obj to list -> [abs, back]

List<String> convertObjToWorkoutList(List<Workout> workouts) {
  List<String> workoutList = [
    // [abs,back]
  ];

  for (int i = 0; i < workouts.length; i++) {
    workoutList.add(workouts[i].name);
  }
  return workoutList;
}

//  convert exercises in a workout object into a list of strings

List<List<List<String>>> convertObjToExerciseList(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [
    /* 
        [
         [ abs
          [[crunches,3sets,10reps],[crunches,3sets,10reps]],
        ],

        [  back
          [[crunches,3sets,10reps],[crunches,3sets,10reps]],
          ],
        ]
    */
  ];
  for (int i = 0; i < workouts.length; i++) {
    // get exercise from each workout
    List<Exercise> exercisesInWorkout = workouts[i].exercises;

    List<List<String>> individualWorkout = [
      // abs
      // [[crunches,3sets,10reps],[crunches,3sets,10reps]]
    ];
    for (int j = 0; j < exercisesInWorkout.length; j++) {
      List<String> individualExercise = [
        // [crunches,3sets,10reps]
      ];
      individualExercise.addAll(
        [
          exercisesInWorkout[j].name,
          exercisesInWorkout[j].sets,
          exercisesInWorkout[j].reps,
          exercisesInWorkout[j].isCompleted.toString(),
        ],
      );
      individualWorkout.add(individualExercise);
    }
    exerciseList.add(individualWorkout);
  }
  return exerciseList;
}

//
