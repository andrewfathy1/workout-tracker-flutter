import 'package:flutter/material.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/current_workout_data.dart';
import 'package:provider/provider.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget(
      {super.key,
      required this.title,
      required this.editingValueKey,
      required this.editingValueType});
  final String title;
  final String editingValueKey;
  final EditingValueType editingValueType;

  @override
  Widget build(BuildContext context) {
    int counter = Provider.of<CurrentWorkoutData>(context, listen: false)
            .editingValues[editingValueKey] ??
        0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white38),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (editingValueType == EditingValueType.reps) {
                          Provider.of<CurrentWorkoutData>(context,
                                  listen: false)
                              .setRepEditingValue(editingValueKey, --counter);
                        }
                        if (editingValueType == EditingValueType.weight) {
                          Provider.of<CurrentWorkoutData>(context,
                                  listen: false)
                              .setWeightEditingValue(
                                  editingValueKey, counter -= 5);
                        }
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(Provider.of<CurrentWorkoutData>(context)
                        .editingValues[editingValueKey]
                        .toString()),
                    IconButton(
                      onPressed: () {
                        if (editingValueType == EditingValueType.reps) {
                          Provider.of<CurrentWorkoutData>(context,
                                  listen: false)
                              .setRepEditingValue(editingValueKey, ++counter);
                        }
                        if (editingValueType == EditingValueType.weight) {
                          Provider.of<CurrentWorkoutData>(context,
                                  listen: false)
                              .setWeightEditingValue(
                                  editingValueKey, counter += 5);
                        }
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
