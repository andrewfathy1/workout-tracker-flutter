import 'package:flutter/material.dart';
import 'package:gympanion/views/data/user_stats.dart';
import 'package:gympanion/views/widgets/activity_tile_widget.dart';
import 'package:provider/provider.dart';

enum ActivityType { workout, cardio, sleep }

class ActivityBrowserPage extends StatelessWidget {
  const ActivityBrowserPage({super.key, required this.activityType});

  final ActivityType activityType;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> activityList;
    return Scaffold(
        appBar: AppBar(
          title: Text('Last 90 Days'),
        ),
        body: Consumer<UserStats>(
          builder: (context, userStats, child) {
            activityList = activityType == ActivityType.cardio
                ? userStats.previousCardio
                : activityType == ActivityType.workout
                    ? userStats.previousWorkouts
                    : userStats.sleepRecords;
            return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  itemCount: activityList.length,
                  itemBuilder: (context, index) => ActivityTileWidget(
                      type: activityType,
                      // key: ValueKey(
                      //     activityList[activityList.length - index - 1]['id']),
                      activity: activityList[activityList.length - index - 1]),
                  separatorBuilder: (context, index) => Divider(),
                ));
          },
        ));
  }
}
