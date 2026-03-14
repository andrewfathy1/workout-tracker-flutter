import 'package:flutter/material.dart';
import 'package:gympanion/extensions/duration_extension.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/workouts_data.dart';
import 'package:gympanion/views/widgets/custom_card_element.dart';
import 'package:gympanion/views/widgets/exercise_summary_widget.dart';

class WorkoutDetailsPage extends StatelessWidget {
  const WorkoutDetailsPage({super.key, required this.workoutJSON});

  final Map<String, dynamic> workoutJSON;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(workoutJSON['dateFinished']),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  workoutJSON['workoutDayName'],
                  style: AppTextStyles.displayLarge,
                ),
              ),
              for (var item in workoutJSON['currentExercises'])
                ExerciseSummaryWidget(exercise: Exercise.fromJson(item)),
              Divider(
                thickness: 5,
              ),
              CustomCardElement(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Other Details',
                          style: AppTextStyles.displayMedium,
                        ),
                      ),
                      Divider(
                        color: Colors.amber,
                      ),
                      Text(
                        'Duration: ${(workoutJSON['timeElapsed'] as int).toReadableDuration()}',
                        style: AppTextStyles.bodyLarge,
                      ),
                      Text(
                        'Overall feeling: ${workoutJSON['rating']}',
                        style: AppTextStyles.bodyLarge,
                      ),
                      Text(
                        'PBs achieved: ',
                        style: AppTextStyles.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
