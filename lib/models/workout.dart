import 'package:flex_it/models/exercise.dart';

class Workout {
  final String name;
  final String img;
  final List<Exercise> exercises;
  Workout({
    required this.name,
    required this.img,
    required this.exercises,
  });
}
