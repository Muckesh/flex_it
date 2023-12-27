import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String sets;
  final String reps;
  final bool isCompleted;
  final void Function(bool?)? onCheckboxChanged;

  const ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.sets,
    required this.reps,
    required this.isCompleted,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isCompleted ? Colors.greenAccent.shade400 : Colors.grey.shade400,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            side: MaterialStateBorderSide.resolveWith(
              (states) => const BorderSide(width: 2.0, color: Colors.white),
            ),
            fillColor: isCompleted
                ? MaterialStateColor.resolveWith((states) => Colors.greenAccent)
                : MaterialStateColor.resolveWith(
                    (states) => Colors.grey.shade400,
                  ),
            value: isCompleted,
            onChanged: onCheckboxChanged,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exerciseName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Chip(
                    side: const BorderSide(
                      width: 2.0,
                      style: BorderStyle.solid,
                      color: Colors.white,
                    ),
                    backgroundColor:
                        isCompleted ? Colors.greenAccent.shade400 : Colors.grey,
                    label: Text(
                      "$sets sets",
                      style: const TextStyle(
                        // fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Chip(
                    side: const BorderSide(
                      width: 2.0,
                      style: BorderStyle.solid,
                      color: Colors.white,
                    ),
                    backgroundColor:
                        isCompleted ? Colors.greenAccent.shade400 : Colors.grey,
                    label: Text(
                      "$reps reps",
                      style: const TextStyle(
                        // fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
