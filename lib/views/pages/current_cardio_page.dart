import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gympanion/utils/widget_utils.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/current_cardio_data.dart';
import 'package:gympanion/views/pages/activity_browser_page.dart';
import 'package:gympanion/views/widgets/rating_widget.dart';
import 'package:gympanion/views/widgets/timer_widget.dart';
import 'package:gympanion/views/widgets/wide_button.dart';
import 'package:provider/provider.dart';

class CurrentCardioPage extends StatelessWidget {
  const CurrentCardioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentCardioData>(
      builder: (context, currentCardioData, child) => Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Column(
          children: [
            currentCardioData.cardioStarted
                ? TimerWidget(
                    color: AppColors.cardioColor,
                    timerText: CurrentCardioData.timerText)
                : SizedBox.shrink(),
            Spacer(),
            WideButton(
                onTap: () {
                  showDialog(
                    // barrierColor: Colors.amber,
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
                              'You\'ve successfully finished your ${currentCardioData.cardioTitle} in ${currentCardioData.formatTimer(currentCardioData.timeElapsed)}',
                              style: AppTextStyles.bodyLarge,
                            ),
                            Divider(),
                            Text(
                              'How was your Cardio?',
                              style: AppTextStyles.bodyLarge,
                            ),
                            RatingWidget(
                              activityType: ActivityType.cardio,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await Provider.of<CurrentCardioData>(context,
                                      listen: false)
                                  .endCardio();

                              if (!context.mounted) return;
                              showSnackBar(
                                  context, 'Cardio completed 💪', Colors.green);
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
                title: 'End Cardio',
                color: AppColors.cardioColor)
          ],
        ),
      ),
    );
  }
}
