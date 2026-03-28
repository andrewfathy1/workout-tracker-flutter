import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/sleep/providers/sleep_manager.dart';
import 'package:gympanion/features/shared/screens/activity_browser_page.dart';
import 'package:gympanion/features/cardio/screens/cardio_details_page.dart';
import 'package:gympanion/features/workouts/screens/workout_details_page.dart';
import 'package:gympanion/features/sleep/widgets/sleep_record_card.dart';

class ActivityTileWidget extends StatelessWidget {
  const ActivityTileWidget(
      {super.key, required this.activity, required this.type});
  final Map<String, dynamic> activity;
  final ActivityType type;
  @override
  Widget build(BuildContext context) {
    return type != ActivityType.sleep
        ? ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => type == ActivityType.workout
                      ? WorkoutDetailsPage(workoutJSON: activity)
                      : CardioDetailsPage(
                          cardioJSON: activity,
                        ),
                ),
              );
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            tileColor: Colors.black45,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(24)),
            title: Text(
              '${activity['dateFinished']} - ${activity['activityName']}',
              style: AppTextStyles.titleLarge,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          )
        : SleepRecordCard(sleepRecord: SleepRecord.fromJson(activity));
  }
}
