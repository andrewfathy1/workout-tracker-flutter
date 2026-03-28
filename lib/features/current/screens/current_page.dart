import 'package:flutter/material.dart';
import 'package:gympanion/core/app/app_data.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/core/data/notifiers.dart';
import 'package:gympanion/features/workouts/screens/current_workout_page.dart';
import 'package:gympanion/features/cardio/screens/current_cardio_page.dart';
import 'package:gympanion/features/shared/widgets/wide_button.dart';
import 'package:provider/provider.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TrainingMode>(
      valueListenable: currentTrainingMode,
      builder: (context, value, child) => value == TrainingMode.workout
          ? CurrentWorkoutPage()
          : value == TrainingMode.cardio
              ? CurrentCardioPage()
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You haven\'t started yet!',
                        style: AppTextStyles.titleMedium
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        'assets/images/temp.png',
                        height: 250,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      WideButton(
                        onTap: () {
                          Provider.of<AppData>(context, listen: false)
                              .changeNavBarIndex(2);
                        },
                        title: 'Start Now!',
                        color: Colors.amber.shade200,
                        icon: Transform.flip(
                          flipX: true,
                          child: Image.asset(
                            'assets/images/strength.png',
                          ),
                        ),
                        icon2: Image.asset(
                          'assets/images/strength.png',
                        ),
                      ),
                      SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                ),
    );
  }
}
