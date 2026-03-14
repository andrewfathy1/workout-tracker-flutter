import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gympanion/utils/widget_utils.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/current_workout_data.dart';
import 'package:gympanion/views/data/workouts_data.dart';
import 'package:gympanion/views/pages/activity_browser_page.dart';
import 'package:gympanion/views/pages/start_workout_page.dart';
import 'package:gympanion/views/widgets/edit_exercise_widget.dart';
import 'package:gympanion/views/widgets/rating_widget.dart';
import 'package:gympanion/views/widgets/timer_widget.dart';
import 'package:gympanion/views/widgets/wide_button.dart';
import 'package:provider/provider.dart';

class CurrentWorkoutPage extends StatelessWidget {
  const CurrentWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentWorkoutData>(
      builder: (context, currentWorkoutData, child) => Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Column(
          children: [
            currentWorkoutData.workoutStarted
                ? TimerWidget(
                    color: AppColors.workoutColor,
                    timerText: CurrentWorkoutData.timerText,
                  )
                : SizedBox.shrink(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  color: Colors.transparent,
                  clipBehavior: Clip.hardEdge,
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 16),
                        ...currentWorkoutData.currentExercises.map(
                          (e) => Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  showEditExerciseWidget(context, e);
                                },
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                child: ListTile(
                                  tileColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  title: Text(e.title),
                                  trailing: Icon(Icons.edit),
                                  subtitle: Text('${e.sets.length} Sets'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Spacer(),
                        SizedBox(
                          height: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              showStartWorkoutPage(context, Mode.add);
                            },
                            child: Text('Add Exercise'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            currentWorkoutData.workoutStarted
                ? WideButton(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: AlertDialog(
                            title: Text(
                              'Congratulations',
                              style: AppTextStyles.displayMedium,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'You\'ve successfully finished your ${currentWorkoutData.workoutDayName} in ${currentWorkoutData.formatTimer(currentWorkoutData.timeElapsed)}',
                                  style: AppTextStyles.bodyLarge,
                                ),
                                Divider(),
                                Text(
                                  'How was your workout?',
                                  style: AppTextStyles.bodyLarge,
                                ),
                                RatingWidget(
                                  activityType: ActivityType.workout,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Provider.of<CurrentWorkoutData>(context,
                                          listen: false)
                                      .endWorkout();
                                  Provider.of<WorkoutsData>(context,
                                          listen: false)
                                      .resetExercises();

                                  showSnackBar(context, 'Workout completed 💪',
                                      Colors.green);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Done',
                                  style: AppTextStyles.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    title: 'End Workout',
                    color: AppColors.workoutColor)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
