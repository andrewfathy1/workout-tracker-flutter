import 'package:flutter/material.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/current_cardio_data.dart';
import 'package:gympanion/views/data/current_workout_data.dart';
import 'package:gympanion/views/pages/activity_browser_page.dart';
import 'package:provider/provider.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key, required this.activityType});

  final ActivityType activityType;
  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  String selectedKey = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...workoutRatings.entries.map(
            (e) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedKey = e.key;
                  widget.activityType == ActivityType.workout
                      ? Provider.of<CurrentWorkoutData>(context, listen: false)
                          .workoutRating = selectedKey
                      : Provider.of<CurrentCardioData>(context, listen: false)
                          .cardioSessionRating = selectedKey;
                });
              },
              child: Card(
                color: selectedKey == e.key ? Colors.green : Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        e.value,
                        style: TextStyle(fontSize: 26),
                      ),
                      Text(e.key),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
