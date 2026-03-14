import 'package:flutter/material.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/workouts_data.dart';
import 'package:gympanion/views/widgets/custom_expansion_tile_widget.dart';

class ExerciseSummaryWidget extends StatelessWidget {
  const ExerciseSummaryWidget({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CustomExpansionTileWidget(title: exercise.title, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(
                color: Colors.amber,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: exercise.sets
                      .map(
                        (e) => Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: BoxBorder.all(
                                  color: e.isDone ? Colors.green : Colors.red),
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Text(
                                'Set #${exercise.sets.indexOf(e) + 1}',
                                style: AppTextStyles.titleMedium,
                              ),
                              if (e.dropSets.isNotEmpty)
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.amber),
                                  child: Text('  Dropset  ',
                                      style: AppTextStyles.bodyMedium
                                          .copyWith(color: Colors.black)),
                                ),
                              Text('R:${e.numberOfReps}  |  W:${e.weight}'),
                              if (e.dropSets.isNotEmpty)
                                ...e.dropSets.asMap().entries.map(
                                      (dropset) => Text(
                                          'R:${dropset.value.numberOfReps}  |  W:${dropset.value.weight}'),
                                    ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ]));
  }
}
