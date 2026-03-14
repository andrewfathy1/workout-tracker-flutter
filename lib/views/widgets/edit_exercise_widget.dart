import 'package:flutter/material.dart';
import 'package:gympanion/utils/widget_utils.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/current_workout_data.dart';
import 'package:gympanion/views/data/prs/pr_manager.dart';
import 'package:gympanion/views/data/workouts_data.dart';
import 'package:gympanion/views/widgets/counter_widget.dart';
import 'package:gympanion/views/widgets/edit_set_widget.dart';
import 'package:provider/provider.dart';

void showEditExerciseWidget(BuildContext ctx, Exercise exercise) {
  showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    backgroundColor: Colors.black87,
    showDragHandle: true,
    builder: (context) {
      return Consumer2<CurrentWorkoutData, PRManager>(
        builder: (context, currentWorkoutData, prManager, child) => Container(
          height: MediaQuery.of(ctx).size.height / 1.5,
          width: MediaQuery.of(ctx).size.width,
          padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  exercise.title,
                  style: AppTextStyles.displayMedium,
                ),
                Divider(
                  thickness: 2,
                ),
                exercise.sets.isEmpty
                    ? Text(
                        'You haven\'t added sets yet',
                        style: AppTextStyles.titleMedium,
                      )
                    : SizedBox.shrink(),
                ...exercise.sets.asMap().entries.map(
                      (e) => GestureDetector(
                        onTap: () {
                          // edit set
                          showEditSetWidget(ctx, exercise, e.key, e.value);
                        },
                        child: ListTile(
                          leading: Icon(Icons.remove),
                          title: Text('Set #${e.key + 1}'),
                          subtitle: Row(
                            children: [
                              Text('${e.value.numberOfReps} Reps'),
                              SizedBox(
                                height: 16,
                                child: VerticalDivider(
                                  color: Colors.white,
                                ),
                              ),
                              Text('${e.value.weight}KG'),
                            ],
                          ),
                          trailing: e.value.isDone
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.black,
                                  ),
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          currentWorkoutData.removeSet(
                                              exercise, e.key);
                                        },
                                        icon: Icon(Icons.delete)),
                                    IconButton(
                                        onPressed: () {
                                          currentWorkoutData.markSetAsDone(
                                              exercise, e.key);
                                          prManager.addPRRecordEntry(
                                                      exercise.title,
                                                      exercise.muscleGroup,
                                                      e.value.numberOfReps,
                                                      e.value.weight
                                                          .toDouble()) ==
                                                  true
                                              ? showFlushBar(
                                                  context,
                                                  '🔥 New PR!',
                                                )
                                              : null;
                                        },
                                        icon: Icon(Icons.check)),
                                  ],
                                ),
                        ),
                      ),
                    ),
                Divider(
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CounterWidget(
                      title: 'Reps',
                      editingValueKey: EditingValuesKeys.mainRep.key,
                      editingValueType: EditingValueType.reps,
                    ),
                    CounterWidget(
                      title: 'Weight',
                      editingValueKey: EditingValuesKeys.mainWeight.key,
                      editingValueType: EditingValueType.weight,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    currentWorkoutData.addSetToExercise(exercise);
                  },
                  child: Text('Add set'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
