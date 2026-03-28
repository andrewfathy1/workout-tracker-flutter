import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/cardio/screens/start_cardio_page.dart';
import 'package:gympanion/features/workouts/screens/start_workout_page.dart';
import 'package:gympanion/features/shared/widgets/ongoing_activity_widget.dart';
import 'package:gympanion/features/shared/widgets/wide_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/temp.png',
            height: 250,
          ),
          SizedBox(
            height: 32,
          ),
          OngoingActivityWidget(
            defaultWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WideButton(
                  onTap: () {
                    showStartWorkoutPage(context, Mode.start);
                  },
                  title: 'Start Workout',
                  color: AppColors.workoutColor,
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
                  height: 30,
                ),
                WideButton(
                  onTap: () {
                    showStartCardioPage(context, CardioMode.start);
                  },
                  title: 'Start Cardio',
                  color: AppColors.cardioColor,
                  icon: Image.asset(
                    'assets/images/heart.png',
                  ),
                  icon2: Image.asset(
                    'assets/images/heart.png',
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
