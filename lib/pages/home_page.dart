import 'package:flex_it/components/custom_heat_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("F L E X I T"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            // Your Progress
            const Text("Your Progress"),
            // Heat Map
            CustomHeatMap(),
            // Muscle Groups
            const Text('Muscle Groups'),
            // Muscle groups list
            Container(
              child: Text("Hello"),
            ),
          ],
        ),
      ),
    );
  }
}
