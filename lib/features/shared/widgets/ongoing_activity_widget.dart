import 'package:flutter/material.dart';
import 'package:gympanion/core/app/app_data.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/cardio/providers/current_cardio_data.dart';
import 'package:gympanion/features/workouts/providers/current_workout_data.dart';
import 'package:gympanion/features/shared/widgets/custom_card_element.dart';
import 'package:provider/provider.dart';

class OngoingActivityWidget extends StatelessWidget {
  const OngoingActivityWidget({super.key, this.defaultWidget});

  final Widget? defaultWidget;
  @override
  Widget build(BuildContext context) {
    return Provider.of<CurrentWorkoutData>(context).workoutStarted
        ? InkWell(
            onTap: () {
              Provider.of<AppData>(context, listen: false).changeNavBarIndex(3);
            },
            child: CustomCardElement(
              animate: true,
              color: AppColors.workoutColor.withAlpha(200),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Text(
                  'You have an ongoing workout  ->',
                  style:
                      AppTextStyles.titleLarge.copyWith(color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        : Provider.of<CurrentCardioData>(context).cardioStarted
            ? InkWell(
                onTap: () {
                  Provider.of<AppData>(context, listen: false)
                      .changeNavBarIndex(3);
                },
                child: CustomCardElement(
                  animate: true,
                  color: AppColors.cardioColor.withAlpha(200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Text(
                      'You have an ongoing cardio  ->',
                      style: AppTextStyles.titleLarge
                          .copyWith(color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : defaultWidget ?? SizedBox.shrink();
  }
}
