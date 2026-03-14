import 'package:flutter/material.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/current_cardio_data.dart';
import 'package:gympanion/views/data/current_workout_data.dart';
import 'package:gympanion/views/data/notifiers.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key, required this.color, required this.timerText});
  final Color color;
  final ValueNotifier<String> timerText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
                color: Colors.green),
            child: ValueListenableBuilder<TrainingMode>(
                valueListenable: currentTrainingMode,
                builder: (context, value, child) {
                  return Text(
                    value == TrainingMode.workout
                        ? Provider.of<CurrentWorkoutData>(context)
                            .workoutDayName
                        : Provider.of<CurrentCardioData>(context).cardioTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  );
                }),
          ),
          ValueListenableBuilder<String>(
            valueListenable: timerText,
            builder: (context, timerValue, child) => Text(
              timerValue,
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
