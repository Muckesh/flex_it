import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flex_it/datetime/date_time.dart';

class CustomHeatMap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDateYYYYMMDD;
  const CustomHeatMap(
      {super.key, this.datasets, required this.startDateYYYYMMDD});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(20),
      // ),
      padding: const EdgeInsets.all(25.0),
      child: HeatMap(
        colorMode: ColorMode.color,
        // defaultColor: Theme.of(context).primaryColor,
        // textColor: Theme.of(context).colorScheme.primary,
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        startDate: createDateTimeObject(startDateYYYYMMDD),
        endDate: DateTime.now().add(
          const Duration(days: 0),
        ),
        datasets: datasets,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(20, 2, 179, 8),
          2: Color.fromARGB(40, 2, 179, 8),
          3: Color.fromARGB(60, 2, 179, 8),
          4: Color.fromARGB(80, 2, 179, 8),
          5: Color.fromARGB(100, 2, 179, 8),
          6: Color.fromARGB(120, 2, 179, 8),
          7: Color.fromARGB(150, 2, 179, 8),
          8: Color.fromARGB(180, 2, 179, 8),
          9: Color.fromARGB(220, 2, 179, 8),
          10: Color.fromARGB(255, 2, 179, 8),
          // 1: Color(0xfff2c2ff),
          // 2: Color(0xffe6a5f2),
          // 3: Color(0xffd088e6),
          // 4: Color(0xffb86bd0),
          // 5: Color(0xff9c4fbb),
          // 6: Color.fromARGB(255, 147, 72, 190),
          // 7: Color(0xff622a8d),
          // 8: Color(0xff481a6e),
          // 9: Color(0xff2d0e52),
          // 10: Color(0xff12043e),

          // 1: Colors.deepPurple.shade100,
          // 2: Colors.deepPurple.shade200,
          // 3: Colors.deepPurple.shade300,
          // 4: Colors.deepPurple.shade400,
          // 5: Colors.deepPurple.shade500,
          // 6: Colors.deepPurple.shade600,
          // 7: Colors.deepPurple.shade700,
          // 8: Colors.deepPurple.shade800,
          // 9: Colors.deepPurple.shade900,
          // 10: Colors.deepPurple.shade900,
          // 2: Color.fromARGB(255, 40, 185, 252),
          // 3: Color.fromARGB(255, 93, 200, 250),
          // 4: Color.fromARGB(255, 147, 217, 250),
          // 5: Color.fromARGB(255, 171, 227, 253),
        },
      ),
    );
  }
}
