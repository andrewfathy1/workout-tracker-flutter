import 'package:flutter/material.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/prs/exercise_pr.dart';
import 'package:gympanion/views/widgets/custom_expansion_tile_widget.dart';
import 'package:intl/intl.dart';

class PrViewerPage extends StatelessWidget {
  const PrViewerPage({super.key, required this.exercisePR});

  final ExercisePR exercisePR;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  exercisePR.exerciseName,
                  style: AppTextStyles.displayLarge,
                ),
              ),
              Divider(
                thickness: 5,
              ),
              SizedBox(
                height: 8,
              ),
              CustomExpansionTileWidget(
                title: '1RM',
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        color: Colors.amber,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        exercisePR.oneRM.toString(),
                        style: AppTextStyles.titleLarge
                            .copyWith(color: AppColors.cardioColor),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Achieved on',
                        style: AppTextStyles.titleMedium,
                      ),
                      Text(
                        DateFormat('dd MMM yyyy • h:mm a')
                            .format(exercisePR.oneRMDate ?? DateTime.now()),
                        style: AppTextStyles.titleMedium
                            .copyWith(color: Colors.amber),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              CustomExpansionTileWidget(
                title: 'Volume PR',
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        color: Colors.amber,
                      ),
                      Text(
                        exercisePR.volume.toString(),
                        style: AppTextStyles.titleLarge
                            .copyWith(color: AppColors.cardioColor),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Achieved on',
                        style: AppTextStyles.titleMedium,
                      ),
                      Text(
                        DateFormat('dd MMM yyyy • h:mm a')
                            .format(exercisePR.volumeDate ?? DateTime.now()),
                        style: AppTextStyles.titleMedium
                            .copyWith(color: Colors.amber),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
