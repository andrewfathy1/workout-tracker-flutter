import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/workouts/providers/current_workout_data.dart';
import 'package:gympanion/features/workouts/models/workouts_data.dart';
import 'package:gympanion/features/shared/widgets/counter_widget.dart';
import 'package:provider/provider.dart';

void showEditSetWidget(
    BuildContext ctx, Exercise exercise, int setIndex, ExerciseSet set) {
  Provider.of<CurrentWorkoutData>(ctx, listen: false)
      .setRepEditingValue(EditingValuesKeys.mainRep.key, set.numberOfReps);
  Provider.of<CurrentWorkoutData>(ctx, listen: false)
      .setWeightEditingValue(EditingValuesKeys.mainWeight.key, set.weight);

  bool isDropset1 = set.dropSets.length == 1;
  bool isDropset2 = set.dropSets.length == 2;

  showDialog(
    context: ctx,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black87,
        title: Text(
          'Edit Set',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: EdgeInsets.only(top: 16, right: 16, left: 16),
        insetPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CounterWidget(
                    title: 'Reps',
                    editingValueKey: EditingValuesKeys.mainRep.key,
                    editingValueType: EditingValueType.reps),
                CounterWidget(
                    title: 'Weight',
                    editingValueKey: EditingValuesKeys.mainWeight.key,
                    editingValueType: EditingValueType.weight),
              ],
            ),
            StatefulBuilder(
              builder: (context, setState) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dropset',
                        style: AppTextStyles.titleMedium,
                      ),
                      Checkbox(
                        value: set.isDropSet,
                        onChanged: (value) {
                          setState(
                            () => set.isDropSet = value ?? false,
                          );
                        },
                      ),
                      set.isDropSet
                          ? SizedBox(
                              child: Row(
                                children: [
                                  Text('1x'),
                                  Checkbox(
                                    value: isDropset1,
                                    shape: CircleBorder(),
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          isDropset1 = value ?? false;
                                          isDropset2 = false;
                                          set.dropSets.clear();
                                          set.dropSets.add(ExerciseSet(
                                              numberOfReps: 0, weight: 0));
                                        },
                                      );
                                    },
                                  ),
                                  Text('2x'),
                                  Checkbox(
                                    value: isDropset2,
                                    shape: CircleBorder(),
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          isDropset2 = value ?? false;
                                          isDropset1 = false;
                                          set.dropSets.clear();
                                          set.dropSets.add(ExerciseSet(
                                              numberOfReps: 0, weight: 0));
                                          set.dropSets.add(ExerciseSet(
                                              numberOfReps: 0, weight: 0));
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                  set.isDropSet
                      ? Column(
                          children: set.dropSets
                              .asMap()
                              .entries
                              .map(
                                (e) => Column(children: [
                                  Text('Dropset #${e.key + 1}'),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CounterWidget(
                                            title: 'Sub Reps',
                                            editingValueKey: EditingValuesKeys
                                                    .nonIndexedDropsetReps.key +
                                                (e.key + 1).toString(),
                                            editingValueType:
                                                EditingValueType.reps),
                                      ),
                                      Expanded(
                                        child: CounterWidget(
                                            title: 'Sub Weight',
                                            editingValueKey: EditingValuesKeys
                                                    .nonIndexedDropsetWeight
                                                    .key +
                                                (e.key + 1).toString(),
                                            editingValueType:
                                                EditingValueType.weight),
                                      ),
                                    ],
                                  )
                                ]),
                              )
                              .toList())
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<CurrentWorkoutData>(ctx, listen: false)
                  .editSet(exercise, setIndex, set.isDropSet);
              Navigator.of(ctx).pop();
            },
            child: Text(
              'Save',
              style: AppTextStyles.titleMedium,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(
              'Cancel',
              style: AppTextStyles.titleMedium,
            ),
          ),
        ],
      );
    },
  );
}
