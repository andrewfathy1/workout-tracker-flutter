import 'package:flutter/material.dart';
import 'package:gympanion/views/data/app_data.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/current_workout_data.dart';
import 'package:gympanion/views/data/workouts_data.dart';
import 'package:gympanion/views/widgets/custom_dropdownmenu.dart';
import 'package:gympanion/views/widgets/wide_button.dart';
import 'package:provider/provider.dart';

enum Mode { start, add }

void showStartWorkoutPage(BuildContext ctx, Mode mode) async {
  double? appBarHeight = Scaffold.of(ctx).appBarMaxHeight;

  final result = await showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return Consumer2<WorkoutsData, CurrentWorkoutData>(
        builder: (context, workoutsData, currentWorkoutData, child) =>
            Container(
          padding: EdgeInsets.all(24),
          height: MediaQuery.of(ctx).size.height - appBarHeight! - 120,
          width: MediaQuery.of(ctx).size.width,
          child: Column(
            children: [
              Text(
                mode == Mode.start ? 'Start A Workout' : 'Add A Workout',
                style: AppTextStyles.displayLarge.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16),
              !workoutsData.workotsLoaded
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomDropdownmenu(
                      hint: 'Workout Type',
                      onSelected: (selected) =>
                          currentWorkoutData.selectWhichDay(selected!),
                      entries: workoutsData.workouts.keys
                          .map(
                            (day) => DropdownMenuEntry(
                              style: ButtonStyle(),
                              labelWidget: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.amber)),
                                ),
                                child: Text(
                                  day,
                                  style: AppTextStyles.bodyLarge,
                                ),
                              ),
                              value: day,
                              label: day,
                            ),
                          )
                          .toList(),
                    ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    if (workoutsData.workouts
                        .containsKey(currentWorkoutData.workoutDayName))
                      ...workoutsData
                          .workouts[currentWorkoutData.workoutDayName]!
                          .map(
                        (exercise) => ListTile(
                          title: Text(exercise.title),
                          trailing: IconButton(
                            onPressed: () {
                              if (exercise.selected) {
                                currentWorkoutData.removeExercise(exercise);
                              } else {
                                currentWorkoutData.addExercise(exercise);
                              }
                              exercise.toggleExercise();
                            },
                            icon: exercise.selected
                                ? Icon(Icons.check)
                                : Icon(Icons.add),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              WideButton(
                  onTap: () {
                    Navigator.of(context).pop(true);
                    Provider.of<AppData>(context, listen: false)
                        .changeNavBarIndex(3);
                    Provider.of<CurrentWorkoutData>(ctx, listen: false)
                        .startWorkout();
                  },
                  title: mode == Mode.start ? 'Start' : 'Add',
                  color: AppColors.workoutColor),
            ],
          ),
        ),
      );
    },
  );
  if (result == null && mode == Mode.start) {
    if (!ctx.mounted) return;
    Provider.of<CurrentWorkoutData>(ctx, listen: false)
        .resetSelectedExercises();
    Provider.of<WorkoutsData>(ctx, listen: false).resetExercises();
  }
}
