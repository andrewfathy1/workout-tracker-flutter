import 'package:flutter/material.dart';
import 'package:gympanion/extensions/date_time_extension.dart';
import 'package:gympanion/extensions/duration_extension.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/sleep_manager.dart';
import 'package:gympanion/views/data/user_stats.dart';
import 'package:gympanion/views/pages/cardio_details_page.dart';
import 'package:gympanion/views/pages/workout_details_page.dart';
import 'package:gympanion/views/widgets/add_sleep_record_form.dart';
import 'package:gympanion/views/widgets/custom_card_element.dart';
import 'package:gympanion/views/widgets/ongoing_activity_widget.dart';
import 'package:gympanion/views/widgets/sleep_record_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 20),
      child: Consumer<UserStats>(builder: (context, userStats, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomCardElement(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'This Week',
                          style: AppTextStyles.displayMedium,
                        ),
                      ),
                      Text(DateTime.now().getCurrentWeekRange()),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 48),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '🏋 Workouts',
                                  style: AppTextStyles.titleMedium,
                                ),
                                Text(
                                  '🏃 Cardio',
                                  style: AppTextStyles.titleMedium,
                                ),
                                Text(
                                  '😴 Sleep Avg.',
                                  style: AppTextStyles.titleMedium,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  userStats.thisWeekWorkouts.length.toString(),
                                  style: AppTextStyles.titleMedium,
                                ),
                                Text(
                                  userStats.thisWeekCardio.length.toString(),
                                  style: AppTextStyles.titleMedium,
                                ),
                                Text(
                                  userStats.averageSleepThisWeek
                                      .toReadableDuration(),
                                  style: AppTextStyles.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              CustomCardElement(
                dock: Dock.dockLeft,
                margin: EdgeInsets.only(right: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Workouts',
                          style: AppTextStyles.displayMedium,
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Text('Total Sessions: ${userStats.previousWorkoutsCount}',
                          style: AppTextStyles.titleMedium),
                      SizedBox(height: 10),
                      Text('Last Workout: ${userStats.lastWorkoutTitle}',
                          style: AppTextStyles.titleMedium),
                      SizedBox(height: 8),
                      userStats.previousWorkoutsCount != 0
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: userStats.previousWorkoutsCount == 0
                                    ? null
                                    : () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              WorkoutDetailsPage(
                                            workoutJSON:
                                                userStats.previousWorkouts.last,
                                          ),
                                        ));
                                      },
                                child: Text(
                                  'View Details',
                                  style: AppTextStyles.button
                                      .copyWith(color: Color(0xFF5E72EB)),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              CustomCardElement(
                dock: Dock.dockRight,
                margin: EdgeInsets.only(left: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Cardio',
                          style: AppTextStyles.displayMedium,
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Text('Total Sessions: ${userStats.previousCardiosCount}',
                          style: AppTextStyles.titleMedium),
                      SizedBox(height: 10),
                      Text('Last Cardio: ${userStats.lastCardioTitle}',
                          style: AppTextStyles.titleMedium),
                      SizedBox(height: 8),
                      userStats.previousCardiosCount != 0
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: userStats.previousWorkoutsCount == 0
                                    ? null
                                    : () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              CardioDetailsPage(
                                            cardioJSON:
                                                userStats.previousCardio.last,
                                          ),
                                        ));
                                      },
                                child: Text(
                                  'View Details',
                                  style: AppTextStyles.button
                                      .copyWith(color: Color(0xFF5E72EB)),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              CustomCardElement(
                dock: Dock.dockLeft,
                margin: EdgeInsets.only(right: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sleep',
                          style: AppTextStyles.displayMedium,
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      userStats.sleepRecords.isNotEmpty
                          ? Column(
                              children: [
                                Text(
                                  'Last night',
                                  style: AppTextStyles.titleMedium,
                                ),
                                SleepRecordCard(
                                  sleepRecord: SleepRecord.fromJson(
                                      userStats.sleepRecords.last),
                                  backgroundColor: Colors.transparent,
                                ),
                                TextButton(
                                  onPressed: () {
                                    addSleepRecordForm(context);
                                  },
                                  child: Text(
                                    'Add',
                                    style: AppTextStyles.button
                                        .copyWith(color: Color(0xFF5E72EB)),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Center(
                                  child: Text(
                                    'No records yet!',
                                    style: AppTextStyles.titleMedium,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    addSleepRecordForm(context);
                                  },
                                  child: Text(
                                    'Add',
                                    style: AppTextStyles.button
                                        .copyWith(color: Color(0xFF5E72EB)),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80),
              // WideButton(
              //     onTap: () {
              //       try {
              //         final db = FirebaseFirestore.instance;
              //         final WorkoutsData wd = WorkoutsData();
              //         db
              //             .collection("workouts")
              //             .doc('all_workouts')
              //             .set(wd.toJson());
              //       } catch (e) {
              //         print(e);
              //       }
              //     },
              //     title: 'Upload',
              //     color: Colors.purple),

              OngoingActivityWidget(),
            ],
          ),
        );
      }),
    );
  }
}
