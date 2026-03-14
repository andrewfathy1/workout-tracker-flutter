import 'package:flutter/material.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/sleep_manager.dart';
import 'package:gympanion/views/data/user_stats.dart';
import 'package:gympanion/views/pages/activity_browser_page.dart';
import 'package:gympanion/views/widgets/add_sleep_record_form.dart';
import 'package:gympanion/views/widgets/custom_card_element.dart';
import 'package:gympanion/views/widgets/custom_expansion_tile_widget.dart';
import 'package:gympanion/views/widgets/sleep_record_card.dart';
import 'package:gympanion/views/widgets/wide_button.dart';
import 'package:provider/provider.dart';

class SleepPage extends StatelessWidget {
  SleepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                addSleepRecordForm(context);
              },
              icon: Icon(
                Icons.add,
                size: 32,
              )),
        ],
        title: Text('Your Sleep'),
      ),
      body: Consumer<UserStats>(builder: (context, userStats, child) {
        return Column(
          children: [
            userStats.sleepRecords.isNotEmpty
                ? SleepRecordCard(
                    title: 'Last Night',
                    sleepRecord:
                        SleepRecord.fromJson(userStats.sleepRecords.last))
                : SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Center(
                      child: Text(
                        'No sleep records yet!',
                        style: AppTextStyles.titleLarge,
                      ),
                    ),
                  ),
            WideButton(
                onTap: () {
                  addSleepRecordForm(context);
                },
                title: 'Add a record',
                color: Colors.grey),
            userStats.sleepRecords.length >= 2
                ? Expanded(
                    child: CustomCardElement(
                      enableShadow: false,
                      padding: EdgeInsets.all(24),
                      margin: EdgeInsets.only(top: 12),
                      child: SizedBox(
                        child: Column(
                          children: [
                            CustomExpansionTileWidget(
                              title: 'The night before',
                              border: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side:
                                      BorderSide(color: AppColors.cardioColor)),
                              children: [
                                SleepRecordCard(
                                  sleepRecord: SleepRecord.fromJson(
                                      userStats.sleepRecords[
                                          userStats.sleepRecords.length - 2]),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ActivityBrowserPage(
                                    activityType: ActivityType.sleep,
                                  ),
                                ));
                              },
                              child: Text('Show all'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        );
      }),
    );
  }
}
